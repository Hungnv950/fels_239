class UsersController < ApplicationController
  layout "user", except: :new

  before_action :logged_in_user, except: [:new, :create]
  before_action :load_user, except: [:new, :index, :create]
  before_action :correct_user, only: [:destroy,:update, :edit]
  before_action :user_follow, only: [:show]

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = t "account.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    correct_answers = params[:correct_answers]
    category_id = params[:category]
    @answers = @user.learned_words category_id
    if correct_answers
      correct_answers == "true" ?
        @answers = @answers.correct_answers : @answers = @answers.wrong_answers
    end
    @answers_size = @answers.size
    @answers = @answers.includes(:word).page params[:page]
    @user_lessons = @user.lessons
    @lessons_doing = @user_lessons.lessons_doing
    @lessons_doing_size= @lessons_doing.size
    @lessons_finished = @user_lessons.lessons_finished
    @lessons_finished_size = @lessons_finished.size
    @categories_search = @user_lessons.includes(:category)
      .select(:category_id, :name).distinct(:category_id)
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.update_complete"
      redirect_to @user
    else
      flash[:danger] = t "user.update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.deleted"
      redirect_to root_url
    end
  end

  private

  def correct_user
    unless owner?(@user) || current_user.is_admin?
      flash[:danger] = t "user.dont_have_permission"
      redirect_to root_url
    end
  end

  def load_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t "user.not_found"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "user.please_login"
    redirect_to login_url
  end

  def user_follow
    @user_follower = current_user.active_relationships.build
    @user_following = current_user.active_relationships.find_by(
      followed_id: @user.id)
  end
end
