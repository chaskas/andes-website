require "test_helper"

module Website
  class EnrollmentMailerTest < ActionMailer::TestCase
    test "notify sends enrollment details to recipient" do
      enrollment = Enrollment.new(
        student_name: "María González",
        student_age: "4 años",
        contact_name: "Ana González",
        email: "ana@example.com",
        phone: "+49 123 456 789",
        preferred_language: "espanol",
        class_type: "piano",
        availability: "Miércoles por la tarde",
        comments: "Nos interesa una clase de prueba."
      )

      email = EnrollmentMailer.notify(enrollment)

      assert_equal ["pisuazoh@gmail.com"], email.to
      assert_equal "Nueva inscripción: María González", email.subject
      assert_equal ["ana@example.com"], email.reply_to
      assert_match "María González", email.body.encoded
      assert_match "ana@example.com", email.body.encoded
      assert_match "piano", email.body.encoded
    end
  end
end
