class UsersController < ApplicationController
  before_action :status, except:[:index, :create, :login, :logout, :edit, :update, :show]

  def index
  end

  def users
    @user = User.find(params[:id])
    @uposts = @user.posts
    @ulikes = @user.likes
  end

  def bright_ideas
    @user = User.find(session[:user_id])
    @ulikes = @user.likes
    @uposts = @user.myposts
    @posts = Post.all
    @likes = Like.all
  end

  def bpage
    @post = Post.find(params[:id])
    @others = @post.likes
  end

  def post_comment
    @user = User.find(session[:user_id])
    post = Post.create(comment: params[:comment], user: @user)
    redirect_to '/bright_ideas'
  end

  def remove
    post = Post.find(params[:id]).destroy
    redirect_to '/bright_ideas'
  end

# Like and unlike
  def like
    @user = User.find(session[:user_id])
    @post = Post.find(params[:id])
    like = Like.create(user: @user, post: @post)
    redirect_to '/bright_ideas'
  end

  def unlike
    @user = User.find(session[:user_id])
    @post = Post.find(params[:id])
    Like.where(user: @user, post: @post).destroy_all
    redirect_to '/bright_ideas'
  end

# user related crud operations below
  def create

    user = User.create(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.valid?
      session[:user_id] = user[:id]
      redirect_to '/bright_ideas'
    else
      flash[:msg] = user.errors.full_messages.to_sentence
      redirect_to '/main'
    end
  end

  def edit
    @user = User.find(session[:user_id])

  end

  def update
    @user = User.find(params[:id]).update(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    redirect_to '/bright_ideas'
  end

  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user[:id]
      redirect_to '/bright_ideas'
    else
      flash[:msg] = "Either password or email was invalid. Please try again."
      redirect_to '/main'
    end
  end

  def logout
    session.clear
    redirect_to "/main"
  end

  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to '/main'
  end


  private

  def status
    if !session[:user_id]
      redirect_to '/main'
    else
    end
  end

end
