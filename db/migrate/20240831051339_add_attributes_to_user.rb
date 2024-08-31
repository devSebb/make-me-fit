class AddAttributesToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :current_weight, :integer
    add_column :users, :activity_level, :integer
    add_column :users, :workout_type, :string
    add_column :users, :fitness_goal, :string
    add_column :users, :food_preferences, :string
    add_column :users, :count_meals, :integer
    add_column :users, :snacks, :boolean
  end
end
