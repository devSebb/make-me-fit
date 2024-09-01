import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nutrition"
export default class extends Controller {
  static targets = ["nutritionPlan"]

  connect() {
    this.loadNutritionPlan();
  }

  loadNutritionPlan() {
    const nutritionPlanData = document.getElementById('nutrition-plan-data').dataset.nutritionPlan;
    if (nutritionPlanData) {
      const parsedData = JSON.parse(nutritionPlanData);
      this.renderNutritionPlan(parsedData);
    } else {
      this.nutritionPlanTarget.innerHTML = "<p class='text-red-500'>No nutrition plan available.</p>";
    }
  }

  renderNutritionPlan(plan) {
    // Assuming the plan is already formatted in the view
    this.nutritionPlanTarget.innerHTML = plan;
  }
}
