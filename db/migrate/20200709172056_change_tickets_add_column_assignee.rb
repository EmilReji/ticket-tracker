class ChangeTicketsAddColumnAssignee < ActiveRecord::Migration[6.0]
  def change
    change_column :tickets, :creator, 'integer USING CAST(creator AS integer)'
    add_column :tickets, :assignee, :integer
  end
end
