# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  band_id    :integer          not null
#  album_type :string(255)      not null
#

class Album < ActiveRecord::Base
  ALBUM_TYPES = %w(Recorded Live)
  
  validates :name, :band_id, :album_type, presence: :true
  validates :album_type, inclusion: {in: ALBUM_TYPES}

  belongs_to :band,
    class_name: 'Band',
    foreign_key: :band_id,
    primary_key: :id

  has_many :tracks,
    class_name: 'Track',
    foreign_key: :album_id,
    primary_key: :id,
    dependent: :destroy

end
