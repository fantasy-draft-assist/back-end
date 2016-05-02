class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string	:first_name
      t.string  :last_name
      t.integer :yahoo_player_id
      t.text    :headshot_url
      t.integer :uniform_number
      t.string  :positions, array: true

      t.timestamps null: false
    end
  end
end
