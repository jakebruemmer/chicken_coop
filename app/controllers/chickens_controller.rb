class ChickensController < ApplicationController
  before_action :set_chicken, only: %i[ show edit update destroy ]

  # GET /chickens or /chickens.json
  def index
    @chickens = Chicken.all
  end

  # GET /chickens/1 or /chickens/1.json
  def show
    @start_date = params.fetch(:start_date, Date.today).to_date
    first_of_month = @start_date.beginning_of_month
    last_of_month = @start_date.end_of_month
    @days_of_month = @start_date.all_month.to_a

    # Add the beginning days of the month
    top_row = ((first_of_month - first_of_month.wday.days)..(first_of_month - 1.day)).to_a
    @days_of_month = top_row + @days_of_month unless first_of_month.wday == 0

    # Add end days of the month
    bottom_row = ((last_of_month + 1.day)..(last_of_month + (6 - last_of_month.wday).days)).to_a
    @days_of_month = @days_of_month + bottom_row unless last_of_month.wday == 6

    @chicken = Chicken.find(params[:id])
    @eggs = @chicken.eggs.where(laid: @start_date.beginning_of_month..@start_date.end_of_month)

    @url_for_next_view = url_for(:start_date => (last_of_month + 1.day).iso8601)
    @url_for_previous_view = url_for(:start_date => (first_of_month - 1.day).iso8601)
  end

  # GET /chickens/new
  def new
    redirect_if_not_signed_in
    @chicken = Chicken.new
  end

  # GET /chickens/1/edit
  def edit
  end

  # POST /chickens or /chickens.json
  def create
    @user = current_user
    @chicken = Chicken.new(chicken_params)
    @chicken.user_id = @user.id

    respond_to do |format|
      if @chicken.save
        format.html { redirect_to chicken_url(@chicken), notice: "Chicken was successfully created." }
        format.json { render :show, status: :created, location: @chicken }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chicken.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chickens/1 or /chickens/1.json
  def update
    respond_to do |format|
      if @chicken.update(chicken_params)
        format.html { redirect_to chicken_url(@chicken), notice: "Chicken was successfully updated." }
        format.json { render :show, status: :ok, location: @chicken }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chicken.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chickens/1 or /chickens/1.json
  def destroy
    @chicken.destroy

    respond_to do |format|
      format.html { redirect_to chickens_url, notice: "Chicken was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chicken
      @chicken = Chicken.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chicken_params
      params.require(:chicken).permit(:name, :breed, :age, :gender, images: [])
    end
end
