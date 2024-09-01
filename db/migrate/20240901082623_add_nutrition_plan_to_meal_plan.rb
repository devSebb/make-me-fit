class AddNutritionPlanToMealPlan < ActiveRecord::Migration[7.2]
  def change
    add_column :meal_plans, :nutrition_plan, :text
  end
end
