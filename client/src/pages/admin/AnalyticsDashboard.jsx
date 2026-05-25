import { useEffect, useState } from "react";
import { Box, Card, CardContent, Grid, Typography } from "@mui/material";
import { People, Receipt, ShoppingCart, WarningAmber } from "@mui/icons-material";
import { motion } from "framer-motion";
import ModernLayout from "../../components/layout/ModernLayout";
import StatsCard from "../../components/common/StatsCard";
import ModernBarChart from "../../components/charts/ModernBarChart";
import ModernLineChart from "../../components/charts/ModernLineChart";
import { analyticsService } from "../../services/analytics.service";

const monthLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

const AnalyticsDashboard = () => {
  const [overview, setOverview] = useState({});
  const [billingTrends, setBillingTrends] = useState([]);
  const [mealTrends, setMealTrends] = useState([]);

  useEffect(() => {
    loadAnalytics();
  }, []);

  const loadAnalytics = async () => {
    const [overviewRes, billingRes, mealsRes] = await Promise.all([
      analyticsService.overview(),
      analyticsService.billingTrends(new Date().getFullYear()),
      analyticsService.mealTrends(7),
    ]);
    setOverview(overviewRes.data || {});
    setBillingTrends(billingRes.data.trends || []);
    setMealTrends(mealsRes.data.trends || []);
  };

  return (
    <ModernLayout>
      <Box>
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }}>
          <Card sx={{ mb: 3, background: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)", color: "white" }}>
            <CardContent sx={{ py: 3 }}>
              <Typography variant="h4" fontWeight={700} gutterBottom>
                Analytics Dashboard
              </Typography>
              <Typography variant="body1" sx={{ opacity: 0.9 }}>
                Meal, bazar, billing, and due overview
              </Typography>
            </CardContent>
          </Card>
        </motion.div>

        <Grid container spacing={3} sx={{ mb: 3 }}>
          <Grid item xs={12} sm={6} md={3}>
            <StatsCard title="Active Students" value={overview.totalStudents || 0} icon={People} color="primary" />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatsCard title="Total Billed" value={overview.totalBilled || 0} icon={Receipt} color="success" prefix="৳" />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatsCard title="Bazar Cost" value={overview.totalBazar || 0} icon={ShoppingCart} color="warning" prefix="৳" />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <StatsCard title="Total Due" value={overview.totalDue || 0} icon={WarningAmber} color="error" prefix="৳" />
          </Grid>
        </Grid>

        <Grid container spacing={3}>
          <Grid item xs={12} lg={6}>
            <ModernBarChart
              title="Monthly Billed Amount"
              data={monthLabels.map((_, index) => billingTrends.find((row) => row.month === index + 1)?.billed || 0)}
              labels={monthLabels}
              label="Billed (৳)"
            />
          </Grid>
          <Grid item xs={12} lg={6}>
            <ModernBarChart
              title="Monthly Bazar Cost"
              data={monthLabels.map((_, index) => billingTrends.find((row) => row.month === index + 1)?.bazar || 0)}
              labels={monthLabels}
              label="Bazar (৳)"
            />
          </Grid>
          <Grid item xs={12}>
            <ModernLineChart
              title="Last 7 Days Meal Count"
              data={mealTrends.map((row) => row.meals || 0)}
              labels={mealTrends.map((row) => String(row.date).slice(0, 10))}
              label="Meals"
            />
          </Grid>
        </Grid>
      </Box>
    </ModernLayout>
  );
};

export default AnalyticsDashboard;
