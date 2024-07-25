module ApplicationHelper
  # def flash_class(key)
  #   case key.to_sym
  #   when :success then "custom-alert-success"
  #   when :error, :alert then "custom-alert-error"
  #   when :notice then "custom-alert-notice"
  #   when :warning then "custom-alert-warning"
  #   else "custom-alert-info"
  #   end
  # end
  #
  # def flash_icon(key)
  #   case key.to_sym
  #   when :success then "fas fa-check-circle"
  #   when :error, :alert then "fas fa-exclamation-circle"
  #   when :notice then "fas fa-info-circle"
  #   when :warning then "fas fa-exclamation-triangle"
  #   else "fas fa-bell"
  #   end
  # end

  def chat_path_with_request_and_user(request, user, current_user_is_requester)
    return new_user_session_path if current_user.nil?
    if current_user_is_requester
      applicant_id = user.id
      requester_id = current_user.id
    else
      applicant_id = current_user.id
      requester_id = user.id
    end

    # Find or create the chat
    chat = Chat.find_or_create_by(
      request_id: request.id,
      applicant_id: applicant_id,
      requester_id: requester_id
    )

    chats_path(chat_id: chat.id)
  end
end
