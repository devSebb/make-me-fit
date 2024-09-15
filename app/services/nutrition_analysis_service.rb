class NutritionAnalysisService
  def initialize(user_data)
    @user_data = user_data
  end

  def generate_weekly_plan
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [ { role: "user", content: nutrition_prompt(@user_data) } ],
        max_tokens: 1000,
        temperature: 0.7
      }
    )
    response.dig("choices", 0, "message", "content")&.strip
  rescue StandardError => e
    Rails.logger.error("Error generating nutrition plan: #{e.message}")
    nil
  end

  private

  def nutrition_prompt(user_data)
    <<~PROMPT
      Create a 3-day meal plan for a #{user_data.age}-year-old #{user_data.gender}, #{user_data.current_weight} kg, exercises #{user_data.activity_level} times/week (#{user_data.workout_type}), goal: #{user_data.fitness_goal}, food preferences: #{user_data.food_preferences}, #{user_data.count_meals} meals/day#{user_data.snacks ? ' with snacks' : ''}, minimum 1800 calories/day. Base the plan on current nutritional research to optimize performance and recovery. Include daily totals of calories, proteins, carbs, fats. No introductions or special characters.

      Present the plan in the following format, separating each day with '---':

      Day 1

      Breakfast
      - Meal item 1
      - Meal item 2

      #{user_data.snacks ? "Snack\n- Snack item\n\n" : ""}Lunch
      - Meal item 1
      - Meal item 2

      #{user_data.snacks ? "Snack\n- Snack item\n\n" : ""}Dinner
      - Meal item 1
      - Meal item 2

      Total Daily Intake
      - Calories: XXX kcal
      - Protein: XX g
      - Carbohydrates: XX g
      - Fats: XX g

      ---

      Repeat this format for Day 2 and Day 3.
    PROMPT
  end
end
