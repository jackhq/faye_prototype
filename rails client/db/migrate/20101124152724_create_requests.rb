class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.datetime :sent_date
      t.text :description
      t.datetime :received_date
      t.string :confirmation_number
      
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
