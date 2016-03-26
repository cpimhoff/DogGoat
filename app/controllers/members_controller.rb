class MembersController < ApplicationController

  before_action :get_member_from_id, :except => ['claim', 'register']

  def show
    @posts = @member.posts.page params[:page]
  end

  def new
    render 'claim'
  end

  def create
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
