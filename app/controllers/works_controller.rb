class WorksController < ApplicationController

  before_filter :authorize, :except => [:index, :search]

  # Lists the most recent works
  def index
    @recent_works = Work.all.order('created_at DESC')
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
  end

  # Creates a new work entry
  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to @work
    else
      flash[:error] = 'An error occured!'
      render 'new'
    end
  end

  private

  # Parameters required/allowed to create a work entry
  def work_params
    params.require(:work).permit(:title, :body, :tag_list, :incomplete)
  end

end
