class CreateWebsiteApplicants < ActiveRecord::Migration[7.1]
  def change
    create_table :website_applicants do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :profession
      t.string :location
      t.string :availability
      t.text :message

      t.timestamps
    end
  end
end
