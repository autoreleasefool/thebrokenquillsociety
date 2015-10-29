class WorksController < ApplicationController

  before_filter :authorize, :except => [:index]

  # Lists the most recent works
  def index
    @recent_works = Work.all.order('created_at DESC')
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
