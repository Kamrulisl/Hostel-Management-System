import { useEffect, useState } from "react";
import {
  Box,
  Grid,
  Typography,
  Card,
  CardContent,
  Button,
  List,
  ListItem,
  ListItemText,
  Chip,
} from "@mui/material";
import { People, ShoppingCart, TrendingUp, CheckCircle } from "@mui/icons-material";
import { motion } from "framer-motion";
import { useAuth } from "../../context/AuthContext";
import ModernLayout from "../../components/layout/ModernLayout";
import StatsCard from "../../components/common/StatsCard";
import ModernLineChart from "../../components/charts/ModernLineChart";
import ModernBarChart from "../../components/charts/ModernBarChart";
import { mealSelectionService } from "../../services/mealSelection.service";
import { inventoryService } from "../../services/inventory.service";
import { toISODate } from "../../utils/formatDate";

const ModernManagerDashboard = () => {
  const { user } = useAuth();
  const [stats, setStats] = useState({
    totalStudents: 0,
    todayMeals: 0,
    bazarEntries: 0,
    avgRating: 4.2,
  });
  const [mealData, setMealData] = useState([0, 0, 0]);
  const [bazarItems, setBazarItems] = useState([]);
  const [mealSelectionData, setMealSelectionData] = useState([0, 0, 0, 0, 0, 0, 0]);
  const mealSelectionLabels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  const mealLabels = ["Breakfast", "Lunch", "Dinner"];

  useEffect(() => {
    fetchDashboard();
  }, []);

  const fetchDashboard = async () => {
    const today = toISODate(new Date());
    try {
      const lastSevenDates = Array.from({ length: 7 }, (_, index) => {
        const date = new Date();
        date.setDate(date.getDate() - (6 - index));
        return toISODate(date);
      });
      const [usersRes, countsRes, bazarRes, defaultsRes, trendResponses] = await Promise.all([
        inventoryService.getStudents(),
        mealSelectionService.getCookingCounts(today),
        inventoryService.getBazar({ date: today }),
        inventoryService.getBazarDefaults(today),
        Promise.all(lastSevenDates.map((date) => mealSelectionService.getCookingCounts(date))),
      ]);
      const students = (usersRes.data.users || []).filter((item) => item.role === "student" && item.isActive !== false);
      const counts = countsRes.data.counts || {};
      const nextMealData = ["breakfast", "lunch", "dinner"].map(
        (mealType) => counts[mealType]?.totalToCook || 0,
      );
      const todayMeals = nextMealData.reduce((sum, count) => sum + count, 0);
      const bazars = bazarRes.data.bazars || [];
      const defaults = defaultsRes.data.defaults || [];
      setStats((current) => ({
        ...current,
        totalStudents: students.length,
        todayMeals,
        bazarEntries: bazars.length,
      }));
      setMealData(nextMealData);
      setMealSelectionData(
        trendResponses.map((response) => {
          const dayCounts = response.data.counts || {};
          return Object.values(dayCounts).reduce(
            (sum, meal) => sum + (meal.totalToCook || 0),
            0,
          );
        }),
      );
      setBazarItems(
        defaults.slice(0, 5).map((item) => ({
          name: item.itemName,
          quantity: item.quantity ? `${item.quantity} ${item.unit || ""}` : item.unit || "",
          status: bazars.length ? "added" : "planned",
        })),
      );
    } catch (error) {
      console.error("Error loading manager dashboard", error);
    }
  };

  const recentFeedback = [
    {
      student: "John Doe",
      rating: 5,
      comment: "Excellent food quality!",
      time: "2h ago",
    },
    {
      student: "Jane Smith",
      rating: 4,
      comment: "Good taste, needs more variety",
      time: "5h ago",
    },
    {
      student: "Mike Johnson",
      rating: 3,
      comment: "Average, could be better",
      time: "1d ago",
    },
  ];

  return (
    <ModernLayout>
      <Box>
        {/* Welcome Banner */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div className="mb-6 bg-gradient-to-r from-violet-500 via-purple-500 to-indigo-600 rounded-2xl p-8 text-white shadow-xl shadow-purple-500/30">
            <h1 className="text-4xl font-bold mb-2">Manager Dashboard 👨‍🍳</h1>
            <p className="text-purple-100">
              Welcome back, {user?.name}! Here's your mess overview for today.
            </p>
          </div>
        </motion.div>

        {/* Stats Cards */}
        <Grid container spacing={3} sx={{ mb: 3 }}>
          <Grid item xs={12} sm={6} md={3}>
            <StatsCard
              title="Total Students"
              value={stats.totalStudents}
              icon={People}
              color="primary"
            />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatsCard
              title="Today's Meals"
              value={stats.todayMeals}
              icon={CheckCircle}
              color="success"
              trend="up"
              trendValue="+3%"
            />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatsCard
              title="Bazar Entries"
              value={stats.bazarEntries}
              icon={ShoppingCart}
              color="error"
            />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatsCard
              title="Avg Rating"
              value={stats.avgRating}
              icon={TrendingUp}
              color="warning"
              decimals={1}
              suffix="/5"
            />
          </Grid>
        </Grid>

        <Grid container spacing={3}>
          {/* Meal Selection Trend Chart */}
          <Grid item xs={12} md={8}>
            <motion.div
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5, delay: 0.2 }}
            >
              <ModernLineChart
                title="Meal Selection Trend (Last 7 Days)"
                data={mealSelectionData}
                labels={mealSelectionLabels}
                label="Selected Meals"
              />
            </motion.div>

            {/* Meal Consumption Chart */}
            <motion.div
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5, delay: 0.3 }}
            >
              <Box sx={{ mt: 3 }}>
                <ModernBarChart
                  title="Today's Meal Consumption"
                  data={mealData}
                  labels={mealLabels}
                  label="Students"
                />
              </Box>
            </motion.div>
          </Grid>

          {/* Right Column */}
          <Grid item xs={12} md={4}>
            {/* Daily Bazar */}
            <motion.div
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5, delay: 0.2 }}
            >
              <Card sx={{ mb: 3 }}>
                <CardContent>
                  <Box
                    sx={{
                      display: "flex",
                      justifyContent: "space-between",
                      alignItems: "center",
                      mb: 2,
                    }}
                  >
                    <Typography variant="h6" fontWeight={600}>
                      Daily Bazar
                    </Typography>
                    <Chip
                      label={stats.bazarEntries}
                      color="primary"
                      size="small"
                      sx={{ fontWeight: 600 }}
                    />
                  </Box>
                  <List>
                    {bazarItems.length === 0 ? (
                      <ListItem>
                        <ListItemText primary="No bazar defaults found" secondary="Set weekly meal schedule first" />
                      </ListItem>
                    ) : bazarItems.map((item, index) => (
                      <ListItem
                        key={index}
                        sx={{
                          borderRadius: 2,
                          mb: 1,
                          backgroundColor:
                            item.status === "added"
                              ? "rgba(16, 185, 129, 0.1)"
                              : "rgba(245, 158, 11, 0.1)",
                        }}
                      >
                        <ListItemText
                          primary={item.name}
                          secondary={item.quantity}
                        />
                        <Chip
                          label={item.status}
                          size="small"
                          color={
                            item.status === "added" ? "success" : "warning"
                          }
                        />
                      </ListItem>
                    ))}
                  </List>
                  <Button fullWidth variant="contained" sx={{ mt: 2 }}>
                    Manage Daily Bazar
                  </Button>
                </CardContent>
              </Card>
            </motion.div>

            {/* Recent Feedback */}
            <motion.div
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5, delay: 0.3 }}
            >
              <Card>
                <CardContent>
                  <Typography variant="h6" fontWeight={600} gutterBottom>
                    Recent Feedback
                  </Typography>
                  <List>
                    {recentFeedback.map((feedback, index) => (
                      <ListItem
                        key={index}
                        sx={{
                          flexDirection: "column",
                          alignItems: "flex-start",
                          borderRadius: 2,
                          mb: 1,
                          backgroundColor: "action.hover",
                        }}
                      >
                        <Box
                          sx={{
                            display: "flex",
                            justifyContent: "space-between",
                            width: "100%",
                            mb: 0.5,
                          }}
                        >
                          <Typography variant="subtitle2" fontWeight={600}>
                            {feedback.student}
                          </Typography>
                          <Box sx={{ display: "flex", gap: 0.5 }}>
                            {[...Array(5)].map((_, i) => (
                              <Typography
                                key={i}
                                sx={{
                                  color:
                                    i < feedback.rating ? "#F59E0B" : "#E5E7EB",
                                  fontSize: "1rem",
                                }}
                              >
                                ★
                              </Typography>
                            ))}
                          </Box>
                        </Box>
                        <Typography
                          variant="body2"
                          color="text.secondary"
                          gutterBottom
                        >
                          {feedback.comment}
                        </Typography>
                        <Typography variant="caption" color="text.secondary">
                          {feedback.time}
                        </Typography>
                      </ListItem>
                    ))}
                  </List>
                  <Button fullWidth variant="text" sx={{ mt: 1 }}>
                    View All Feedback
                  </Button>
                </CardContent>
              </Card>
            </motion.div>
          </Grid>
        </Grid>
      </Box>
    </ModernLayout>
  );
};

export default ModernManagerDashboard;
