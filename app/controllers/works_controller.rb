class WorksController < ApplicationController

  before_filter :authorize, :except => [:index]

  # Lists the most recent works
  def index
  end

  # Creates a new work
  def new
  end

end
