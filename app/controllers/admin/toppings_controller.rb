module Admin
  class ToppingsController < BaseController
    before_action :set_topping, only: [:show, :edit, :update, :destroy]

    def index
      @toppings = Topping.all
      respond_to do |format|
        format.html
        format.json { render json: @toppings }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @topping }
      end
    end

    def new
      @topping = Topping.new
    end

    def create
      @topping = Topping.new(topping_params)
      if @topping.save
        respond_to do |format|
          format.html { redirect_to admin_toppings_path, notice: "Topping created." }
          format.json { render json: @topping, status: :created }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: { errors: @topping.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      if @topping.update(topping_params)
        respond_to do |format|
          format.html { redirect_to admin_toppings_path, notice: "Topping updated." }
          format.json { render json: @topping }
        end
      else
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: { errors: @topping.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @topping.destroy
      respond_to do |format|
        format.html { redirect_to admin_toppings_path, notice: "Topping deleted." }
        format.json { head :no_content }
      end
    end

    private

    def set_topping
      @topping = Topping.find(params[:id])
    end

    def topping_params
      params.require(:topping).permit(:name)
    end
  end
end
