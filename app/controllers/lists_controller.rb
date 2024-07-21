class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = current_user.lists
    @selected_list = List.find(params[:id]) if params[:id].present?
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to @list, notice: 'リストが作成されました。'
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:list_title, :description, :song_title, :reading, :key_id, :singer, :link, :remarks, :public)
  end
end
