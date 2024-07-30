class SongsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list
  before_action :set_song, only: [:destroy, :update, :edit]
  before_action :authorize_user!, only: [:destroy, :update, :edit]

  def search
    query = params[:query].to_s.strip

    if query.present?
      @songs = Song.joins(:list)
                   .where('songs.song_title LIKE ? OR songs.reading LIKE ? OR songs.singer LIKE ? OR songs.remarks LIKE ? OR lists.list_title LIKE ? OR lists.description LIKE ?', 
                          "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
                   .order(Arel.sql("FIELD(songs.song_title, '#{query}') DESC, FIELD(songs.reading, '#{query}') DESC, FIELD(songs.singer, '#{query}') DESC, FIELD(songs.remarks, '#{query}') DESC, FIELD(lists.list_title, '#{query}') DESC, FIELD(lists.description, '#{query}') DESC"))
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
