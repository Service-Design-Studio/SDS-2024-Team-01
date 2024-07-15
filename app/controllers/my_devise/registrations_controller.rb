# app/controllers/my_devise/registrations_controller.rb
class MyDevise::RegistrationsController < Devise::RegistrationsController
  def choose_register_method
  end

  def create
    # add custom create logic here
    build_resource(sign_up_params)
    puts sign_up_params

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

  end
end 
