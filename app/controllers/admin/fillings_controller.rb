module Admin
  class FillingsController < BaseController
    before_action :set_filling, only: [:show, :edit, :update, :destroy]

    def index
      @fillings = Filling.all
      respond_to do |format|
        format.html
        format.json { render json: @fillings }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @filling }
      end
    end

    def new
      @filling = Filling.new
    end

    def create
      @filling = Filling.new(filling_params)
      if @filling.save
        respond_to do |format|
          format.html { redirect_to admin_fillings_path, notice: "Filling created." }
          format.json { render json: @filling, status: :created }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: { errors: @filling.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      if @filling.update(filling_params)
        respond_to do |format|
          format.html { redirect_to admin_fillings_path, notice: "Filling updated." }
          format.json { render json: @filling }
        end
      else
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: { errors: @filling.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @filling.destroy
      respond_to do |format|
        format.html { redirect_to admin_fillings_path, notice: "Filling deleted." }
        format.json { head :no_content }
      end
    end

    private

    def set_filling
      @filling = Filling.find(params[:id])
    end

    def filling_params
      params.require(:filling).permit(:name)
    end
  end
end
