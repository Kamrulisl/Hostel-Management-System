import { useEffect, useState } from "react";
import { Box, Card, CardContent, Grid, TextField, Typography } from "@mui/material";
import { Assessment, People, Restaurant, ShoppingCart } from "@mui/icons-material";
import { motion } from "framer-motion";
import ModernLayout from "../../components/layout/ModernLayout";
import StatsCard from "../../components/common/StatsCard";
import ModernLineChart from "../../components/charts/ModernLineChart";
import ModernBarChart from "../../components/charts/ModernBarChart";
import { mealSelectionService } from "../../services/mealSelection.service";
import { inventoryService } from "../../services/inventory.service";
import { toISODate } from "../../utils/formatDate";

const Reports = () => {
  const today = toISODate(new Date());
  const [date, setDate] = useState(today);
  const [students, setStudents] = useState([]);
  const [counts, setCounts] = useState({});
  const [bazars, setBazars] = useState([]);
  const [trend, setTrend] = useState([]);

  useEffect(() => {
    load();
  }, [date]);

  const load = async () => {
    const selected = new Date(date);
    const dates = Array.from({ length: 7 }, (_, index) => {
      const item = new Date(selected);
      item.setDate(item.getDate() - (6 - index));
      return toISODate(item);
    });
    const [studentsRes, countsRes, bazarRes, trendResponses] = await Promise.all([
      inventoryService.getStudents(),
      mealSelectionService.getCookingCounts(date),
      inventoryService.getBazar({ month: selected.getMonth() + 1, year: selected.getFullYear() }),
      Promise.all(dates.map((day) => mealSelectionService.getCookingCounts(day))),
    ]);
    setStudents(studentsRes.data.users || []);
    setCounts(countsRes.data.counts || {});
    setBazars(bazarRes.data.bazars || []);
    setTrend(trendResponses.map((response, index) => ({
      date: dates[index],
      meals: Object.values(response.data.counts || {}).reduce((sum, meal) => sum + (meal.totalToCook || 0), 0),
    })));
  };

  const mealTypes = ["breakfast", "lunch", "dinner"];
  const totalToCook = mealTypes.reduce((sum, type) => sum + (counts[type]?.totalToCook || 0), 0);
  const monthlyBazar = bazars.reduce((sum, row) => sum + Number(row.totalAmount || 0), 0);

  return (
    <ModernLayout>
      <Box>
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }}>
          <div className="mb-6 bg-gradient-to-r from-violet-500 via-purple-500 to-indigo-600 rounded-2xl p-8 text-white shadow-xl shadow-purple-500/30">
            <div className="flex items-center gap-4">
              <Assessment sx={{ fontSize: 40 }} />
              <div>
                <h1 className="text-4xl font-bold mb-2">Meal & Bazar Reports</h1>
                <p className="text-purple-100">Cooking count, meal selection, and bazar cost report</p>
              </div>
            </div>
          </div>
        </motion.div>

        <Card sx={{ mb: 3 }}>
          <CardContent>
            <TextField type="date" label="Report Date" value={date} onChange={(e) => setDate(e.target.value)} InputLabelProps={{ shrink: true }} fullWidth />
          </CardContent>
        </Card>

        <Grid container spacing={3} sx={{ mb: 3 }}>
          <Grid item xs={12} sm={6} md={4}>
            <StatsCard title="Active Students" value={students.length} icon={People} color="primary" />
          </Grid>
          <Grid item xs={12} sm={6} md={4}>
            <StatsCard title="Today Meals To Cook" value={totalToCook} icon={Restaurant} color="success" />
          </Grid>
          <Grid item xs={12} sm={6} md={4}>
            <StatsCard title="Monthly Bazar" value={monthlyBazar} icon={ShoppingCart} color="warning" prefix="৳" />
          </Grid>
        </Grid>

        <Grid container spacing={3}>
          <Grid item xs={12} md={6}>
            <ModernBarChart
              title="Today Cooking Count"
              data={mealTypes.map((type) => counts[type]?.totalToCook || 0)}
              labels={["Breakfast", "Lunch", "Dinner"]}
              label="Meals"
            />
          </Grid>
          <Grid item xs={12} md={6}>
            <ModernLineChart
              title="Last 7 Days Meal Count"
              data={trend.map((row) => row.meals)}
              labels={trend.map((row) => row.date)}
              label="Meals"
            />
          </Grid>
          <Grid item xs={12}>
            <Card>
              <CardContent>
                <Typography variant="h6" fontWeight={700} gutterBottom>Monthly Bazar Entries</Typography>
                <div className="space-y-2">
                  {bazars.map((row) => (
                    <div key={row._id} className="flex justify-between rounded-lg bg-secondary-50 dark:bg-secondary-800 p-3">
                      <span>{String(row.date).slice(0, 10)} - {(row.items || []).map((item) => item.itemName).join(", ")}</span>
                      <strong>৳{row.totalAmount}</strong>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </Grid>
        </Grid>
      </Box>
    </ModernLayout>
  );
};

export default Reports;
