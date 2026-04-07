require "test_helper"

module Website
  class EnrollmentsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    def valid_params
      {
        enrollment: {
          contact_name: "Ana González",
          email: "ana@example.com",
          comments: "Tengo una pregunta sobre las clases",
          privacy_accepted: "1"
        }
      }
    end

    test "successful enrollment creates record and redirects" do
      assert_difference("Website::Enrollment.count", 1) do
        post enrollments_url, params: valid_params
      end
      assert_redirected_to root_url(anchor: "contacto")
      assert flash[:notice].present?
    end

    test "failed enrollment does not create record and shows error" do
      invalid_params = valid_params.deep_merge(enrollment: { email: "invalid" })
      assert_no_difference("Website::Enrollment.count") do
        post enrollments_url, params: invalid_params
      end
      assert_redirected_to root_url(anchor: "contacto")
      assert flash[:alert].present?
    end
  end
end
