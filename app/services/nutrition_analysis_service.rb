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
      Create a 3-day nutrition plan for a #{user_data.age}-year-old #{user_data.gender} weighing #{user_data.current_weight} pounds who works out #{user_data.activity_level} times per week, primarily doing #{user_data.workout_type}. Goal is to #{user_data.fitness_goal}. Food preferences are #{user_data.food_preferences}. Provide #{user_data.count_meals} meals with #{user_data.snacks ? 'some' : 'no'} snacks. Include daily totals for calories, proteins, carbohydrates, and fats. Exclude any introductory text and special characters.
    PROMPT
  end
end
