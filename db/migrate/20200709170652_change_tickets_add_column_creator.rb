class ChangeTicketsAddColumnCreator < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :creator, :string
  end
end
