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
  attr_accessible :name, :uid
end
