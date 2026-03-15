module Website
  class ApplicantMailer < ApplicationMailer
    def notify(applicant)
      @applicant = applicant

      mail(
        to: "pisuazoh@gmail.com",
        subject: "Nueva postulación: #{applicant.name} — #{applicant.profession}",
        reply_to: applicant.email
      )
    end
  end
end
