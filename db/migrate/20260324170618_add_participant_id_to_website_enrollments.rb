class AddParticipantIdToWebsiteEnrollments < ActiveRecord::Migration[7.1]
  def change
    add_column :website_enrollments, :participant_id, :integer
  end
end
