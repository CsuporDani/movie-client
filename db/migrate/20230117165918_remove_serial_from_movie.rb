class RemoveSerialFromMovie < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :serial, :string
  end
end
