class Subtask < ActiveRecord::Base
  validates_presence_of :details
  belongs_to :task
  has_one :user, through: :task
end
