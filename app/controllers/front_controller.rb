class FrontController < ApplicationController
  layout 'front' 

  before_action :force_blank_request_format_to_html

  rescue_from ActionView::MissingTemplate do |exception|
    logger.debug "Missing template detected for path:"
    logger.debug exception.path
    # use exception.path to extract the path information
    # This does not work for partials
  end

  private

  def force_blank_request_format_to_html
    if request[:format].blank? 
      request.format = :html 
    end
  end 
end
