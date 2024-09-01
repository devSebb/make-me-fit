class MealPlan < ApplicationRecord
  belongs_to :user
  attribute :nutrition_plan, :json

  def nutrition_plan
    super || {}
  end
end
