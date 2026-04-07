require "test_helper"

module Website
  class EnrollmentMailerTest < ActionMailer::TestCase
    test "notify sends landing contact details to recipient" do
      enrollment = Enrollment.new(
        contact_name: "Ana González",
        email: "ana@example.com",
        phone: "+49 123 456 789",
        comments: "Tengo una pregunta sobre las clases."
      )

      email = EnrollmentMailer.notify(enrollment)

      assert_equal ["pisuazoh@gmail.com"], email.to
      assert_equal "Nuevo contacto: Ana González", email.subject
      assert_equal ["ana@example.com"], email.reply_to
      assert_match "Ana González", email.body.encoded
      assert_match "ana@example.com", email.body.encoded
      assert_match "Nuevo contacto", email.body.encoded
      assert_no_match "Alumno/a", email.body.encoded
    end

    test "notify sends trial enrollment details with session info" do
      enrollment = Enrollment.new(
        student_name: "Lucas Schmidt",
        student_age: "5 años",
        contact_name: "Peter Schmidt",
        email: "peter@example.com",
        source: "trial",
        session_detail_id: 999,
        session_record_id: 999
      )

      email = EnrollmentMailer.notify(enrollment)

      assert_equal ["pisuazoh@gmail.com"], email.to
      assert_equal "Nueva clase de prueba: Lucas Schmidt", email.subject
      assert_match "Lucas Schmidt", email.body.encoded
      assert_match "Nueva clase de prueba", email.body.encoded
      assert_match "Alumno/a", email.body.encoded
    end
  end
end
