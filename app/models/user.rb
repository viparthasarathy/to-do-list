class User < ActiveRecord::Base
  validates_presence_of :username
  validates_uniqueness_of :username
  has_secure_password
  has_many :tasks
  has_many :subtasks, through: :tasks
end
