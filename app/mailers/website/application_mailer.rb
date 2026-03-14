module Website
  class ApplicationMailer < ActionMailer::Base
    default from: "noreply@andesacademy.de"
    layout "mailer"
  end
end
