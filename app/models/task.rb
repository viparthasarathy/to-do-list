class Task < ActiveRecord::Base
  validates_presence_of :taskname, :user
  belongs_to :user
  has_many :subtasks
end
