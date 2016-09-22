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
    @novel = Novel.new
    @title = 'New Work'
  end

  # Creates a new work entry
  def create
    if params[:work] && params[:work][:tag_list] && params[:work][:title]
      # Add the work's title to the list of tags
      params[:work][:tag_list].downcase!
      separated_title = params[:work][:title].downcase.split(/\s+/)
      separated_title.each do |tag|
        unless params[:work][:tag_list].include? tag
          params[:work][:tag_list] = params[:work][:tag_list] + ', ' + tag
        end
      end
    end

    @work = Work.new(work_params)
    @work.user = current_user

    if !params[:work][:novel_id].blank?
      @work.novel = Novel.find(params[:work][:novel_id])
    else
      @work.novel = nil
    end

    if @work.save
      send_new_work_notifications(@work) unless @work.is_private
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
    @work = Work.friendly.find(params[:id])
    @title = 'Edit ' + @work.title
  end

  # Updates a previously created work entry
  def update
    if params[:work] && params[:work][:tag_list] && params[:work][:title]
      # Add the work's title to the list of tags
      params[:work][:tag_list].downcase!
      separated_title = params[:work][:title].downcase.split(/\s+/)
      separated_title.each do |tag|
        unless params[:work][:tag_list].include? tag
          params[:work][:tag_list] = params[:work][:tag_list] + ', ' + tag
        end
      end
    end

    @work = Work.friendly.find(params[:id])
    @work.slug = nil

    if !params[:work][:novel_id].blank?
      @work.novel = Novel.find(params[:work][:novel_id])
    else
      @work.novel = nil
    end

    if @work.update(work_params)
      # Inform users who favourited the work that is has been updated
      send_new_update_notifications(@work)
      record_edit_history(@work, current_user)

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
    @work = Work.friendly.find(params[:id])
    unless @work.destroy
      flash[:error] = 'The work could not be deleted.'
    end
    redirect_back_or root_path
  end

  private

  # Parameters required/allowed to create a work entry
  def work_params
    params.require(:work).permit(:title, :body, :tag_list, :incomplete, :is_private, :novel_id)
  end

  # Confirms the user is the owner of the work or an admin
  def check_work_user
    owner = Work.friendly.find(params[:id]).user
    unless owner == current_user || current_user.is_admin?
      store_location
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_to login_path
    end
  end

end
