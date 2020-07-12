class AddUserAndTimeLimit < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
     dir.up do
        add_column :roles, :user_limit, :integer, default: 100
        add_column :roles, :time_limit, :integer, default: 100
      end
      dir.down do
        remove_column :roles, :user_limit, :integer
        remove_column :roles, :time_limit, :integer
      end
    end
  end
end
