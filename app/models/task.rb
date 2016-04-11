class Task < ActiveRecord::Base
  validates_presence_of :taskname
  belongs_to :user
  has_many :subtasks
end
