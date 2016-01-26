class User < ActiveRecord::Base
  has_many :tracks
  has_secure_password
  has_many :upvotes

#  def full_name
#    "#{firstname} #{lastname}"
#  end
end
