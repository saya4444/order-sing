class SongsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:create, :destroy, :update, :edit]
  before_action :set_song, only: [:destroy, :update, :edit]
  before_action :authorize_user!, only: [:destroy, :update, :edit]

  def create
    if @list.nil?
      respond_to do |format|
        format.html { redirect_to lists_path, alert: 'リストが見つかりませんでした。' }
        format.js { render js: "alert('リストが見つかりませんでした。');" }
      end
      return
    end

    @song = @list.songs.new(song_params)
    if @song.save
      respond_to do |format|
        format.html { redirect_to lists_path(id: @list.id), notice: '曲が追加されました。' }
        format.js   # create.js.erb を呼び出します
      end
    else
      respond_to do |format|
        format.html { render 'lists/index' }
        format.js   # エラーメッセージを表示するためのJSファイルを作成する場合
      end
    end
  end

  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to lists_path(id: @list.id), notice: '曲が削除されました。' }
      format.js   # destroy.js.erb を呼び出します
    end
  end

  def search
    @songs = Song.all
  
    # 1曲目の検索条件を適用
    @songs = @songs.where('song_title LIKE ?', "%#{params[:song_title]}%") if params[:song_title].present?
    @songs = @songs.where('reading LIKE ?', "%#{params[:reading]}%") if params[:reading].present?
    @songs = @songs.where('singer LIKE ?', "%#{params[:singer]}%") if params[:singer].present?
    @songs = @songs.where(key_id: params[:key_id]) if params[:key_id].present? && params[:key_id] != ""
  
    Rails.logger.debug("検索条件: #{params.inspect}")
  
    # 2曲目の情報を取得
    @songs_with_second_song = @songs.map do |song|
      second_song_query = Song.where(list_id: song.list_id)
                              .where('song_title LIKE ?', "%#{params[:song_title_2]}%") if params[:song_title_2].present?
                              .where('reading LIKE ?', "%#{params[:reading_2]}%") if params[:reading_2].present?
                              .where('singer LIKE ?', "%#{params[:singer_2]}%") if params[:singer_2].present?
                              .where('key_id = ?', params[:key_id_2]) if params[:key_id_2].present? && params[:key_id_2] != ""
                              .first
  
      Rails.logger.debug("2曲目の検索結果: #{second_song_query.inspect}")
  
      # 曲と2曲目の情報を含むハッシュを作成
      {
        song: song,
        second_song: second_song_query
      }
    end
  end



  private

  def set_list
    @list = current_user.lists.find_by(id: params[:list_id])
  end

  def set_song
    @song = @list.songs.find(params[:id])
  end

  def authorize_user!
    redirect_to lists_path, alert: '権限がありません' unless @list.user == current_user
  end

  def song_params
    params.require(:song).permit(:song_title, :reading, :key_id, :singer, :link, :remarks)
  end
end
