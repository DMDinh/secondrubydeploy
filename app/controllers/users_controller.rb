class UsersController < ApplicationController
  before_action :status, except:[:index, :create, :login, :logout, :edit, :update, :show]

  def index
  end

  def show
  end

  def edit
  end




  def create

    user = User.create(fname: params[:fname], lname: params[:lname], email: params[:email], city: params[:city], state: params[:state], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.valid?
      session[:id] = user[:id]
      redirect_to '/events'
    else
      flash[:msg] = user.errors.full_messages.to_sentence
      redirect_to '/'
    end
  end

  def update
    @user = User.find(params[:id]).update(fname: params[:fname], lname: params[:lname], email: params[:email], city: params[:city], state: params[:state], password: params[:password], password_confirmation: params[:password_confirmation])
    redirect_to '/events'
  end

  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user[:id]
      redirect_to '/events'
    else
      flash[:msg] = "Either password or email was invalid. Please try again."
      redirect_to '/'
    end
  end

  def logout
    session.clear
    redirect_to "/"
  end

  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to '/users'
  end


  private

  def status
    if !session[:user_id]
      redirect_to '/'
    else
    end
  end

end
