module ApplicationHelper

  # Returns the index of the 3rd newline of a string (the most lines to show of a preview).
  # Or, if there are less than 3 newlines or the 3rd newline is greater than 255 characters
  # into the string, then return the first 255 characters.
  def length_of_preview(body)
    newline_count = 0
    last_newline = -1
    until newline_count == 3 || last_newline == nil
      last_newline = body.index("\n", last_newline + 1)
      newline_count += 1
    end

    if last_newline == nil || last_newline > 255
      return 255
    else
      return last_newline
    end
  end

end
