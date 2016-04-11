class AddCompletedToSubtask < ActiveRecord::Migration
  def change
    add_column :subtasks, :completed, :boolean, default: false
  end
end
