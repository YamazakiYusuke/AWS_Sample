class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit, :datetime, null: false, default: '2021-1-1 0:0:0'
    add_column :tasks, :status, :string, default: '未着手'
    add_column :tasks, :priority, :integer, default: 0
  end
end
