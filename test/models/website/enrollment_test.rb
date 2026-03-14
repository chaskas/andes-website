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
        availability: "Miércoles por la tarde"
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
  end
end
