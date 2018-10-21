class UsersService

  def create_user(params)
    user = User.where(email: params[:email]).first
    return false if user.present?
    user = User.new
    user.name     = params[:name]
    user.email    = params[:email]
    user.gender   = params[:gender]
    user.mobile   = params[:mobile]
    user.password = params[:password]
    user.save!
    session[:user_id] = user.id
    return true
  end

end
