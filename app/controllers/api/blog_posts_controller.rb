class API::BlogPostsController < ApplicationController

  before_filter :load_blog_post, 
    :only => [:edit, :show, :update, :destroy]

  def index
    render json: BlogPost.all, status: 200
  end

  def create
    # blog_post = BlogPost.create(params[]) , status: 201
  end

  def new
    render json: BlogPost.new, status: 200
  end

  def edit
  end

  def show
    if blog_post.published?
      render json: blog_post, status: 200
    else
      render nothing: true, status: 403
    end
  end

  def update
  end

  def destroy
  end

  private

  def load_blog_post
    begin
      blog_post = BlogPost.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: "#{e}", status: 404
    end
  end
end