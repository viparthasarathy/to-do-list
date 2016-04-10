class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.string :details
      t.integer :task_id
    end
  end
end
