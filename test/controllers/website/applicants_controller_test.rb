require "test_helper"

module Website
  class ApplicantsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    def valid_params
      {
        applicant: {
          name: "María González",
          email: "maria@example.com",
          phone: "+49 123 456 789",
          profession: "Violinista",
          location: "Berlin",
          availability: "Lunes y miércoles por la tarde",
          message: "Me gustaría enseñar violín"
        }
      }
    end

    test "new renders the application form" do
      get new_applicant_url
      assert_response :success
      assert_select "form"
    end

    test "create with valid params saves and redirects" do
      assert_difference("Website::Applicant.count", 1) do
        post applicants_url, params: valid_params
      end
      assert_redirected_to new_applicant_path
      follow_redirect!
      assert_match "postulación", response.body
    end

    test "create with invalid params renders form with errors" do
      assert_no_difference("Website::Applicant.count") do
        post applicants_url, params: { applicant: { name: "", email: "bad" } }
      end
      assert_response :unprocessable_entity
    end
  end
end
