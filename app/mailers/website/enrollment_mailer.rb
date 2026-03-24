module Website
  class EnrollmentMailer < ApplicationMailer
    def notify(enrollment)
      @enrollment = enrollment

      subject = if enrollment.trial?
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
