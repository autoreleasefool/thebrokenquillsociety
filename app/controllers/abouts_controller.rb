class AboutsController < ApplicationController

  # Ensure user account has been authenticated
  before_action :authenticate_user!, except: :about
  # Only allowed logged in users to perform some actions
  before_action :logged_in_user, except: :about
  # Only allowed admins to perform some actions
  before_action :admin_user, except: :about

  # Show the about page
  def about
    @abouts = About.all.order('created_at')
    @admins = User.where(is_admin: true).order('name')
  end

  # Form to create a new section in the about page
  def new
    @about = About.new
  end

  # Creates a new entry in the about model
  def create
    @about = About.new(about_params)
    if @about.save
      flash[:success] = 'About section was successfully added.'
      redirect_to about_club_path
    else
      @about_errors = {}
      @about.errors.each do |attr, msg|
        @about_errors[attr] = msg
      end
      render 'new'
    end
  end

  # Form to edit an about section
  def edit
    @about = About.find(params[:id])
  end

  # Updates an entry in the about model
  def update
    @about = About.find(params[:id])
    if @about.update(about_params)
      flash[:success] = 'About section was successfully updated.'
      redirect_to about_club_path
    else
      @about_errors = {}
      @about.errors.each do |attr, msg|
        @about_errors[attr] = msg
      end
      render 'edit'
    end
  end

  # Deletes an entry from the about model
  def destroy
    about = About.find(params[:id])
    if about.destroy
      flash[:success] = 'About section was successfully deleted.'
    else
      flash[:error] = 'About section could not be deleted.'
    end
    redirect_to about_club_path
  end

  private

  def about_params
    params.require(:about).permit(:title, :body, :link, :link_title)
  end

end
