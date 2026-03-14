require "test_helper"

module Website
  class EnrollmentsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    def valid_params
      {
        enrollment: {
          student_name: "María González",
          student_age: "3 años",
          contact_name: "Ana González",
          email: "ana@example.com",
          preferred_language: "espanol",
          class_type: "iniciacion_musical",
          availability: "Miércoles por la tarde",
          comments: "Clase de prueba"
        }
      }
    end

    test "successful enrollment creates record and redirects" do
      assert_difference("Website::Enrollment.count", 1) do
        post enrollments_url, params: valid_params
      end
      assert_redirected_to root_url(anchor: "contacto")
      follow_redirect!
      assert_match I18n.t("website.enrollment.success"), flash[:notice]
    end

    test "failed enrollment does not create record and shows error" do
      invalid_params = valid_params.deep_merge(enrollment: { email: "invalid" })
      assert_no_difference("Website::Enrollment.count") do
        post enrollments_url, params: invalid_params
      end
      assert_redirected_to root_url(anchor: "contacto")
      follow_redirect!
      assert_match I18n.t("website.enrollment.error"), flash[:alert]
    end
  end
end
