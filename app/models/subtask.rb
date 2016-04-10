class Subtask < ActiveRecord::Base
  validates_presence_of :details, :task
  belongs_to :task
  has_one :user, through: :task
end
