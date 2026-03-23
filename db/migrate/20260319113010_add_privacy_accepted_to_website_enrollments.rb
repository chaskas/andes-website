class AddPrivacyAcceptedToWebsiteEnrollments < ActiveRecord::Migration[7.1]
  def change
    add_column :website_enrollments, :privacy_accepted, :boolean, default: false, null: false
  end
end
