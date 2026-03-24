require "test_helper"

module Website
  class EnrollmentTest < ActiveSupport::TestCase
    def valid_attributes
      {
        student_name: "María González",
        student_age: "3 años",
        contact_name: "Ana González",
        email: "ana@example.com",
        preferred_language: "espanol",
        class_type: "iniciacion_musical",
        availability: "Miércoles por la tarde",
        privacy_accepted: "1"
      }
    end

    test "valid enrollment is saved" do
      enrollment = Enrollment.new(valid_attributes)
      assert enrollment.valid?
    end

    test "student_name is required" do
      enrollment = Enrollment.new(valid_attributes.merge(student_name: nil))
      assert_not enrollment.valid?
      assert enrollment.errors[:student_name].any?
    end

    test "student_name must be between 2 and 60 characters" do
      enrollment = Enrollment.new(valid_attributes.merge(student_name: "A"))
      assert_not enrollment.valid?

      enrollment = Enrollment.new(valid_attributes.merge(student_name: "A" * 61))
      assert_not enrollment.valid?
    end

    test "contact_name is required" do
      enrollment = Enrollment.new(valid_attributes.merge(contact_name: nil))
      assert_not enrollment.valid?
    end

    test "contact_name must be between 2 and 60 characters" do
      enrollment = Enrollment.new(valid_attributes.merge(contact_name: "A"))
      assert_not enrollment.valid?
    end

    test "email is required" do
      enrollment = Enrollment.new(valid_attributes.merge(email: nil))
      assert_not enrollment.valid?
    end

    test "email must be valid format" do
      enrollment = Enrollment.new(valid_attributes.merge(email: "not-an-email"))
      assert_not enrollment.valid?
      assert enrollment.errors[:email].any?
    end

    test "preferred_language must be in allowed values" do
      enrollment = Enrollment.new(valid_attributes.merge(preferred_language: "frances"))
      assert_not enrollment.valid?
      assert enrollment.errors[:preferred_language].any?
    end

    test "preferred_language accepts valid values" do
      %w[espanol aleman ingles].each do |lang|
        enrollment = Enrollment.new(valid_attributes.merge(preferred_language: lang))
        assert enrollment.valid?, "#{lang} should be valid"
      end
    end

    test "class_type must be in allowed values" do
      enrollment = Enrollment.new(valid_attributes.merge(class_type: "violin"))
      assert_not enrollment.valid?
    end

    test "class_type accepts valid values" do
      %w[iniciacion_musical piano].each do |type|
        enrollment = Enrollment.new(valid_attributes.merge(class_type: type))
        assert enrollment.valid?, "#{type} should be valid"
      end
    end

    test "student_age is required" do
      enrollment = Enrollment.new(valid_attributes.merge(student_age: nil))
      assert_not enrollment.valid?
    end

    test "availability is required" do
      enrollment = Enrollment.new(valid_attributes.merge(availability: nil))
      assert_not enrollment.valid?
    end

    test "phone and comments are optional" do
      enrollment = Enrollment.new(valid_attributes.merge(phone: nil, comments: nil))
      assert enrollment.valid?
    end

    # Trial source tests
    def trial_attributes
      {
        student_name: "María González",
        student_age: "3 años",
        contact_name: "Ana González",
        email: "ana@example.com",
        source: "trial",
        session_detail_id: 1,
        session_record_id: 1,
        participant_id: 1,
        privacy_accepted: "1"
      }
    end

    test "valid trial enrollment is saved" do
      enrollment = Enrollment.new(trial_attributes)
      assert enrollment.valid?
    end

    test "trial enrollment does not require preferred_language" do
      enrollment = Enrollment.new(trial_attributes)
      assert enrollment.valid?
      assert_nil enrollment.preferred_language
    end

    test "trial enrollment does not require class_type" do
      enrollment = Enrollment.new(trial_attributes)
      assert enrollment.valid?
      assert_nil enrollment.class_type
    end

    test "trial enrollment does not require availability" do
      enrollment = Enrollment.new(trial_attributes)
      assert enrollment.valid?
      assert_nil enrollment.availability
    end

    test "trial enrollment requires session_detail_id" do
      enrollment = Enrollment.new(trial_attributes.merge(session_detail_id: nil))
      assert_not enrollment.valid?
      assert enrollment.errors[:session_detail_id].any?
    end

    test "trial enrollment requires session_record_id" do
      enrollment = Enrollment.new(trial_attributes.merge(session_record_id: nil))
      assert_not enrollment.valid?
      assert enrollment.errors[:session_record_id].any?
    end

    test "trial enrollment requires participant_id" do
      enrollment = Enrollment.new(trial_attributes.merge(participant_id: nil))
      assert_not enrollment.valid?
      assert enrollment.errors[:participant_id].any?
    end

    test "source defaults to landing" do
      enrollment = Enrollment.new(valid_attributes)
      assert_equal "landing", enrollment.source
    end

    test "landing enrollment still requires preferred_language" do
      enrollment = Enrollment.new(valid_attributes.merge(preferred_language: nil))
      assert_not enrollment.valid?
    end

    test "landing enrollment still requires class_type" do
      enrollment = Enrollment.new(valid_attributes.merge(class_type: nil))
      assert_not enrollment.valid?
    end

    test "landing enrollment still requires availability" do
      enrollment = Enrollment.new(valid_attributes.merge(availability: nil))
      assert_not enrollment.valid?
    end

    test "invalid email rejected regardless of source" do
      enrollment = Enrollment.new(trial_attributes.merge(email: "not-an-email"))
      assert_not enrollment.valid?
      assert enrollment.errors[:email].any?
    end
  end
end
