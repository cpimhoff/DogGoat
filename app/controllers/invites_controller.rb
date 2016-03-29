class InvitesController < ApplicationController

  before_action :enforce_membership
  before_action :get_member_from_session

  before_action :enforce_has_invites_to_send, only: ['new', 'create']

  before_action :get_invite_from_id, except: ['index', 'new', 'create']
  before_action :enforce_invite_ownership, except: ['index', 'new', 'create']

  def index
    @invites = @member.invites
  end

  def new
    @invite = Invite.new
    @invite.owner = @member
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.claim_code = Invite.generate_code
    @invite.owner = @member
    @invite.claimed = false

    if @invite.save
      @member.invites_left -= 1
      @member.save
      flash['msg'] = "Your invite has been saved and will be sent to '#{@invite.email}'. You have #{@member.invites_left} #{"invite".pluralize(@member.invites_left)} left."
      redirect_to invites_path
    else
      flash['msg'] = "Something went wrong. Correct any errors and try again."
      render 'new'
    end
  end

  def edit
  end

  def update
    @invite.update(invite_params)
    if @invite.save
      flash['msg'] = "Your invite was updated and an updated email will be sent to '#{@invite.email}'."
      redirect_to invites_path
    else
      flash['msg'] = "Something went wrong. Correct any errors and try again."
      render 'edit'
    end
  end

  def destroy
    flash['msg'] = "The invite has been rescinded."
    @invite.destroy
    redirect_to invites_path
  end

  private

    def invite_params
      params.require('invite').permit('email', 'email_confirmation', 'first_name', 'last_name')
    end

    def enforce_membership
      if session[:member_id].blank?
        redirect_to login_path
        return
      end
    end

    def get_member_from_session
      @member = Member.find(session[:member_id])
    end

    def get_invite_from_id
      @invite = Invite.find(params[:id])
    end

    def enforce_invite_ownership
      if @invite.owner_id != @member.id
        flash['msg'] = "You can't edit other member's invites"
        redirect_to invites_path
        return
      end
    end

    def enforce_has_invites_to_send
      unless @member.invites_left >= 1
        flash['msg'] = "You don't have any invites to send."
        redirect_to invites_path
        return
      end
    end

end
