import api from "./api";

export const analyticsService = {
  overview: () => api.get("/analytics/overview"),
  mealTrends: (days = 7) => api.get(`/analytics/meal-trends?days=${days}`),
  billingTrends: (year) => api.get(`/analytics/billing-trends${year ? `?year=${year}` : ""}`),
  feedback: () => api.get("/analytics/feedback"),
  complaints: () => api.get("/analytics/complaints"),
};
