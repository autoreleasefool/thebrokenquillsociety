class WorksController < ApplicationController

  before_filter :authorize, :except => [:index, :search]

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

  # Displays the contents of a single work
  def show
    @work = Work.find(params[:id])
  end

  # Form to submit a new work
  def new
    @work = Work.new
  end

  # Form to edit a previously submitted work
  def edit
    @work = Work.find(params[:id])
  end

  # Creates a new work entry
  def create
    @work = Work.new(work_params)
    @work.user = current_user
    if @work.save
      redirect_to @work
    else
      flash[:error] = 'An error occured!'
      render 'new'
    end
  end

  # Updates a previously created work entry
  def update
    @work = Work.find(params[:id])

    if @work.update(params[:work].permit(:title, :body, :tag_list, :incomplete))
      redirect_to @work
    else
      render 'edit'
    end
  end

  # Deletes a single work
  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    redirect_to root_path
  end

  private

  # Parameters required/allowed to create a work entry
  def work_params
    params.require(:work).permit(:title, :body, :tag_list, :incomplete)
  end

end
