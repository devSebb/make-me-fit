class MealPlansController < ApplicationController
  def show
    @meal_plan = MealPlan.find(params[:id])
  end

  def new
  end

  def create
  end
end
