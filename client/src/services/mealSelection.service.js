import api from "./api";

export const mealSelectionService = {
  // Select meals for a single day
  selectMealsForDay: (date, meals) =>
    api.post("/meals/select", { date, meals }),

  // Bulk select meals for a date range
  selectMealsForDateRange: (startDate, endDate, meals) =>
    api.post("/meals/bulk", { startDate, endDate, meals }),

  // Get meal calendar for a month
  getMealCalendar: (year, month) =>
    api.get(`/meals/my-calendar?year=${year}&month=${month}`),

  // Get meal summary for a month
  getMealSummary: (year, month) =>
    api.get(`/meals/summary?year=${year}&month=${month}`),

  // Admin: Get daily meal counts
  getDailyMealCounts: (date) =>
    api.get(`/meals/daily-counts?date=${date}`),

  // Admin: Get meal selections for date range
  getMealSelectionsForDateRange: (startDate, endDate) =>
    api.get(`/meals/range?startDate=${startDate}&endDate=${endDate}`),

  getWeeklySchedule: () => api.get("/meals/weekly-schedule"),

  updateWeeklySchedule: (schedule) =>
    api.put("/meals/weekly-schedule", { schedule }),

  requestMealChange: (date, mealType, choice, note = "") =>
    api.post("/meals/select", { date, mealType, choice, note }),

  getPendingMealRequests: (date) =>
    api.get(`/meals/pending${date ? `?date=${date}` : ""}`),

  approveMealRequest: (id, mealType) =>
    api.patch(`/meals/${id}/approve`, { mealType }),

  approveAllPendingMealRequests: (date) =>
    api.patch("/meals/approve-pending", date ? { date } : {}),

  getCookingCounts: (date) =>
    api.get(`/meals/cooking-counts${date ? `?date=${date}` : ""}`),

  getHolidayMode: () => api.get("/meals/holiday-mode"),

  updateHolidayMode: (payload) => api.post("/meals/holiday-mode", payload),
};
