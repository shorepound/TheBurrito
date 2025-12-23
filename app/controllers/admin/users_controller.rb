module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.all
      respond_to do |format|
        format.html
        format.json { render json: @users }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @user }
      end
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        respond_to do |format|
          format.html { redirect_to admin_users_path, notice: "User created." }
          format.json { render json: @user, status: :created }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        respond_to do |format|
          format.html { redirect_to admin_users_path, notice: "User updated." }
          format.json { render json: @user }
        end
      else
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: "User deleted." }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :is_admin)
    end
  end
end
