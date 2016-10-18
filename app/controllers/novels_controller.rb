class NovelsController < ApplicationController

  # Only allow logged in users to access certain pages
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  # Only allow the original user or admin to perform certain actions
  before_action :check_novel_user, only: [:edit, :update, :destroy]

  # Displays the contents of a single novel
  def show
    @novel = Novel.friendly.find(params[:id])
    @title = @novel.title
  end

  # Form to submit a new novel
  def new
    @novel = Novel.new
    @works = current_user.works.where(is_private: false).where(is_anonymous: false).order('title')
    @title = 'New Novel'
  end

  # Creates a new novel entry
  def create
    if params[:novel] && params[:novel][:tag_list] && params[:novel][:title]
      # Add the novel's title to the list of tags
      params[:novel][:tag_list].downcase!
      separated_title = params[:novel][:title].downcase.split(/\s+/)
      separated_title.each do |tag|
        unless params[:novel][:tag_list].include? tag
          params[:novel][:tag_list] = params[:novel][:tag_list] + ', ' + tag
        end
      end
    end

    @novel = Novel.new(novel_params)
    @novel.user = current_user

    workIds = []
    workIndex = 1
    loop do
      workKey = 'work-dropdown-' + workIndex.to_s
      if params.key?(workKey) && !params[workKey].blank?

        # Get the chapter and add it to the list of work ids, so long as the chapter exists and belongs to the user
        if chapter = Work.where(id: params[workKey]).first
          unless chapter.user != current_user
            workIds << params[workKey]
            @novel.works << chapter
          end
        end
        workIndex += 1
      else
        break
      end
    end
    @novel.chapter_order = workIds.join(',')

    if @novel.save
      send_new_novel_notifications(@novel)
      redirect_to @novel
    else
      @novel_errors = {}
      @novel.errors.each do |attr, msg|
        @novel_errors[attr] = msg
      end
      @works = current_user.works.where(is_private: false).order('title')
      render 'new'
    end
  end

  # Form to edit a previously submitted novel
  def edit
    @novel = Novel.friendly.find(params[:id])
    @works = current_user.works.where(is_private: false).order('title')
    @title = 'Edit ' + @novel.title
  end

  # Updates a previously created novel entry
  def update
    if params[:novel] && params[:novel][:tag_list] && params[:novel][:title]
      # Add the novel's title to the list of tags
      params[:novel][:tag_list].downcase!
      separated_title = params[:novel][:title].downcase.split(/\s+/)
      separated_title.each do |tag|
        unless params[:novel][:tag_list].include? tag
          params[:novel][:tag_list] = params[:novel][:tag_list] + ', ' + tag
        end
      end
    end

    @novel = Novel.friendly.find(params[:id])
    @novel.slug = nil
    @novel.works = []

    workIds = []
    workIndex = 1
    loop do
      workKey = 'work-dropdown-' + workIndex.to_s
      if params.key?(workKey) && !params[workKey].blank?

        # Get the chapter and add it to the list of work ids, so long as the chapter exists and belongs to the user
        if chapter = Work.where(id: params[workKey]).first
          unless chapter.user != current_user
            workIds << params[workKey]
            @novel.works << chapter
          end
        end
        workIndex += 1
      else
        break
      end
    end
    @novel.chapter_order = workIds.join(',')

    if @novel.update(novel_params)
      # Inform users who favourited the novel that is has been updated
      # send_new_update_notifications(@novel)
      # record_edit_history(@novel, current_user)

      flash[:success] = 'The novel was successfully edited.'
      redirect_to @novel
    else
      @novel_errors = {}
      @novel.errors.each do |attr, msg|
        @novel_errors[attr] = msg
      end
      render 'edit'
    end
  end

  # Deletes a single novel
  def destroy
    @novel = Novel.friendly.find(params[:id])
    unless @novel.destroy
      flash[:error] = 'The novel could not be deleted.'
    end
    redirect_back_or root_path
  end

  private

  # Parameters required/allowed to create a novel entry
  def novel_params
    params.require(:novel).permit(:title, :description, :tag_list)
  end

  # Confirms the user is the owner of the novel or an admin
  def check_novel_user
    owner = Novel.friendly.find(params[:id]).user
    unless owner == current_user || current_user.is_admin?
      store_location
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_to login_path
    end
  end

end
