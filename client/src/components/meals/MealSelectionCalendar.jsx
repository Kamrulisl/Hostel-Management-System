import { useState, useEffect } from 'react';
import { mealSelectionService } from '../../services/mealSelection.service';
import toast from 'react-hot-toast';
import { toISODate } from '../../utils/formatDate';

const mealTypes = ['breakfast', 'lunch', 'dinner'];

const MealSelectionCalendar = ({ year, month }) => {
  const [mealSelections, setMealSelections] = useState([]);
  const [schedule, setSchedule] = useState([]);
  const [holidayMode, setHolidayMode] = useState({ isEnabled: false });
  const [loading, setLoading] = useState(true);
  const [selectedDate, setSelectedDate] = useState(null);
  const [selectedChoices, setSelectedChoices] = useState({
    breakfast: 'default',
    lunch: 'default',
    dinner: 'default',
  });

  useEffect(() => {
    fetchMealCalendar();
  }, [year, month]);

  const fetchMealCalendar = async () => {
    try {
      setLoading(true);
      const [calendarRes, scheduleRes, holidayRes] = await Promise.all([
        mealSelectionService.getMealCalendar(year, month),
        mealSelectionService.getWeeklySchedule(),
        mealSelectionService.getHolidayMode(),
      ]);
      setMealSelections(calendarRes.data.mealSelections || []);
      setSchedule(scheduleRes.data.schedule || []);
      setHolidayMode(holidayRes.data.holidayMode || { isEnabled: false });
    } catch (error) {
      console.error('Error fetching meal calendar:', error);
      toast.error('Failed to load meal calendar');
    } finally {
      setLoading(false);
    }
  };

  const getMealForDate = (date) => {
    const dateStr = toISODate(date);
    return mealSelections.find((m) => toISODate(m.date) === dateStr);
  };

  const getSchedule = (date, mealType) =>
    schedule.find((row) => row.dayOfWeek === date.getDay() && row.mealType === mealType);

  const handleDateClick = (date) => {
    const meal = getMealForDate(date);
    setSelectedDate(date);
    setSelectedChoices({
      breakfast: meal?.choices?.breakfast?.choice || 'default',
      lunch: meal?.choices?.lunch?.choice || 'default',
      dinner: meal?.choices?.dinner?.choice || 'default',
    });
  };

  const handleSaveMeal = async (mealType) => {
    if (!selectedDate) return;
    try {
      await mealSelectionService.requestMealChange(toISODate(selectedDate), mealType, selectedChoices[mealType]);
      toast.success(selectedChoices[mealType] === 'default' ? 'Default meal approved' : 'Request sent for approval');
      await fetchMealCalendar();
    } catch (error) {
      toast.error(error.message || 'Failed to save meal');
    }
  };

  const handleHolidayToggle = async () => {
    try {
      await mealSelectionService.updateHolidayMode({ isEnabled: !holidayMode.isEnabled });
      toast.success(!holidayMode.isEnabled ? 'Holiday mode enabled' : 'Holiday mode disabled');
      await fetchMealCalendar();
    } catch (error) {
      toast.error(error.message || 'Failed to update holiday mode');
    }
  };

  const days = [];
  const firstDay = new Date(year, month - 1, 1).getDay();
  const daysInMonth = new Date(year, month, 0).getDate();
  for (let i = 0; i < firstDay; i++) days.push(null);
  for (let i = 1; i <= daysInMonth; i++) days.push(new Date(year, month - 1, i));

  const monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  return (
    <div className="bg-white dark:bg-secondary-800 rounded-2xl p-6 shadow-lg">
      <div className="flex items-center justify-between gap-4 mb-6">
        <h2 className="text-2xl font-bold gradient-text">
          {monthNames[month - 1]} {year}
        </h2>
        <button
          onClick={handleHolidayToggle}
          className={`px-4 py-2 rounded-lg font-semibold transition-all ${
            holidayMode.isEnabled
              ? 'bg-rose-100 text-rose-700 dark:bg-rose-900/30 dark:text-rose-300'
              : 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300'
          }`}
        >
          Holiday Mode: {holidayMode.isEnabled ? 'On' : 'Off'}
        </button>
      </div>

      {loading ? (
        <div className="text-center py-12">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-purple-600 mx-auto" />
        </div>
      ) : (
        <>
          <div className="grid grid-cols-7 gap-2 mb-6">
            {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) => (
              <div key={day} className="text-center font-semibold text-secondary-600 dark:text-secondary-400 py-2">
                {day}
              </div>
            ))}

            {days.map((date, index) => {
              if (!date) return <div key={`empty-${index}`} className="p-2" />;

              const meal = getMealForDate(date);
              const mealCount = mealTypes.filter((type) => meal?.meals?.[type]).length;
              const pendingCount = mealTypes.filter((type) => meal?.choices?.[type]?.status === 'pending').length;
              const isSelected = selectedDate && selectedDate.toDateString() === date.toDateString();

              return (
                <button
                  key={date.toISOString()}
                  onClick={() => handleDateClick(date)}
                  className={`p-3 rounded-lg font-semibold transition-all duration-300 min-h-[76px] ${
                    isSelected
                      ? 'bg-gradient-to-br from-violet-500 to-purple-600 text-white shadow-lg'
                      : pendingCount > 0
                      ? 'bg-amber-100 text-amber-800 dark:bg-amber-900/30 dark:text-amber-300'
                      : mealCount > 0
                      ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400'
                      : 'bg-secondary-100 dark:bg-secondary-700 text-secondary-700 dark:text-secondary-300'
                  }`}
                >
                  <div className="text-sm">{date.getDate()}</div>
                  <div className="text-xs mt-1 opacity-80">{mealCount} meals</div>
                  {pendingCount > 0 && <div className="text-xs mt-1">Pending {pendingCount}</div>}
                </button>
              );
            })}
          </div>

          {selectedDate && (
            <div className="bg-gradient-to-br from-violet-50 to-purple-50 dark:from-violet-900/20 dark:to-purple-900/20 rounded-xl p-6 border border-violet-200 dark:border-violet-800">
              <h3 className="text-lg font-bold mb-4">
                {selectedDate.toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}
              </h3>

              <div className="space-y-4">
                {mealTypes.map((mealType) => {
                  const daySchedule = getSchedule(selectedDate, mealType);
                  const status = getMealForDate(selectedDate)?.choices?.[mealType]?.status || 'approved';

                  return (
                    <div key={mealType} className="p-4 bg-white dark:bg-secondary-700 rounded-lg">
                      <div className="flex items-center justify-between gap-3 mb-3">
                        <div>
                          <div className="font-semibold capitalize text-secondary-800 dark:text-secondary-100">{mealType}</div>
                          <div className="text-sm text-secondary-500">Status: {status}</div>
                        </div>
                        <button
                          onClick={() => handleSaveMeal(mealType)}
                          className="px-4 py-2 bg-violet-600 text-white rounded-lg font-semibold hover:bg-violet-700"
                        >
                          Save
                        </button>
                      </div>

                      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                        {['default', 'alternative', 'cancel'].map((choice) => (
                          <label key={choice} className="flex items-start gap-2 p-3 border border-secondary-200 dark:border-secondary-600 rounded-lg cursor-pointer">
                            <input
                              type="radio"
                              checked={selectedChoices[mealType] === choice}
                              onChange={() => setSelectedChoices((prev) => ({ ...prev, [mealType]: choice }))}
                              className="mt-1 accent-purple-600"
                            />
                            <span>
                              <span className="block font-semibold capitalize">{choice}</span>
                              <span className="block text-xs text-secondary-500">
                                {choice === 'default'
                                  ? (daySchedule?.defaultItems || []).map((item) => item.name).join(', ')
                                  : choice === 'alternative'
                                  ? (daySchedule?.alternativeItems || []).map((item) => item.name).join(', ')
                                  : 'No meal will be cooked'}
                              </span>
                            </span>
                          </label>
                        ))}
                      </div>
                    </div>
                  );
                })}
              </div>

              <button
                onClick={() => setSelectedDate(null)}
                className="mt-4 w-full px-4 py-2 bg-secondary-200 dark:bg-secondary-700 text-secondary-700 dark:text-secondary-300 rounded-lg font-semibold"
              >
                Close
              </button>
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default MealSelectionCalendar;
