class CommentsController < ApplicationController

  # Ensure user account has been authenticated
  before_action :authenticate_user!
  # Only allow logged in users to access certain pages
  before_action :logged_in_user, only: :create
  # Only allow the original user or admin to perform certain actions
  before_action :check_comment_user, only: :destroy

  # Create a new comment entry for the work
  def create
    @work = Work.find(params[:work_id])
    @comment = @work.comments.create(params[:comment].permit(:body))
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Your comment was saved'
    else
      flash[:error] = 'Your comment could not be saved.'
    end
    redirect_to work_path(@work)
  end

  # Deletes a comment
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = 'The comment was successfully deleted.'
    else
      flash[:error] = 'The comment could not be deleted.'
    end
    redirect_to work_path(Work.find(params[:work_id]))
  end

  private

  # Confirms the user is the owner of the comment or an admin
  def check_comment_user
    owner = Comment.find(params[:id]).user
    unless owner == current_user || current_user.is_admin?
      store_location
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_to login_path
    end
  end

end
