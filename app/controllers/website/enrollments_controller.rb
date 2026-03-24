module Website
  class EnrollmentsController < ApplicationController
    def create
      if trial_enrollment?
        create_trial_enrollment
      else
        create_landing_enrollment
      end
    end

    private

    def create_landing_enrollment
      @enrollment = Enrollment.new(enrollment_params)

      if @enrollment.save
        EnrollmentMailer.notify(@enrollment).deliver_now
        redirect_to root_path(anchor: "contacto"), notice: t("website.enrollment.success")
      else
        redirect_to root_path(anchor: "contacto"), alert: t("website.enrollment.error")
      end
    end

    def create_trial_enrollment
      session_detail = find_session_detail
      group = session_detail&.targetable

      if group&.full?
        Rails.cache.delete("trial_classes")
        redirect_to trial_classes_path, alert: t("website.trial_classes.group_full")
        return
      end

      participant = create_trial_participant(group)
      @enrollment = Enrollment.new(enrollment_params.merge(participant_id: participant.id))

      if @enrollment.save
        Rails.cache.delete("trial_classes")
        EnrollmentMailer.notify(@enrollment).deliver_now
        redirect_to trial_classes_path, notice: t("website.enrollment.success")
      else
        participant.destroy!
        redirect_to trial_classes_path, alert: t("website.enrollment.error")
      end
    end

    def find_session_detail
      return nil unless defined?(School::SessionDetail)

      School::SessionDetail.includes(:targetable).find_by(id: enrollment_params[:session_detail_id])
    end

    def create_trial_participant(group)
      participant = School::Participant.create!(
        name: enrollment_params[:student_name],
        email: enrollment_params[:email],
        status: "trial"
      )
      group.participants << participant
      participant
    end

    def trial_enrollment?
      params.dig(:enrollment, :source) == "trial"
    end

    def enrollment_params
      params.require(:enrollment).permit(
        :student_name, :student_age, :contact_name, :email, :phone,
        :preferred_language, :class_type, :availability, :comments,
        :privacy_accepted, :source, :session_detail_id, :session_record_id
      )
    end
  end
end
