class PostsController < ApplicationController

  before_action :get_post_from_id, :except => ['index','search','new','create']

  # Read
  def index
    selected_scope = Post.by_hot # default scope is 'hot'

    sort_type = params[:sort_by]
    unless sort_type.blank?
      case sort_type.downcase
      when "hot"
        selected_scope = Post.by_hot
      when "cold"
        selected_scope = Post.by_cold
      when "recent"
        selected_scope = Post.by_recent
      when "featured"
        selected_scope = Post.featured.by_recent
      end
    end

    @posts = selected_scope.page params[:page] # paginate the current scope
  end

  def search
    unless params[:query].blank?
      @posts = Post.search(params[:query]).page params[:page]
    else
      redirect_to posts_path
    end
  end

  def show
    @post.view_count += 1
    @post.save
  end

  # Create
  def new
    if enforce_membership
      @post = Post.new
      @post.title = "Untitled Post"
      @post.color = "black"
      @post.author = Member.find(session[:member_id])
    end
  end

  def create
    if enforce_membership
      @post = Post.new(post_params)
      @post.author = Member.find(session[:member_id])
      if @post.save
        redirect_to post_path(@post)
      else
        Rails.logger.debug "Something broke: #{@post.errors.full_messages}"
        render 'new'
      end
    end
  end

  # Update
  def edit
    enforce_post_ownership
  end

  def update
    if enforce_post_ownership
      @post.update(post_params)
      if @post.save
        flash['msg'] = "Your edits were saved."
        redirect_to post_path @post
      else
        render 'edit'
      end
    end
  end

  # Delete
  def delete
    enforce_post_ownership
  end

  def destroy
    if enforce_post_ownership
      flash['msg'] = "Goodbye forever #{@post.title}! We hated you anyway."
      @post.destroy
      redirect_to posts_path
    end
  end

  private

    def post_params
      params.require('post').permit('title','color','raw_content')
    end

    def get_post_from_id
      @post = Post.friendly.find(params[:id])
    end

    def enforce_membership
      if session[:member_id].blank?
        flash['msg'] = "You have to be a Member to perform this action."
        redirect_to posts_path
        return false
      else
        return true
      end
    end

    def enforce_post_ownership
      unless @post.author_id == session[:member_id]
        flash['msg'] = "Only the owner of a Post can modify it."
        redirect_to posts_path
        return false
      else
        return true
      end
    end

end
