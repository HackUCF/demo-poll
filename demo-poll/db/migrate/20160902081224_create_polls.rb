class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.string :title
      t.string :description
      t.integer :created_at, limit: 8
    end
  end
end
