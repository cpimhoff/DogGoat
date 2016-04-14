class PromptsController < ApplicationController

  before_action :get_prompt_from_id, :except => ['index', 'new', 'create']

  before_action :enforce_membership, :only => ['create', 'new']
  before_action :enforce_prompt_ownership, :only => ['edit', 'update', 'delete', 'destroy']

  def index
    selected_sort = Prompt.by_recent  # default ordering
    if session[:member_id].blank?
      selected_sort = selected_sort.only_closed
    end
    @prompts = selected_sort.page params[:page]
  end

  # depending on how long the prompt has been alive, this will either show
  # a) the prompt - adding and voting on riffs (for members)
  # b) the prompt, and the top responses
  def show
    if @prompt.is_open
      if session[:member_id].present?
        # if the prompt is open and a member is logged in...
        if @prompt.has_member_contributed(session[:member_id])
          # member is eligable to vote
          @ballot = @prompt.voting_selection(session[:member_id])
          render 'show_vote'
        else
          # member should contribute
          render 'show_submit'
        end
      else
        redirect_to prompts_path
      end
    else
      # display current frontrunners
      @winners = @prompt.riffs.limit(3).by_vote
      @winners.each do |w|
        # Update each winner's is_winner property
        unless w.is_winner
          w.is_winner = true
          w.save
        end
      end
      render 'show_results'
    end
  end

  # receivers for riffs and votes
  def add_riff
    if @prompt.has_member_contributed(session[:member_id])
      redirect_to prompts_path(@prompt) # limit one contribution per member
      return
    end

    riff = Riff.new(riff_params)
    riff.author_id = session[:member_id]
    riff.prompt = @prompt
    if riff.save
      flash['msg'] = "Your riff was submitted"
    else
      flash['msg'] = "Something prevented your riff from being submitted"
    end

    redirect_to prompt_path(@prompt)
  end

  def vote
    riff = Riff.find(vote_params[:riff_id])
    if riff.prompt_id == @prompt.id
      riff.votes += 1
      riff.save
    end
    redirect_to prompt_path(@prompt)
  end

  # form for new prompt
  def new
    @prompt = Prompt.new
    @prompt.author_id = session[:member_id]
  end

  def create
    @prompt = Prompt.new(prompt_params)
    @prompt.author_id = session[:member_id]

    if @prompt.save
      flash['msg'] = "Your prompt has been posted"
      redirect_to prompt_path(@prompt)
    else
      render 'new'
    end
  end

  # form for editing
  def edit
  end

  def update
    @prompt.update(prompt_params)
    if @prompt.save
      flash['msg'] = "Your prompt has been updated"
      redirect_to prompt_path(@prompt)
    else
      render 'edit'
    end
  end

  # form for delete
  def delete
  end

  def destroy
    flash['msg'] = "Goodbye forever #{@prompt.title}! We hated you anyway."
    @prompt.destroy
    redirect_to prompts_path
  end

  private

    def get_prompt_from_id
      @prompt = Prompt.friendly.find(params[:id])
    end

    def prompt_params
      params.require('prompt').permit('title','color','text')
    end

    def riff_params
      params.require('riff').permit('content')
    end

    def vote_params
      params.require('vote').permit('riff_id')
    end

    def enforce_membership
      if session[:member_id].blank?
        flash['msg'] = "You have to be a Member to perform this action."
        redirect_to prompts_path
        return
      else
        return
      end
    end

    def enforce_prompt_ownership
      if session[:member_id] == @prompt.author_id
        return
      else
        flash['msg'] = "Only the owner of a prompt can modify it."
        redirect_to prompts_path
        return
      end
    end

end
