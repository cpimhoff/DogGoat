class MembersController < ApplicationController

  before_action :get_member_from_id, :except => ['claim', 'create']

  def show
    @posts = @member.posts.page params[:page]
  end

  def claim
    unless session[:member_id].blank?
      flash['msg'] = "You can't claim an account while logged in!"
      redirect_to posts_path
    else
      @code = params[:claim_code]
    end
  end

  def create
    @code = registration_params['claim_code']
    @invite = Invite.where(:claim_code => @code).first

    unless @invite.blank?
      unless @invite.claimed
        if registration_params['password'] == registration_params['password_confirmation']
          # Create a brand new Member account with data from Invite
          @member = Member.new_from_invite(@invite)
          # Set the password (from params)
          @member.password = registration_params['password']
          # If all went well claim the invite, log them in, and redirect to their settings
          if (@member.save)
            session[:member_id] = @member.id
            session[:member_first_name] = @member.first_name
            @invite.claimed = true
            @invite.save
            redirect_to edit_member_path(@member)
          else
            flash['msg'] = "Hmmm.. Something went wrong creating your account. Contact support if this issue persists."
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

    end
  end

  private

    def get_member_from_id
      @member = Member.friendly.find(params[:id])
    end

    def registration_params
      params.require('account').permit('claim_code', 'password', 'password_confirmation')
    end

    def enforce_this_member
      if session[:member_id].blank?
        redirect_to login_path
      end
      unless @member.id == session[:member_id]
        redirect_to posts_path
        return false
      else
        return true
      end
    end

end
