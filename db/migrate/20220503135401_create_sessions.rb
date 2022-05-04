class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :remember_digest
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
