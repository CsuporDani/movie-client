class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string  :serial,  null: false, unique: true
      t.string  :title,   null: false
      t.integer :tmdb_id, null: false, unique: true
      t.string  :overview
      t.string  :poster_path
      t.timestamps
    end
  end
end
