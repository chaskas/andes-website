module Website
  class EnrollmentMailer < ApplicationMailer
    def notify(enrollment)
      @enrollment = enrollment

      if enrollment.trial? && defined?(School::SessionDetail)
        @session_detail = School::SessionDetail.includes(:facilitator, :targetable).find_by(id: enrollment.session_detail_id)
        @session_record = School::SessionRecord.find_by(id: enrollment.session_record_id)
      end

      subject = if enrollment.trial? && @session_detail
                  "Nueva clase de prueba: #{enrollment.student_name} — #{@session_detail.title}"
                elsif enrollment.trial?
                  "Nueva clase de prueba: #{enrollment.student_name}"
                else
                  "Nueva inscripción: #{enrollment.student_name}"
                end

      mail(
        to: "pisuazoh@gmail.com",
        subject: subject,
        reply_to: enrollment.email
      )
    end
  end
end
