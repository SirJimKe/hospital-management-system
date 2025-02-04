class DoctorsController < ApplicationController
    before_action :authorize, :current_user

    # GET /doctors
    def index
        doctors = Doctor.all
        render json: doctors
    end

    # GET /doctors/:id
    def show
        doctor = Doctor.find_by(id: params[:id])
        render json: doctor, serializer:SingleDoctorSerializer
    end

    # POST /doctors
    def create
        doctor = Doctor.create(doctor_params)
        render json: doctor, status: :created
    end

     # PATCH /doctors/:id
    def update
        doctor = Doctor.find_by(id: params[:id])
        if doctor
            doctor.update(doctor_params)
            render json: doctor
        else
            render json: { error: "Doctor not found" }, status: :not_found
        end
    end

    # DELETE /doctors/:id
    def destroy
        doctor = Doctor.find_by(id: params[:id])
        if doctor
            doctor.destroy
            head :no_content
        else
            render json: { error: "Doctor not found" }, status: :not_found
        end
    end

    private

    def doctor_params
        params.permit(:image, :full_name, :email, :primary_practice, :secondary_practice, :years_of_experience)
    end
end
