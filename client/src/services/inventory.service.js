import api from "./api";

export const inventoryService = {
  getAllItems: (params) => api.get("/inventory", { params }),
  getItemById: (id) => api.get(`/inventory/${id}`),
  createItem: (data) => api.post("/inventory", data),
  updateItem: (id, data) => api.put(`/inventory/${id}`, data),
  deleteItem: (id) => api.delete(`/inventory/${id}`),
  restockItem: (id, quantity) => api.patch(`/inventory/${id}/restock`, { quantity }),
  getLowStockItems: () => api.get("/inventory/low-stock"),
  getInventoryStats: () => api.get("/inventory/stats"),
  getBazar: (params) => api.get("/inventory/bazar", { params }),
  getBazarDefaults: (date) => api.get(`/inventory/bazar/defaults?date=${date}`),
  createBazar: (data) => api.post("/inventory/bazar", data),
  getStudents: () => api.get("/inventory/students"),
  getUtilities: (month, year) => api.get(`/inventory/utilities?month=${month}&year=${year}`),
  createUtility: (data) => api.post("/inventory/utilities", data),
  createAdvance: (data) => api.post("/inventory/advances", data),
};
