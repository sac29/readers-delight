class UsersController < ApplicationController
  #before_action :require_login, except: [:sign_up]
  def index
  end

  def login
    user = User.where(email: params[:email]).first
    message = "You are not registered please register" if user.blank?
    if user.present? && user.email == params[:email]
      if user.password == params[:password]
        message = "admin"
        redirect_to '/home'
      else
        message = "Password is wrong"
        redirect_to '/'
      end
    else
      message = "Email Id is wrong"
      redirect_to '/'
    end

  end

  def sign_up
    if params[:name].blank? || params[:email].blank? || params[:password].blank?
      message = "Name, email or password can not be blank"
    else
      user_created = UsersService.new.create_user(params)
      if user_created
        message = "You have successfully registered, Kindly login to continue"
      else
        message = "This email is already taken"
      end
    end

    render(json: { message: message }, status: 200)
  end

end
