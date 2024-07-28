class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :destroy]

  def index
    @lists = List.all
    if params[:id].present?
      @selected_list = List.find(params[:id])
      @comments = @selected_list.comments.order(created_at: :desc)
    else
      @selected_list = nil
      @comments = []
    end
  end

  def show
    @songs = @list.songs
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: 'リストが削除されました。'
  end

  private

  def set_list
    @list = List.find_by(id: params[:id])
    redirect_to lists_path, alert: 'リストが見つかりません' unless @list
  end
end
