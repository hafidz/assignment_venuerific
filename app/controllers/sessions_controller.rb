class SessionsController < Devise::SessionsController
  layout 'login'
  def new
    if user_signed_in?
      flash[:notice] = "Anda sedang login"
      return redirect_to root_path
    end
    self.resource = resource_class.new(devise_parameter_sanitizer.sanitize(:sign_in))
    clean_up_passwords(resource)
  end

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    # log_history = LogHistory.new(:user_id => resource.id, :current_sign_in_at => resource.current_sign_in_at, :current_sign_in_ip => resource.current_sign_in_ip)
    # log_history.save    
    return sign_in_and_redirect(resource_name, resource) 
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource

    return redirect_to admin_dashboards_path
  end

end
