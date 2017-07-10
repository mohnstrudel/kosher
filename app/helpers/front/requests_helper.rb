module Front::RequestsHelper

  # helpers/requests_helper.rb
  # Returns a dynamic path based on the provided parameters
  def sti_request_path(type = "request", request = nil, action = nil)
    send "#{format_sti(action, type, request)}_path", request
  end

  def format_sti(action, type, request)
    action || request ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end
end
