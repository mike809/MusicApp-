module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Music App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def flash_msg(errors, type = :errors)
    error_array = []
    if errors.is_a?(Array)
      error_array.concat(errors)
    else
      error_array << errors
    end
    
    flash[type] ||= []
    flash[type].concat(error_array)
  end
  
  def flash_now(errors, type = :errors)
    error_array = []
    if errors.is_a?(Array)
      error_array.concat(errors)
    else
      error_array << errors
    end
    
    flash.now[type] ||= []
    flash.now[type].concat(error_array)
  end
end