class AddTrialFieldsToWebsiteEnrollments < ActiveRecord::Migration[7.1]
  def change
    add_column :website_enrollments, :source, :string, default: "landing", null: false
    add_column :website_enrollments, :session_detail_id, :integer
    add_column :website_enrollments, :session_record_id, :integer
  end
end
