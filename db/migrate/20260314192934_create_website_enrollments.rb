class CreateWebsiteEnrollments < ActiveRecord::Migration[7.1]
  def change
    create_table :website_enrollments do |t|
      t.string :student_name
      t.string :student_age
      t.string :contact_name
      t.string :email
      t.string :phone
      t.string :preferred_language
      t.string :class_type
      t.string :availability
      t.text :comments

      t.timestamps
    end
  end
end
