# == Schema Information
#
# Table name: tracks
#
#  id        :integer          not null, primary key
#  name      :string(255)      not null
#  track_num :integer          not null
#  album_id  :integer          not null
#  song_type :string(255)      not null
#  lyrics    :text
#

class Track < ActiveRecord::Base
  SONG_TYPES = %w(Regular Bonus)

  validates :name, :track_num, :album_id, :song_type, presence: :true
  validates :song_type, inclusion: { in: SONG_TYPES }

  belongs_to :album,
    class_name: 'Album',
    foreign_key: :album_id,
    primary_key: :id

  has_one :band, through: :album, source: :band
end
