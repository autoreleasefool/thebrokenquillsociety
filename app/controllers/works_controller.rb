class WorksController < ApplicationController

  # Only allow logged in users to access certain pages
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  # Only allow the original user or admin to perform certain actions
  before_action :correct_user, only: [:edit, :update]
  # Only allow the admin to perform certain actions
  before_action :admin_user, only: :destroy

  # Displays the contents of a single work
  def show
    @work = Work.find(params[:id])
  end

  # Displays the user's search results
  def search
    @work_search_results = nil
    @user_search_results = nil

    if params.has_key?(:q) && params[:q].length > 0
      searchKeys = params[:q].split
      @work_search_results = Work.tagged_with(searchKeys, :any => true, :order_by_matching_tag_count => true)
      @user_search_results = User.tagged_with(searchKeys, :any => true, :order_by_matching_tag_count => true)
    else
      @work_search_results = Work.all.order('created_at DESC')
      @user_search_results = User.all.order('created_at DESC')
    end
  end

  # Form to submit a new work
  def new
    @work = Work.new
  end

  # Creates a new work entry
  def create
    @work = Work.new(work_params)
    @work.user = current_user

    if @work.save
      redirect_to @work
    else
      @work_errors = {}
      @work.errors.each do |attr, msg|
        @work_errors[attr] = msg
      end
      render 'new'
    end
  end

  # Form to edit a previously submitted work
  def edit
    @work = Work.find(params[:id])
  end

  # Updates a previously created work entry
  def update
    @work = Work.find(params[:id])

    # TODO: add check for admin status
    # TODO: show successful update
    if current_user == @work.user
      if @work.update(work_params)
        redirect_to @work
      else
        render 'edit'
      end
    else
      @work_not_owner = true
    end
  end

  # Deletes a single work
  def destroy
    @work = Work.find(params[:id])

    # TODO: redirect to same page and show errors
    # TODO: add check for admin status
    # TODO: show successful delete
    if current_user == @work.user
      @work.destroy
    end
    redirect_to root_path
  end

  private

  # Parameters required/allowed to create a work entry
  def work_params
    params.require(:work).permit(:title, :body, :tag_list, :incomplete)
  end

end
