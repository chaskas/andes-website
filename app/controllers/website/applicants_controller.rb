module Website
  class ApplicantsController < ApplicationController
    def new
      @applicant = Applicant.new
    end

    def create
      @applicant = Applicant.new(applicant_params)

      if @applicant.save
        ApplicantMailer.notify(@applicant).deliver_now
        redirect_to new_applicant_path, notice: t("website.work_with_us.success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def applicant_params
      params.require(:applicant).permit(
        :name, :email, :phone, :profession, :location, :availability, :message
      )
    end
  end
end
