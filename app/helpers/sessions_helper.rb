module SessionsHelper

  # Checks for a noauth param in the url
  def check_noauth(no_auth)
    if no_auth == 1
      return true
    end
    return false
  end

end
