class EggsController < ApplicationController
  before_action :set_egg, only: %i[ show edit update destroy ]

  # GET /eggs or /eggs.json
  def index
    @eggs = Egg.all
    @chicken = Chicken.find(params[:chicken_id])
  end

  # GET /eggs/1 or /eggs/1.json
  def show
    @egg = Egg.find(params[:id])
    @chicken = Chicken.find(@egg.chicken_id)
  end

  # GET /eggs/new
  def new
    @egg = Egg.new
    @chicken = Chicken.find(params[:chicken_id])
  end

  # GET /eggs/1/edit
  def edit
  end

  # POST /eggs or /eggs.json
  def create
    @egg = Egg.new(egg_params)

    respond_to do |format|
      if @egg.save
        format.html { redirect_to chicken_egg_url(@egg.chicken_id, @egg), notice: "Egg was successfully created." }
        format.json { render :show, status: :created, location: @egg }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @egg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eggs/1 or /eggs/1.json
  def update
    respond_to do |format|
      if @egg.update(egg_params)
        format.html { redirect_to egg_url(@egg), notice: "Egg was successfully updated." }
        format.json { render :show, status: :ok, location: @egg }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @egg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eggs/1 or /eggs/1.json
  def destroy
    @egg.destroy

    respond_to do |format|
      format.html { redirect_to eggs_url, notice: "Egg was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_egg
      @egg = Egg.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def egg_params
      params.require(:egg).permit(:color, :laid, :fertilized, :weight_oz, :weight_mg, :chicken_id)
    end
end
