# app/controllers/songs_controller.rb
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
        format.js   # create.js.erb を呼び出す
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
    if params[:query].present?
      query = params[:query]
      @songs = Song.joins(:list)
                   .where('songs.song_title ILIKE :query OR songs.reading ILIKE :query OR songs.singer ILIKE :query OR songs.remarks ILIKE :query OR lists.list_title ILIKE :query OR lists.description ILIKE :query', query: "%#{query}%")
                   .order('similarity(songs.song_title, :query) DESC, similarity(songs.reading, :query) DESC, similarity(songs.singer, :query) DESC, similarity(songs.remarks, :query) DESC, similarity(lists.list_title, :query) DESC, similarity(lists.description, :query) DESC')
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
