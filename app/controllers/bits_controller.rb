class BitsController < ApplicationController

  before_action :get_bit_from_id, only: ['edit', 'update', 'delete', 'destroy']

  before_action :enforce_membership, :only => ['create', 'new']
  before_action :enforce_bit_ownership, :only => ['edit', 'update', 'delete', 'destroy']

  def index
    @bits = Bit.by_recent.page params[:page]
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private

    def get_bit_from_id
      @bit = Bit.find(params[:id])
    end

    def enforce_membership
      if session[:member_id].blank?
        flash['msg'] = "You have to be a Member to perform this action."
        redirect_to bits_path
        return
      else
        return
      end
    end

    def enforce_prompt_ownership
      if session[:member_id] == @bit.author_id
        return
      else
        flash['msg'] = "Only the owner of a bit can modify it."
        redirect_to bits_path
        return
      end
    end

end
