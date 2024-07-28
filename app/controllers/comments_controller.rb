class CommentsController < ApplicationController
  before_action :set_list

  def create
    @comment = @list.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to lists_path(id: @list.id), notice: 'コメントが投稿されました。'
    else
      redirect_to lists_path(id: @list.id), alert: 'コメントの投稿に失敗しました。'
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
