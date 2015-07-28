class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :track_num, null: false
      t.integer :album_id, null: false
      t.string :song_type, null: false
      t.text :lyrics

    end

    add_index :tracks, :album_id
  end
end
