class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]
  before_action :check_for_valid_authtoken

  skip_before_action :verify_authenticity_token

  # GET /doctors
  # GET /doctors.json
  def index
    @doctors = Doctor.all
    render json: Response.new.success('All Doctors', @doctors, @current_user.acess_token)
  end

  # GET /doctors/1
  # GET /doctors/1.json
  def show
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
  end

  # GET /doctors/1/edit
  def edit
  end

  # POST /doctors
  # POST /doctors.json
  def create
    doctor = Doctor.new(doctor_params)
    if doctor.save
      render json: Response.new.success('doctor created succesfully', doctor, @current_user.acess_token)
    else
      render json: Response.new.failure(doctor.errors.full_messages.join(', '), nil)
    end
  end

  # PATCH/PUT /doctors/1
  # PATCH/PUT /doctors/1.json
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :edit }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1
  # DELETE /doctors/1.json
  def destroy
    @doctor.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url, notice: 'Doctor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      
      params.require(:doctor).permit(:name, :phone_number, :specialization)
    end
end
