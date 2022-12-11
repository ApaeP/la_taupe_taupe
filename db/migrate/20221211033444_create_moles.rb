class CreateMoles < ActiveRecord::Migration[7.0]
  def change
    create_table :moles do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.float :weight
      t.float :length
      t.float :width
      t.float :height
      t.integer :shade, index: true
      t.string :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
