class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

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

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to lists_path, notice: 'リストが作成されました。'
    else
      render :new
    end
  end

  def edit
    # editアクションはauthorize_user!コールバックで制御されます
  end

  def update
    if @list.update(list_params)
      redirect_to lists_path(id: @list.id), notice: 'リストが更新されました。'
    else
      render :edit
    end
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

  def authorize_user!
    redirect_to lists_path, alert: '権限がありません。' unless @list.user == current_user
  end

  def list_params
    params.require(:list).permit(:list_title, :description)
  end
end
