class UserDatum < ApplicationRecord
  belongs_to :user, optional: true
  validates :user_id, uniqueness: true, allow_nil: true

  attr_accessor :step

  validates :age, :gender, :current_weight, presence: true, if: -> { step.to_i >= 1 }
  validates :activity_level, :workout_type, :fitness_goal, presence: true, if: -> { step.to_i >= 2 }
  validates :food_preferences, :count_meals, presence: true, if: -> { step.to_i == 3 }
end
