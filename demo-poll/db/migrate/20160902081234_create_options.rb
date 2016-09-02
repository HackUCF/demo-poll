class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :title
      t.references :poll, foreign_key: true
      t.integer :created_at, limit: 8
    end
  end
end
