export const formatDate = (date) => {
  if (!date) return "";
  const d = new Date(date);
  return toISODate(d);
};

export const formatDateTime = (date) => {
  if (!date) return "";
  const d = new Date(date);
  const hours = String(d.getHours()).padStart(2, "0");
  const minutes = String(d.getMinutes()).padStart(2, "0");
  return `${toISODate(d)} ${hours}:${minutes}`;
};

export const toISODate = (date) => {
  if (!date) return "";
  const d = new Date(date);
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
};

export const getCurrentMonth = () => {
  return new Date().getMonth() + 1;
};

export const getCurrentYear = () => {
  return new Date().getFullYear();
};
