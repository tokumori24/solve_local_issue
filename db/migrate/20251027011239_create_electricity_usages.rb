class CreateElectricityUsages < ActiveRecord::Migration[8.0]
  def change
    create_table :electricity_usages do |t|
      t.integer :month
      t.integer :year
      t.decimal :usage

      t.timestamps
    end
  end
end
