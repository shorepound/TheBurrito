class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      if session[:pending_burrito]
        pending = session.delete(:pending_burrito)
        burrito = @user.burritos.build(pending.slice("name", "tortilla_id", "size_id"))
        if burrito.save
          burrito.fillings = Filling.where(id: pending["filling_ids"]) if pending["filling_ids"]
          burrito.toppings = Topping.where(id: pending["topping_ids"]) if pending["topping_ids"]
          redirect_to burrito_path(burrito), notice: "Account created and burrito saved."
          return
        end
      end
      redirect_to root_path, notice: "Account created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
