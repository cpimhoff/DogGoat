class PostsController < ApplicationController

  before_action :get_post_from_id, :except => ['index','new','create']

  # Read
  def index
    @posts = Post.hot
  end

  def show
    @post.view_count += 1
    @post.save
  end

  # Create
  def new
    if enforce_membership
      @post = Post.new
      @post.author = Member.find(session[:member_id])
    end
  end

  def create
    if enforce_membership
      @post = Post.new(post_params)
      if @post.save
        redirect_to posts_path
      else
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
      @post.destroy
      redirect_to posts_path
    end
  end

  private

    def post_params
      params.require('post').permit('title','color','raw_content')
    end

    def get_post_from_id
      @post = Post.find(params[:id])
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
        flash['msg'] = "Only the owner of this Post can modify it."
        redirect_to posts_path
        return false
      else
        return true
      end
    end

end
