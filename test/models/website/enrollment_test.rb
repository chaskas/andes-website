require "test_helper"

module Website
  class EnrollmentTest < ActiveSupport::TestCase
    def valid_attributes
      {
        contact_name: "Ana González",
        email: "ana@example.com",
        comments: "Tengo una pregunta sobre las clases",
        privacy_accepted: "1"
      }
    end

    test "valid landing enrollment is saved" do
      enrollment = Enrollment.new(valid_attributes)
      assert enrollment.valid?
    end

    test "contact_name is required" do
      enrollment = Enrollment.new(valid_attributes.merge(contact_name: nil))
      assert_not enrollment.valid?
    end

    test "contact_name must be between 2 and 60 characters" do
      enrollment = Enrollment.new(valid_attributes.merge(contact_name: "A"))
      assert_not enrollment.valid?

      enrollment = Enrollment.new(valid_attributes.merge(contact_name: "A" * 61))
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

    test "comments is required for landing" do
      enrollment = Enrollment.new(valid_attributes.merge(comments: nil))
      assert_not enrollment.valid?
      assert enrollment.errors[:comments].any?
    end

    test "phone is optional" do
      enrollment = Enrollment.new(valid_attributes.merge(phone: nil))
      assert enrollment.valid?
    end

    test "landing does not require student_name or student_age" do
      enrollment = Enrollment.new(valid_attributes)
      assert_nil enrollment.student_name
      assert_nil enrollment.student_age
      assert enrollment.valid?
    end

    test "source defaults to landing" do
      enrollment = Enrollment.new(valid_attributes)
      assert_equal "landing", enrollment.source
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

    test "trial enrollment requires student_name" do
      enrollment = Enrollment.new(trial_attributes.merge(student_name: nil))
      assert_not enrollment.valid?
      assert enrollment.errors[:student_name].any?
    end

    test "trial enrollment requires student_age" do
      enrollment = Enrollment.new(trial_attributes.merge(student_age: nil))
      assert_not enrollment.valid?
      assert enrollment.errors[:student_age].any?
    end

    test "trial enrollment does not require comments" do
      enrollment = Enrollment.new(trial_attributes.merge(comments: nil))
      assert enrollment.valid?
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

    test "invalid email rejected regardless of source" do
      enrollment = Enrollment.new(trial_attributes.merge(email: "not-an-email"))
      assert_not enrollment.valid?
      assert enrollment.errors[:email].any?
    end
  end
end
