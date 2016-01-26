class Track < ActiveRecord::Base
  validates_presence_of :song_title, :author
  belongs_to :user
  has_many :upvotes
end
