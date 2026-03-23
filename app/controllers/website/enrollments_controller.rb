module Website
  class EnrollmentsController < ApplicationController
    def create
      @enrollment = Enrollment.new(enrollment_params)

      if @enrollment.save
        EnrollmentMailer.notify(@enrollment).deliver_now
        redirect_to root_path(anchor: "contacto"), notice: t("website.enrollment.success")
      else
        redirect_to root_path(anchor: "contacto"), alert: t("website.enrollment.error")
      end
    end

    private

    def enrollment_params
      params.require(:enrollment).permit(
        :student_name, :student_age, :contact_name, :email, :phone,
        :preferred_language, :class_type, :availability, :comments,
        :privacy_accepted
      )
    end
  end
end
