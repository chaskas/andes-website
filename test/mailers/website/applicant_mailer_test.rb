require "test_helper"

module Website
  class ApplicantMailerTest < ActionMailer::TestCase
    test "notify sends email with applicant details" do
      applicant = Applicant.create!(
        name: "María González",
        email: "maria@example.com",
        phone: "+49 123 456 789",
        profession: "Violinista",
        location: "Berlin",
        availability: "Lunes y miércoles",
        message: "Me gustaría enseñar violín"
      )

      email = ApplicantMailer.notify(applicant)

      assert_equal ["pisuazoh@gmail.com"], email.to
      assert_equal ["maria@example.com"], email.reply_to
      assert_match "María González", email.subject
      assert_match "Violinista", email.subject
      assert_match "Berlin", email.body.encoded
      assert_match "Violinista", email.body.encoded
    end
  end
end
