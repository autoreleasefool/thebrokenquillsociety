class ErrorsController < ApplicationController

  # Displays the error page pertinent to the error code
  def show
    render status_code.to_s, :status => status_code
  end

protected

  # Gets the error code, or returns 500 for internal error if no code is available
  def status_code
    params[:code] || 500
  end

end
