class CreateUserData < ActiveRecord::Migration[7.2]
  def change
    create_table :user_data do |t|
      t.integer :age
      t.string :gender
      t.integer :current_weight
      t.integer :activity_level
      t.string :workout_type
      t.string :fitness_goal
      t.string :food_preferences
      t.integer :count_meals
      t.boolean :snacks
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
