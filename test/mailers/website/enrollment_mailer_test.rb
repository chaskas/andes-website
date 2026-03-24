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
      assert_no_match "Idioma preferido", email.body.encoded
    end

    test "landing enrollment email remains unchanged" do
      enrollment = Enrollment.new(
        student_name: "María González",
        student_age: "4 años",
        contact_name: "Ana González",
        email: "ana@example.com",
        preferred_language: "espanol",
        class_type: "piano",
        availability: "Miércoles por la tarde",
        source: "landing"
      )

      email = EnrollmentMailer.notify(enrollment)

      assert_equal "Nueva inscripción: María González", email.subject
      assert_match "Idioma preferido", email.body.encoded
      assert_match "Tipo de clase", email.body.encoded
    end
  end
end
