class CommentsController < ApplicationController

  # Only allow logged in users to access certain pages
  before_action :logged_in_user, only: :create
  # Only allow the original user or admin to perform certain actions
  before_action :correct_user, only: :destroy

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

  # Deletes a comment
  def destroy
    @comment = Comment.find(params[:comment_id])

    # TODO: check for admin
    # TODO: redirect to page with errors if not
    # TODO: show succesful delete
    if current_user = @comment.user
      @comment.destroy
    end
  end

end
