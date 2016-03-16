class LoginController < ApplicationController

  #get login/
  def index
  end

  #post login/
  def login
    unless session[:member_id].blank?
      # guard statement for users already logged in
      flash['msg'] = "Hey #{session[:member_first_name]}, you're already logged in."
      redirect_to posts_path
    end

    @member = Member.where(email:login_params['email']).first
    if @member != nil
      if @member.authenticate(login_params['password'])

        session[:member_id] = @member.id
        session[:member_first_name] = @member.first_name

        flash['msg'] = "Welcome back #{@member.first_name}!"
        redirect_to posts_path
        return
      else
        flash.now['msg'] = "Your email or password doesn't match our records"
      end
    else
      flash.now['msg'] = "We couldn't find a Member with that email"
    end

    # Retry the form, preserve the email address
    @email = login_params['email']
    render(:index)
  end

  #get logout/
  def logout
    unless session[:member_id].blank?
      flash['msg'] = "You have been successfully logged out"
    end
    session[:member_id] = nil
    redirect_to posts_path
  end

  private

    def login_params
      return params.require('credentials').permit('email','password')
    end

end
