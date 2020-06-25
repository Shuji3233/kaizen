class PostsController < ApplicationController
  before_action :find_posts, only: [:edit, :update, :show, :destroy]
  
  def index
    if params[:category].blank?
      @post = Post.all.order('created_at DESC')
    else
      category_id = Category.find_by(name:params[:category]).id
      @post = Post.where(:category_id => @category_id).order('created_at DESC')
    end
    
  end

  def show
    
  end

  def new
    @post = current_user.posts.build
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end
  
  def create
    @post = current_user.posts.build(post_params)
    @post.category_id = params[:category_id]
    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end
  
  def update
    @post.category.id = params[:category_id]
    if @post.update(post_params)
      redirect_to post_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to root_path
  end
  

  private

def find_posts
  @post = Post.find(params[:id])
end


  def post_params
    params.require(:post).permit(:title, :body, :cost, :benefits, :category_id)
  end
  
end
