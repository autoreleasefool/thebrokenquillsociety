class CommentsController < ApplicationController

  # Create a new comment entry for the work
  def create
    @work = Work.find(params[:work_id])
    @comment = @work.comments.create(params[:comment].permit(:body))
    @comment.user = current_user

    # TODO: show error if comment cannot be saved?
    @comment.save

    redirect_to work_path(@work)
  end
end
