class UserDatum < ApplicationRecord
  belongs_to :user, optional: true  # Add 'optional: true' if user association is not required at this stage

  attr_accessor :step

  validates :age, :gender, :current_weight, presence: true, if: -> { step.to_i >= 1 }
  validates :activity_level, :workout_type, :fitness_goal, presence: true, if: -> { step.to_i >= 2 }
  validates :food_preferences, :count_meals, presence: true, if: -> { step.to_i == 3 }
end
