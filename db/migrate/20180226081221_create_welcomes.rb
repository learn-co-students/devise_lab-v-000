class CreateWelcomes < ActiveRecord::Migration
  def change
    create_table :welcomes do |t|
      t.string :home
      t.string :about

      t.timestamps null: false
    end
  end
end
