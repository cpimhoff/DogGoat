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
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  # Update
  def edit
  end

  def update
    @post.update(post_params)
    if @post.save
      redirect_to post_path @post
    else
      render 'edit'
    end
  end

  # Delete
  def delete
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

    def post_params
      params.require('post').permit('title','color','author_id','raw_content')
    end

    def get_post_from_id
      @post = Post.find(params[:id])
    end

end
