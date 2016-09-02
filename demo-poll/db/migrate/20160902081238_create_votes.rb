class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :weight, default: 1
      t.string :ip
      t.references :option, foreign_key: true
      t.integer :created_at, limit: 8
    end
  end
end
