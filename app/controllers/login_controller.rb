class LoginController < ApplicationController

  #get login/
  def index
    unless session[:member_id].blank?
      # guard statement for users already logged in
      flash['msg'] = "Hey #{session[:member_first_name]}, you're already logged in."
      redirect_to posts_path
    end
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

  #get login/lost_password
  def lost_password
  end

  #post login/lost_password
  def recover_password
    @email = password_recovery_params['email']
    @account = Member.where(email:@email).first
    unless @account.blank?
      new_password = generate_random_password()
      @account.password = new_password
      # email them the new password...
      if @account.save
        flash['msg'] = "Your password was reset and a recovery email has been sent to '#{@email}'"
        redirect_to action: "index"
      else
        flash['msg'] = "Something went wrong with reseting the password of your account. Contact support if this happens again."
        render 'lost_password'
      end
    else
      flash['msg'] = "No account found under that email. Make sure your typing in the full email address."
      render 'lost_password'
    end
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

    def password_recovery_params
      return params.require('account').permit('email')
    end

    def generate_random_password
      alphabet = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 !)
      spice_alphabet = %w(dog goat cat muffin cow dead red hot spice lever jesus christ unicorn self worth hot cold uhoh temp sexy)
      pass = ""
      3.times do
        pass += alphabet[rand(alphabet.count)]
      end
      2.times do
        pass += spice_alphabet[rand(spice_alphabet.count)]
      end
      1.times do
        pass += alphabet[rand(alphabet.count)]
      end
      return pass
    end

end
