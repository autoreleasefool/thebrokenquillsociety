class AnnouncementsController < ApplicationController

  # Only allow logged in users to access certain pages
  before_action :logged_in_user
  # Only allow the admin to perform certain actions
  before_action :admin_user

  # Form to create a new announcement
  def new
    @announcment = Announcement.new
  end

  # Creates a new announcement entry
  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.user = current_user

    if @announcement.work
      redirect_to @announcement
    else
      @announcement_errors = {}
      @announcement.errors.each do |attr, msg|
        @announcement_errors[attr] = msg
      end
      render 'new'
    end
  end

  # Form to update an announcement
  def edit
    @announcment = Announcement.find(params[:id])
  end

  # Updates the entry for an announcement
  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update(announcement_params)
      redirect_to @announcement
    else
      render 'edit'
    end
  end

  # Deletes a single announcement
  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    redirect_to root_path
  end

  private

  # Parameters required/allowed to create an announcement
  def announcement_params
    params.require(:announcement).permit(:title, :body)
  end

end
