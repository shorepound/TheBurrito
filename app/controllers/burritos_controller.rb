class BurritosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :new]
  before_action :set_burrito, only: [:show, :update, :destroy]

  def index
    @burritos = Burrito.includes(:tortilla, :size, :fillings, :toppings).all
    @tortillas = Tortilla.all
    @sizes = Size.all
    @fillings = Filling.all
    @toppings = Topping.all

    respond_to do |format|
      format.html
      format.json { render json: @burritos.as_json(include: [:tortilla, :size, :fillings, :toppings]) }
    end
  end

  def new
    @burrito = Burrito.new
    @tortillas = Tortilla.all
    @sizes = Size.all
    @fillings = Filling.all
    @toppings = Topping.all
  end

  def edit
    @tortillas = Tortilla.all
    @sizes = Size.all
    @fillings = Filling.all
    @toppings = Topping.all
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @burrito.as_json(include: [:tortilla, :size, :fillings, :toppings]) }
    end
  end

  def create
    if logged_in?
      @burrito = current_user.burritos.build(burrito_params)
      if @burrito.save
        update_associations
        respond_to do |format|
          format.html { redirect_to @burrito, notice: "Burrito created." }
          format.json { render json: @burrito, status: :created }
        end
      else
        respond_to do |format|
          format.html do
            @tortillas = Tortilla.all
            @sizes = Size.all
            @fillings = Filling.all
            @toppings = Topping.all
            render :new, status: :unprocessable_entity
          end
          format.json { render json: { errors: @burrito.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    else
      # save burrito details in session and prompt to sign up/in
      session[:pending_burrito] = params[:burrito].to_unsafe_h
      redirect_to new_user_registration_path, notice: "Please create an account to save your burrito."
    end
  end

  def update
    unless @burrito.user == current_user || admin_user?
      return render json: { error: "Forbidden" }, status: :forbidden
    end

    if @burrito.update(burrito_params)
      update_associations
      respond_to do |format|
        format.html { redirect_to @burrito, notice: "Burrito updated." }
        format.json { render json: @burrito }
      end
    else
      respond_to do |format|
        format.html do
          @tortillas = Tortilla.all
          @sizes = Size.all
          @fillings = Filling.all
          @toppings = Topping.all
          render :edit, status: :unprocessable_entity
        end
        format.json { render json: { errors: @burrito.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    unless @burrito.user == current_user || admin_user?
      return render json: { error: "Forbidden" }, status: :forbidden
    end

    @burrito.destroy
    respond_to do |format|
      format.html { redirect_to burritos_path, notice: "Burrito deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_burrito
    @burrito = Burrito.find(params[:id])
  end

  def burrito_params
    params.require(:burrito).permit(:name, :tortilla_id, :size_id)
  end

  def update_associations
    if params[:burrito] && params[:burrito][:filling_ids]
      @burrito.fillings = Filling.where(id: params[:burrito][:filling_ids])
    end
    if params[:burrito] && params[:burrito][:topping_ids]
      @burrito.toppings = Topping.where(id: params[:burrito][:topping_ids])
    end
  end
end
