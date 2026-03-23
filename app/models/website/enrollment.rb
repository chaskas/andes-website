module Website
  class Enrollment < ApplicationRecord
    validates :student_name, presence: true, length: { minimum: 2, maximum: 60 }
    validates :student_age, presence: true
    validates :contact_name, presence: true, length: { minimum: 2, maximum: 60 }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :preferred_language, presence: true, inclusion: { in: %w[espanol aleman ingles] }
    validates :class_type, presence: true, inclusion: { in: %w[iniciacion_musical piano] }
    validates :availability, presence: true
    validates :privacy_accepted, acceptance: true
  end
end
