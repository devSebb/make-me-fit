class MealPlansController < ApplicationController
  def show
    @meal_plan = MealPlan.find(params[:id])
    @user = @meal_plan.user
    @user_data = @user.user_datum

    @nutrition_plan = NutritionAnalysisService.new(@user_data).generate_weekly_plan

    respond_to do |format|
      format.html
      format.json { render json: { meal_plan: @meal_plan, nutrition_plan: @nutrition_plan } }
    end
  end

  def create
    @user_data = current_user.user_datum
    @meal_plan = MealPlan.create(user: current_user)
    redirect_to meal_plan_path(@meal_plan)
  end
end
