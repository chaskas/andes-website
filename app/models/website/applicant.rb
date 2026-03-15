module Website
  class Applicant < ApplicationRecord
    validates :name, presence: true, length: { minimum: 2, maximum: 60 }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :profession, presence: true, length: { maximum: 100 }
    validates :location, presence: true, length: { maximum: 100 }
    validates :availability, presence: true, length: { maximum: 200 }
    validates :phone, presence: true, length: { maximum: 20 }, format: { with: /\A\+?[\d\s\-()]+\z/, message: :invalid }
    validates :message, presence: true, length: { maximum: 1000 }
  end
end
