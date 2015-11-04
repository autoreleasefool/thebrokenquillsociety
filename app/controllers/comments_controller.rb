class CommentsController < ApplicationController

  # Create a new comment entry for the work
  def create
    @work = Work.find(params[:work_id])
    @comment = @work.comments.create(params[:comment].permit(:body))
    @comment.user = current_user

    if @comment.save
      redirect_to work_path(@work)
    else
      redirect_to controller: 'works', action: 'show', id: params[:work_id], error: '1'
    end
  end
end
