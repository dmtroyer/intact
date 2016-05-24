class CreateHashedStrings < ActiveRecord::Migration
  def change
    create_table :hashed_strings do |t|
      t.string :original
      t.string :hashed
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
