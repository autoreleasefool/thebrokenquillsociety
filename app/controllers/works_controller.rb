class WorksController < ApplicationController

  # Only allow logged in users to access certain pages
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  # Only allow the original user or admin to perform certain actions
  before_action :check_work_user, only: [:edit, :update, :destroy]

  # Displays the contents of a single work
  def show
    @work = Work.friendly.find(params[:id])
    @title = @work.title
  end

  # Form to submit a new work
  def new
    @work = Work.new
    @title = 'New Work'
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
    @title = 'Edit ' + @work.title
  end

  # Updates a previously created work entry
  def update
    @work = Work.find(params[:id])

    if @work.update(work_params)
      flash[:success] = 'The work was successfully edited.'
      redirect_to @work
    else
      @work_errors = {}
      @work.errors.each do |attr, msg|
        @work_errors[attr] = msg
      end
      render 'edit'
    end
  end

  # Deletes a single work
  def destroy
    @work = Work.find(params[:id])
    unless @work.destroy
      flash[:error] = 'The work could not be deleted.'
    end
    redirect_back_or root_path
  end

  private

  # Parameters required/allowed to create a work entry
  def work_params
    params.require(:work).permit(:title, :body, :tag_list, :incomplete)
  end

  # Confirms the user is the owner of the work or an admin
  def check_work_user
    owner = Work.find(params[:id]).user
    unless owner == current_user || current_user.is_admin?
      store_location
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_to login_path
    end
  end

end
