module ApplicationHelper
  def authenticated?
    if session[:user_email].blank? 
      session[:requested_url] = request.original_url
      return false
    end
    if session[:user_auth].blank?

      user = User.where(email: session[:user_email]).first

      session[:user_auth] = user && user.email == session[:user_email]
      if session[:user_auth]
        session[:user_id] = user.id
      end
    else
      session[:user_auth]
    end
  end

  def register_authenticated?
    puts session[:register_session]
    puts "-----xxxxx"
    return session[:register_session] == "iniciada"
  end

  def is_department_admin?
    department = Department.where(user_id: current_user.id).first
    department 
  end 

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
