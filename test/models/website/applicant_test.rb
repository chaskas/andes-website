require "test_helper"

module Website
  class ApplicantTest < ActiveSupport::TestCase
    def valid_attributes
      {
        name: "María González",
        email: "maria@example.com",
        phone: "+49 123 456 789",
        profession: "Violinista",
        location: "Berlin",
        availability: "Lunes y miércoles por la tarde",
        message: "Me gustaría enseñar violín"
      }
    end

    test "valid applicant is saved" do
      applicant = Applicant.new(valid_attributes)
      assert applicant.valid?
    end

    test "name is required" do
      applicant = Applicant.new(valid_attributes.merge(name: ""))
      assert_not applicant.valid?
      assert_includes applicant.errors[:name], "can't be blank"
    end

    test "name must be at least 2 characters" do
      applicant = Applicant.new(valid_attributes.merge(name: "A"))
      assert_not applicant.valid?
    end

    test "email is required" do
      applicant = Applicant.new(valid_attributes.merge(email: ""))
      assert_not applicant.valid?
    end

    test "email must be valid format" do
      applicant = Applicant.new(valid_attributes.merge(email: "not-an-email"))
      assert_not applicant.valid?
      assert_includes applicant.errors[:email], "is invalid"
    end

    test "profession is required" do
      applicant = Applicant.new(valid_attributes.merge(profession: ""))
      assert_not applicant.valid?
    end

    test "location is required" do
      applicant = Applicant.new(valid_attributes.merge(location: ""))
      assert_not applicant.valid?
    end

    test "availability is required" do
      applicant = Applicant.new(valid_attributes.merge(availability: ""))
      assert_not applicant.valid?
    end

    test "phone is required" do
      applicant = Applicant.new(valid_attributes.merge(phone: ""))
      assert_not applicant.valid?
    end

    test "message is required" do
      applicant = Applicant.new(valid_attributes.merge(message: ""))
      assert_not applicant.valid?
    end

    test "profession has max length" do
      applicant = Applicant.new(valid_attributes.merge(profession: "a" * 101))
      assert_not applicant.valid?
    end

    test "location has max length" do
      applicant = Applicant.new(valid_attributes.merge(location: "a" * 101))
      assert_not applicant.valid?
    end

    test "availability has max length" do
      applicant = Applicant.new(valid_attributes.merge(availability: "a" * 201))
      assert_not applicant.valid?
    end

    test "message has max length" do
      applicant = Applicant.new(valid_attributes.merge(message: "a" * 1001))
      assert_not applicant.valid?
    end

    test "phone accepts valid formats" do
      ["+49 123 456 789", "030-1234567", "(030) 123456"].each do |phone|
        applicant = Applicant.new(valid_attributes.merge(phone: phone))
        assert applicant.valid?, "Expected #{phone} to be valid"
      end
    end

    test "phone rejects invalid formats" do
      applicant = Applicant.new(valid_attributes.merge(phone: "not-a-phone!"))
      assert_not applicant.valid?
      assert_includes applicant.errors[:phone], "is invalid"
    end
  end
end
