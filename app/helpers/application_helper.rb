module ApplicationHelper
  def trim_column_name_for_validation_error_message(error_message)
    error_message[/(?<= ).+/]
  end
end
