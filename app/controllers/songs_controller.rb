class SongsController < ApplicationController
  before_action :set_list
  before_action :set_song, only: [:destroy]

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

  private

  def set_list
    @list = current_user.lists.find_by(id: params[:list_id])
  end

  def set_song
    @song = @list.songs.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:song_title, :reading, :key_id, :singer, :link, :remarks)
  end
end
