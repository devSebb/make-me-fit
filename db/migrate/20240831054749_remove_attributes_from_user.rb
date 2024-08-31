class RemoveAttributesFromUser < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :age, :string
    remove_column :users, :gender, :string
    remove_column :users, :current_weight, :integer
    remove_column :users, :activity_level, :integer
    remove_column :users, :workout_type, :string
    remove_column :users, :fitness_goal, :string
    remove_column :users, :food_preferences, :string
    remove_column :users, :count_meals, :integer
    remove_column :users, :snacks, :boolean
  end
end
