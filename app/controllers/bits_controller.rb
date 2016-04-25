class BitsController < ApplicationController

  before_action :get_bit_from_id, only: ['upvote', 'edit', 'update', 'delete', 'destroy']

  before_action :enforce_membership, :only => ['create', 'new']
  before_action :enforce_bit_ownership, :only => ['edit', 'update', 'delete', 'destroy']

  def index
    @bits = Bit.by_time_score.page params[:page]
  end

  def upvote
    @bit.upvote
    @bit.save
    if request.xhr?
      render json: { bit_id: @bit.id }
    else
      redirect_to bits_path
    end
  end

  def new
    @bit = Bit.new
    @bit.author = Member.find(session[:member_id])
  end

  def create
    @bit = Bit.new(bit_params)
    @bit.author = Member.find(session[:member_id])
    @bit.time_score = Time.now
    if @bit.save
      flash['msg'] = "Your bit was posted."
      redirect_to bits_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @bit.update(bit_params)
    if @bit.save
      flash['msg'] = "Your bit was updated."
      redirect_to bits_path
    else
      render 'edit'
    end
  end

  def delete
  end

  def destroy
    flash['msg'] = "That bit has been killed! We hated it anyway."
    @bit.destroy
    redirect_to bits_path
  end

  private

    def get_bit_from_id
      @bit = Bit.find(params[:id])
    end

    def bit_params
      params.require('bit').permit('color', 'raw_content')
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

    def enforce_bit_ownership
      if session[:member_id] == @bit.author_id
        return
      else
        flash['msg'] = "Only the owner of a bit can modify it."
        redirect_to bits_path
        return
      end
    end

end
