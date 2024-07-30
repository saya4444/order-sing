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
    query = params[:query]

    if query.present?
      @songs = Song.joins(:list)
                   .where('
                     songs.song_title COLLATE utf8_general_ci LIKE :query OR
                     songs.reading COLLATE utf8_general_ci LIKE :query OR
                     songs.singer COLLATE utf8_general_ci LIKE :query OR
                     songs.remarks COLLATE utf8_general_ci LIKE :query OR
                     lists.list_title COLLATE utf8_general_ci LIKE :query OR
                     lists.description COLLATE utf8_general_ci LIKE :query',
                     query: "%#{query}%")
                   .order(Arel.sql(
                     "CASE WHEN songs.song_title COLLATE utf8_general_ci LIKE '%#{query}%' THEN 1 ELSE 0 END DESC, " \
                     "CASE WHEN songs.reading COLLATE utf8_general_ci LIKE '%#{query}%' THEN 1 ELSE 0 END DESC, " \
                     "CASE WHEN songs.singer COLLATE utf8_general_ci LIKE '%#{query}%' THEN 1 ELSE 0 END DESC, " \
                     "CASE WHEN songs.remarks COLLATE utf8_general_ci LIKE '%#{query}%' THEN 1 ELSE 0 END DESC, " \
                     "CASE WHEN lists.list_title COLLATE utf8_general_ci LIKE '%#{query}%' THEN 1 ELSE 0 END DESC, " \
                     "CASE WHEN lists.description COLLATE utf8_general_ci LIKE '%#{query}%' THEN 1 ELSE 0 END DESC"
                   ))
    else
      @songs = Song.none
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
