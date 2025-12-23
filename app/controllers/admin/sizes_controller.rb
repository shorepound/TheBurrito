module Admin
  class SizesController < BaseController
    before_action :set_size, only: [:show, :edit, :update, :destroy]

    def index
      @sizes = Size.all
      respond_to do |format|
        format.html
        format.json { render json: @sizes }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: @size }
      end
    end

    def new
      @size = Size.new
    end

    def create
      @size = Size.new(size_params)
      if @size.save
        respond_to do |format|
          format.html { redirect_to admin_sizes_path, notice: "Size created." }
          format.json { render json: @size, status: :created }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: { errors: @size.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end
    def edit
    end

    def update
      if @size.update(size_params)
        respond_to do |format|
          format.html { redirect_to admin_sizes_path, notice: "Size updated." }
          format.json { render json: @size }
        end
      else
        respond_to do |format|
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: { errors: @size.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @size.destroy
      respond_to do |format|
        format.html { redirect_to admin_sizes_path, notice: "Size deleted." }
        format.json { head :no_content }
      end
    end

    private

    def set_size
      @size = Size.find(params[:id])
    end

    def size_params
      params.require(:size).permit(:name)
    end
  end
end
