class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.string :id_friend

      t.timestamps
    end
  end
end
