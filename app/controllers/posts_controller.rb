class PostsController < ApplicationController

  before_action :get_post_from_id, :except => ['index','new','create']

  # Read
  def index
    @posts = Post.all.hot
  end

  def show
    @post.view_count += 1
    @post.save
  end

  # Create
  def new
  end

  def create
  end

  # Update
  def edit
  end

  def update
  end

  # Delete
  def delete
  end

  def destroy
  end

  private

    def get_post_from_id
      @post = Post.find(params[:id])
    end

end
