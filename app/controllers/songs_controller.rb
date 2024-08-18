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
    if params[:song_title].present?
      @songs = @songs.where('song_title LIKE ?', "%#{params[:song_title]}%")
    end
    if params[:reading].present?
      @songs = @songs.where('reading LIKE ?', "%#{params[:reading]}%")
    end
    if params[:singer].present?
      @songs = @songs.where('singer LIKE ?', "%#{params[:singer]}%")
    end
    if params[:key_id].present? && params[:key_id] != ""
      @songs = @songs.where(key_id: params[:key_id])
    end
    # 2曲目の検索条件を適用
    if params[:song_title_2].present? || params[:reading_2].present? || params[:singer_2].present? || (params[:key_id_2].present? && params[:key_id_2] != "")
      key_condition = params[:key_id_2].present? ? "second_songs.key_id = #{params[:key_id_2]}" : '1=1'
      @songs = @songs.where(
        'EXISTS (SELECT 1 FROM songs second_songs WHERE second_songs.list_id = songs.list_id AND second_songs.song_title LIKE ? AND second_songs.reading LIKE ? AND second_songs.singer LIKE ? AND (' + key_condition + ' OR ? IS NULL))',
        "%#{params[:song_title_2]}%", "%#{params[:reading_2]}%", "%#{params[:singer_2]}%", params[:key_id_2]
      )
    end
    render :search
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
