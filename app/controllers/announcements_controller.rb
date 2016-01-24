class AnnouncementsController < ApplicationController

  # Only allow logged in users to access certain pages
  before_action :logged_in_user, except: :index
  # Only allow the admin to perform certain actions
  before_action :admin_user, except: :index

  # Page to show all old announcements
  def index
    @announcements = Announcement.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    @title = 'Announcements'
  end

  # Form to create a new announcement
  def new
    @announcement = Announcement.new
    @title = 'New announcement'
  end

  # Creates a new announcement entry
  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.user = current_user

    if @announcement.save
      redirect_to root_path
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
    @announcement = Announcement.find(params[:id])
    @title = 'Edit ' + @announcement.title
  end

  # Updates the entry for an announcement
  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update(announcement_params)
      redirect_to root_path
    else
      @announcement_errors = {}
      @announcement.errors.each do |attr, msg|
        @announcement_errors[attr] = msg
      end
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
    params.require(:announcement).permit(:title, :body, :link)
  end

end
