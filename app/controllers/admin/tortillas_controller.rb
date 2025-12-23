module Admin
  class TortillasController < BaseController
    before_action :set_tortilla, only: [:show, :edit, :update, :destroy]

    def index
      @tortillas = Tortilla.all
      respond_to do |format|
        format.html
        format.json { render json: @tortillas }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @tortilla }
      end
    end

    def new
      @tortilla = Tortilla.new
    end

    def create
      @tortilla = Tortilla.new(tortilla_params)
      if @tortilla.save
        respond_to do |format|
          format.html { redirect_to admin_tortillas_path, notice: "Tortilla created." }
          format.json { render json: @tortilla, status: :created }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: { errors: @tortilla.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      if @tortilla.update(tortilla_params)
        respond_to do |format|
          format.html { redirect_to admin_tortillas_path, notice: "Tortilla updated." }
          format.json { render json: @tortilla }
        end
      else
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: { errors: @tortilla.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @tortilla.destroy
      respond_to do |format|
        format.html { redirect_to admin_tortillas_path, notice: "Tortilla deleted." }
        format.json { head :no_content }
      end
    end

    private

    def set_tortilla
      @tortilla = Tortilla.find(params[:id])
    end

    def tortilla_params
      params.require(:tortilla).permit(:name)
    end
  end
end
