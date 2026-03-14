module Website
  class EnrollmentMailer < ApplicationMailer
    def notify(enrollment)
      @enrollment = enrollment

      mail(
        to: "pisuazoh@gmail.com",
        subject: "Nueva inscripción: #{enrollment.student_name}",
        reply_to: enrollment.email
      )
    end
  end
end
