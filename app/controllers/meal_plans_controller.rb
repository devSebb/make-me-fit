class MealPlansController < ApplicationController
  def show
    @meal_plan = current_user.meal_plan
    @user_data = current_user.user_datum

    if @meal_plan.nil?
      redirect_to user_data_index_path, alert: "No meal plan found. Please generate a meal plan first."
    else
      # Ensure nutrition_plan is not nil
      @meal_plan.nutrition_plan ||= "No nutrition plan available."

      @nutrition_plan = @meal_plan.nutrition_plan

      respond_to do |format|
        format.html
        format.json { render json: { meal_plan: @meal_plan.as_json(except: :nutrition_plan), nutrition_plan: @meal_plan.nutrition_plan } }
      end
    end
  end

  def create
    @meal_plan = current_user.meal_plan || current_user.build_meal_plan
    nutrition_plan = NutritionAnalysisService.new(current_user.user_datum).generate_weekly_plan
    @meal_plan.nutrition_plan = nutrition_plan

    if @meal_plan.save
      redirect_to user_data_path(current_user.user_datum), notice: "Meal plan was successfully created."
    else
      redirect_to user_data_index_path, alert: "Failed to create meal plan."
    end
  end
end
