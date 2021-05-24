class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.admin_dashboards_path, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
end
