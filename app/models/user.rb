# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  validates :name, presence: true

  def self.from_omniauth(auth)
    where(auth.slice("uid")).first || create_from_omniauth(auth)
  end
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end
end
