class CoopsController < ApplicationController
  before_action :set_coop, only: %i[ show edit update destroy ]

  # GET /coops or /coops.json
  def index
    @coops = Coop.all
  end

  # GET /coops/1 or /coops/1.json
  def show
    @user = current_user
  end

  # GET /coops/new
  def new
    redirect_if_not_signed_in
    @user = current_user
    @coop = Coop.new
  end

  # GET /coops/1/edit
  def edit
  end

  # POST /coops or /coops.json
  def create
    @user = current_user
    @coop = Coop.new(coop_params)
    @coop.user_id = @user.id
    respond_to do |format|
      if @coop.save
        format.html { redirect_to coop_url(@coop), notice: "Coop was successfully created." }
        format.json { render :show, status: :created, location: @coop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coops/1 or /coops/1.json
  def update
    respond_to do |format|
      if @coop.update(coop_params)
        format.html { redirect_to coop_url(@coop), notice: "Coop was successfully updated." }
        format.json { render :show, status: :ok, location: @coop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coops/1 or /coops/1.json
  def destroy
    @coop.destroy

    respond_to do |format|
      format.html { redirect_to coops_url, notice: "Coop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coop
      @coop = Coop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coop_params
      params.require(:coop).permit(:name, images: [])
    end
end
