class PromptsController < ApplicationController

  before_action :get_prompt_from_id, :except => ['index', 'new', 'create']

  before_action :enforce_membership, :only => ['create', 'new']
  before_action :enforce_prompt_ownership, :only => ['edit', 'update', 'delete', 'destroy']

  def index
    selected_sort = Prompt.by_recent  # default ordering
    @prompts = selected_sort.page params[:page]
  end

  # depending on how long the prompt has been alive, this will either show
  # a) the prompt - adding and voting on riffs (for members)
  # b) the prompt, and the top responses
  def show

  end

  # receivers for riffs and votes
  def add_riff

  end

  def vote

  end

  # form for new prompt
  def new

  end

  def create

  end

  # form for editing
  def edit

  end

  def update

  end

  # form for delete
  def delete

  end

  def destroy

  end

  private

    def get_prompt_from_id
      @prompt = Prompt.friendly.find(params[:id])
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
