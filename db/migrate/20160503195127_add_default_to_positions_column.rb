class AddDefaultToPositionsColumn < ActiveRecord::Migration
  def change
  	change_column_default(:players, :positions, [])
  end
end
