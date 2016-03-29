class InvitesController < ApplicationController

  before_action :enforce_membership
  before_action :get_member_from_session

  before_action :get_invite_from_id, except: ['index', 'new', 'create']
  before_action :enforce_invite_ownership, except: ['index', 'new', 'create']

  def index
    @invites = @member.invites
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

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

end
