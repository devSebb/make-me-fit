import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nutrition"
export default class extends Controller {
  static targets = ["mealPlan", "nutritionPlan"]

  connect() {
    const mealPlanId = this.mealPlanTarget.dataset.id;

    fetch(`/meal_plans/${mealPlanId}`, {
      headers: {
        'Accept': 'application/json'
      }
    })
      .then(response => response.json())
      .then(data => {
        this.mealPlanTarget.textContent = JSON.stringify(data.meal_plan, null, 2);
        this.formatNutritionPlan(data.nutrition_plan);
      })
      .catch(error => {
        console.error("Error fetching nutrition plan:", error);
        this.nutritionPlanTarget.innerHTML = "<p class='text-red-500'>Error loading nutrition plan.</p>";
      });
  }

  formatNutritionPlan(plan) {
    const days = plan.split('---').map(day => day.trim());
    const formattedDays = days.map(day => this.formatDay(day));
    this.nutritionPlanTarget.innerHTML = formattedDays.join('');
  }

  formatDay(day) {
    const [dayTitle, ...mealSections] = day.split('**').filter(s => s.trim());
    const formattedMeals = mealSections.map(mealSection => {
      const [mealTitle, ...mealItems] = mealSection.split('\n').filter(s => s.trim());
      return `
        <div class="mb-4">
          <h4 class="font-semibold text-lg mb-2">${mealTitle}</h4>
          <ul class="list-disc pl-5">
            ${mealItems.map(item => `<li>${item.trim()}</li>`).join('')}
          </ul>
        </div>
      `;
    });

    const dailyTotals = formattedMeals.pop(); // Remove the last element (Daily Totals)

    return `
      <div class="bg-gray-100 p-4 rounded-lg">
        <h3 class="font-bold text-xl mb-4">${dayTitle}</h3>
        ${formattedMeals.join('')}
        <div class="mt-4 pt-4 border-t border-gray-300">
          <h4 class="font-semibold text-lg mb-2">Daily Totals</h4>
          ${dailyTotals}
        </div>
      </div>
    `;
  }
}
