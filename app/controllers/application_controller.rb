class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def append_info_to_payload(payload)
    super
    payload[:user_id] = if current_user.present?
      current_user.try(:id)
    else
      :guest
    end
  end

end
