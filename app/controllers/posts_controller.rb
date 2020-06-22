class PostsController < ApplicationController
  before_action :find_params, only: [:edit, :update, :show, :destory]

  def index
    @post = Post.all.order('created_at DESC')
  end

  def show
    
  end
  

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

def find_params
  @post = Post.find(params[:id])
end


  def post_params
    params.require(:post).permit(:title, :body, :cost, :benefits)
  end
  
  
end
