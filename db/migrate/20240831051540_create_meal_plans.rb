class CreateMealPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :meal_plans do |t|
      t.integer :daily_calories
      t.text :meal_description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
