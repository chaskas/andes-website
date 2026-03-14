module Website
  class ApplicationMailer < ActionMailer::Base
    default from: ENV.fetch("MAILER_FROM", "noreply@andes.academy")
    layout "mailer"
  end
end
