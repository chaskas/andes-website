module Website
  class Enrollment < ApplicationRecord
    # Common validations
    validates :student_name, presence: true, length: { minimum: 2, maximum: 60 }
    validates :student_age, presence: true
    validates :contact_name, presence: true, length: { minimum: 2, maximum: 60 }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :privacy_accepted, acceptance: true

    # Landing-only validations
    validates :preferred_language, presence: true, inclusion: { in: %w[espanol aleman ingles] }, if: :landing?
    validates :class_type, presence: true, inclusion: { in: %w[iniciacion_musical piano] }, if: :landing?
    validates :availability, presence: true, if: :landing?

    # Trial-only validations
    validates :session_detail_id, presence: true, if: :trial?
    validates :session_record_id, presence: true, if: :trial?
    validates :participant_id, presence: true, if: :trial?

    def landing?
      source == "landing"
    end

    def trial?
      source == "trial"
    end
  end
end
