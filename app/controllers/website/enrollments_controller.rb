module Website
  class EnrollmentsController < ApplicationController
    def create
      @enrollment = Enrollment.new(enrollment_params)

      if @enrollment.save
        EnrollmentMailer.notify(@enrollment).deliver_now
        redirect_path = @enrollment.trial? ? trial_classes_path : root_path(anchor: "contacto")
        redirect_to redirect_path, notice: t("website.enrollment.success")
      else
        redirect_path = @enrollment.trial? ? trial_classes_path : root_path(anchor: "contacto")
        redirect_to redirect_path, alert: t("website.enrollment.error")
      end
    end

    private

    def enrollment_params
      params.require(:enrollment).permit(
        :student_name, :student_age, :contact_name, :email, :phone,
        :preferred_language, :class_type, :availability, :comments,
        :privacy_accepted, :source, :session_detail_id, :session_record_id
      )
    end
  end
end
