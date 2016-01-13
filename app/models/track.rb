class Track < ActiveRecord::Base
  validates_presence_of :song_title, :author
end
