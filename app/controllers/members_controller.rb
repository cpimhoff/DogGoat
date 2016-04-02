class MembersController < ApplicationController

  before_action :get_member_from_id, :except => ['new', 'create']

  def show
    @posts = @member.posts.visible.page params[:page]
  end

  def new
    unless session[:member_id].blank?
      flash['msg'] = "You can't claim an account while logged in!"
      redirect_to posts_path
    else
      @code = params[:claim_code]
      render 'claim'
    end
  end

  def create
    @code = registration_params['claim_code']
    @code.upcase!
    @invite = Invite.where(:claim_code => @code).first

    unless @invite.blank?
      unless @invite.claimed
        if registration_params['password'] == registration_params['password_confirmation']
          # Create a brand new Member account with data from Invite
          @member = Member.new_from_invite(@invite)
          # Set the password (from params)
          @member.password = registration_params['password']
          # Claim the invite (so invite doesn't conflict with Member uniqueness check)
          @invite.claimed = true
          @invite.save
          # Attempt to create Member, then log in
          if (@member.save)
            session[:member_id] = @member.id
            session[:member_first_name] = @member.first_name
            redirect_to edit_member_path(@member)
          else
            # Something bad happened, unclaim the invite
            @invite.claimed = false
            @invite.save

            flash['msg'] = "Hmmm.. Something went wrong creating your account. Contact support if this issue persists. The error was: #{@member.errors.full_messages}"
            render 'claim'
          end
        else
          flash['msg'] = "Your passwords didn't match"
          render 'claim'
        end
      else
        flash['msg'] = "That claim code has already been used!"
        render 'claim'
      end
    else
      flash['msg'] = "The provided code didn't match any in our records."
      render 'claim'
    end
  end

  def edit
    if enforce_this_member
      render 'settings'
    end
  end

  def update
    if enforce_this_member
      if name_params['first_name'] != @member.first_name || name_params['last_name'] != @member.last_name
        @member.update(name_params)
        @member.slug = nil    # change the slug
      end
      if email_params['email'] != @member.email
        @member.update(email_params)
      end
      if password_parmas['password'].present? && password_parmas['old_password'].present?
        if @member.authenticate(password_parmas['old_password']).present?
          @member.update(model_password_parmas)
        else
          flash['msg'] = "That password is incorrect. Prevented password change."
          render 'settings'
          return
        end
      end
      if @member.save
        flash['msg'] = "Your changes were saved."
        session[:member_first_name] = @member.first_name
        redirect_to edit_member_path(@member)  # must redirect, in case the slug changed
      else
        flash['msg'] = "Something prevented your changes from being saved"
        render 'settings'
      end
    end
  end

  private

    def get_member_from_id
      @member = Member.friendly.find(params[:id])
    end

    def registration_params
      params.require('account').permit('claim_code', 'password', 'password_confirmation')
    end

    def name_params
      params.require('member').permit('first_name', 'last_name')
    end

    def email_params
      params.require('member').permit('email', 'email_confirmation')
    end

    def password_parmas
      params.require('member').permit('old_password', 'password', 'password_confirmation')
    end
    def model_password_parmas
      params.require('member').permit('password', 'password_confirmation')
    end

    def enforce_this_member
      if session[:member_id].blank?
        redirect_to login_path
        return
      end
      unless @member.id == session[:member_id]
        redirect_to posts_path
        return false
      else
        return true
      end
    end

end
