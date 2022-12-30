class ApplicationController < ActionController::Base
  
  
  
  def after_sign_out_path_for(resource)
    case resource
    when :admin   # ログアウト時はシンボルが返ってくる
      new_admin_session_path
    when :user  # ログアウト時はシンボルが返ってくる
      root_path
    end
  end 
  
end
