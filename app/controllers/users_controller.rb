class UsersController < Clearance::UsersController
  before_action :find_user, only: [:show, :edit, :update]
  def index
    @users = User.all
  end

  def show
    @bookings = @user.bookings
  end

  def edit
  end

  # def create
  #   @user = User.new(user_params)
  #   @user.save
  # end
wahahaha
  def create
    @user = User.new(user_params)
    if @user.save
      # Tell the UserMailer to send a welcome email after save
      UserMailer.welcome_email(@user).deliver_now
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Successfully updated the user"
      redirect_to @user
    else
      flash[:danger] = "Error updating user"
      render :edit
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
