class CreateCacheHitCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :cache_hit_counts do |t|
      t.string  :name,      null: false
      t.integer :page,      null: false, default: 1
      t.integer :hit_count, null: false, default: 0
      t.timestamps
    end
  end
end
