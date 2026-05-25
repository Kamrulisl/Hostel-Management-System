import { useEffect, useState } from 'react';
import ModernLayout from '../../components/layout/ModernLayout';
import { inventoryService } from '../../services/inventory.service';
import { toISODate } from '../../utils/formatDate';
import toast from 'react-hot-toast';

const emptyItem = { itemName: '', quantity: '', unit: 'kg', price: '', total: '' };
const utilityTypes = [
  { value: 'gas', label: 'Gas' },
  { value: 'electricity', label: 'Electricity' },
  { value: 'water', label: 'Water' },
  { value: 'manager_salary', label: 'Manager Salary' },
  { value: 'assistant_manager_salary', label: 'Assistant Manager Salary' },
  { value: 'other', label: 'Other' },
];

const Inventory = () => {
  const today = toISODate(new Date());
  const now = new Date();
  const [date, setDate] = useState(today);
  const [items, setItems] = useState([emptyItem]);
  const [bazars, setBazars] = useState([]);
  const [utilities, setUtilities] = useState([]);
  const [students, setStudents] = useState([]);
  const [utility, setUtility] = useState({ type: 'gas', customType: '', amount: '', notes: '' });
  const [advance, setAdvance] = useState({ studentId: '', date: today, amount: '', notes: '' });
  const [studentSearch, setStudentSearch] = useState('');

  useEffect(() => {
    load();
  }, [date]);

  const load = async () => {
    const month = new Date(date).getMonth() + 1;
    const year = new Date(date).getFullYear();
    const [defaultsRes, bazarRes, utilityRes, userRes] = await Promise.all([
      inventoryService.getBazarDefaults(date),
      inventoryService.getBazar({ date }),
      inventoryService.getUtilities(month, year),
      inventoryService.getStudents(),
    ]);
    const defaults = defaultsRes.data.defaults || [];
    setItems(defaults.length ? defaults : [emptyItem]);
    setBazars(bazarRes.data.bazars || []);
    setUtilities(utilityRes.data.utilities || []);
    setStudents(userRes.data.users || []);
  };

  const updateItem = (index, field, value) => {
    setItems((current) => current.map((item, i) => {
      if (i !== index) return item;
      const next = { ...item, [field]: value };
      const quantity = parseFloat(next.quantity) || 0;
      const price = parseFloat(next.price) || 0;
      next.total = field === 'total' ? value : quantity * price;
      return next;
    }));
  };

  const saveBazar = async () => {
    const cleanItems = items.filter((item) => item.itemName && Number(item.total || 0) > 0);
    if (!cleanItems.length) {
      toast.error('Add at least one bazar item with price');
      return;
    }
    await inventoryService.createBazar({ date, items: cleanItems });
    toast.success('Daily bazar added');
    load();
  };

  const saveUtility = async () => {
    const month = now.getMonth() + 1;
    const year = now.getFullYear();
    const type = utility.type === 'other' ? utility.customType.trim() : utility.type;
    if (!type || !utility.amount) {
      toast.error('Select utility type and amount');
      return;
    }
    await inventoryService.createUtility({ month, year, type, notes: utility.notes, amount: Number(utility.amount) || 0 });
    toast.success('Utility expense added');
    setUtility({ type: 'gas', customType: '', amount: '', notes: '' });
    load();
  };

  const saveAdvance = async () => {
    if (!advance.studentId || !advance.amount) {
      toast.error('Select student and amount');
      return;
    }
    await inventoryService.createAdvance({ ...advance, amount: Number(advance.amount) || 0 });
    toast.success('Advance payment saved');
    setAdvance({ studentId: '', date: today, amount: '', notes: '' });
  };

  const totalToday = bazars.reduce((sum, row) => sum + Number(row.totalAmount || 0), 0);
  const utilityTotal = utilities.reduce((sum, row) => sum + Number(row.amount || 0), 0);
  const filteredStudents = students.filter((student) => {
    const term = studentSearch.trim().toLowerCase();
    if (!term) return true;
    return (
      student.name?.toLowerCase().includes(term) ||
      student.rollNumber?.toLowerCase().includes(term) ||
      student.roomNumber?.toLowerCase().includes(term)
    );
  });
  const selectedStudent = students.find((student) => student._id === advance.studentId);

  return (
    <ModernLayout>
      <div className="space-y-6">
        <div className="bg-gradient-to-r from-violet-500 via-purple-500 to-indigo-600 rounded-2xl p-8 text-white shadow-xl shadow-purple-500/30">
          <h1 className="text-4xl font-bold mb-2">Daily Bazar</h1>
          <p className="text-purple-100">Add daily market purchases, utilities, salary, and student advance payments.</p>
        </div>

        <div className="card p-6">
          <div className="flex flex-col md:flex-row gap-4 md:items-center md:justify-between mb-4">
            <h2 className="text-xl font-bold gradient-text">Bazar Entry</h2>
            <input type="date" value={date} onChange={(event) => setDate(event.target.value)} className="px-3 py-2 rounded-lg border" />
          </div>

          <div className="space-y-3">
            {items.map((item, index) => (
              <div key={index} className="grid grid-cols-1 md:grid-cols-5 gap-3">
                <input value={item.itemName} onChange={(e) => updateItem(index, 'itemName', e.target.value)} placeholder="Item" className="px-3 py-2 rounded-lg border" />
                <input value={item.quantity} onChange={(e) => updateItem(index, 'quantity', e.target.value)} placeholder="Quantity" className="px-3 py-2 rounded-lg border" />
                <input value={item.unit} onChange={(e) => updateItem(index, 'unit', e.target.value)} placeholder="Unit" className="px-3 py-2 rounded-lg border" />
                <input value={item.price} onChange={(e) => updateItem(index, 'price', e.target.value)} placeholder="Unit price" className="px-3 py-2 rounded-lg border" />
                <input value={item.total} onChange={(e) => updateItem(index, 'total', e.target.value)} placeholder="Total" className="px-3 py-2 rounded-lg border" />
              </div>
            ))}
          </div>

          <div className="flex gap-3 mt-4">
            <button onClick={() => setItems((current) => [...current, emptyItem])} className="px-4 py-2 rounded-lg bg-secondary-100 font-semibold">Add Manual Item</button>
            <button onClick={saveBazar} className="px-4 py-2 rounded-lg bg-violet-600 text-white font-semibold">Save Bazar</button>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="card p-6">
            <h2 className="text-xl font-bold gradient-text mb-4">Today Bazar List</h2>
            <p className="font-semibold mb-3">Total: Tk {totalToday}</p>
            <div className="space-y-3">
              {bazars.map((row) => (
                <div key={row._id} className="p-3 rounded-lg bg-secondary-50 dark:bg-secondary-800">
                  <div className="font-semibold">Tk {row.totalAmount}</div>
                  <div className="text-sm text-secondary-500">{(row.items || []).map((item) => item.itemName).join(', ')}</div>
                </div>
              ))}
            </div>
          </div>

          <div className="card p-6">
            <h2 className="text-xl font-bold gradient-text mb-4">Utility / Salary</h2>
            <div className="grid grid-cols-1 md:grid-cols-5 gap-3 mb-3">
              <select value={utility.type} onChange={(e) => setUtility({ ...utility, type: e.target.value })} className="px-3 py-2 rounded-lg border">
                {utilityTypes.map((type) => <option key={type.value} value={type.value}>{type.label}</option>)}
              </select>
              {utility.type === 'other' && (
                <input value={utility.customType} onChange={(e) => setUtility({ ...utility, customType: e.target.value })} placeholder="Custom bill name" className="px-3 py-2 rounded-lg border" />
              )}
              <input value={utility.amount} onChange={(e) => setUtility({ ...utility, amount: e.target.value })} placeholder="Amount" className="px-3 py-2 rounded-lg border" />
              <input value={utility.notes} onChange={(e) => setUtility({ ...utility, notes: e.target.value })} placeholder="Note" className="px-3 py-2 rounded-lg border" />
              <button onClick={saveUtility} className="px-4 py-2 rounded-lg bg-violet-600 text-white font-semibold">Add</button>
            </div>
            <p className="font-semibold">This month total: Tk {utilityTotal}</p>
            <div className="mt-3 space-y-2">
              {utilities.slice(0, 5).map((row) => (
                <div key={row._id} className="flex justify-between gap-3 text-sm p-2 rounded-lg bg-secondary-50 dark:bg-secondary-800">
                  <span className="capitalize">{String(row.type || '').replaceAll('_', ' ')}</span>
                  <span className="font-semibold">Tk {row.amount}</span>
                </div>
              ))}
            </div>
          </div>
        </div>

        <div className="card p-6">
          <h2 className="text-xl font-bold gradient-text mb-4">Student Advance Payment</h2>
          <div className="grid grid-cols-1 md:grid-cols-5 gap-3">
            <input value={studentSearch} onChange={(e) => setStudentSearch(e.target.value)} placeholder="Search name / roll / room" className="px-3 py-2 rounded-lg border" />
            <select value={advance.studentId} onChange={(e) => setAdvance({ ...advance, studentId: e.target.value })} className="px-3 py-2 rounded-lg border">
              <option value="">Select student</option>
              {filteredStudents.map((student) => (
                <option key={student._id} value={student._id}>
                  {student.name} - {student.rollNumber || 'No Roll'} - Room {student.roomNumber || 'N/A'}
                </option>
              ))}
            </select>
            <input type="date" value={advance.date} onChange={(e) => setAdvance({ ...advance, date: e.target.value })} className="px-3 py-2 rounded-lg border" />
            <input value={advance.amount} onChange={(e) => setAdvance({ ...advance, amount: e.target.value })} placeholder="Amount" className="px-3 py-2 rounded-lg border" />
            <input value={advance.notes} onChange={(e) => setAdvance({ ...advance, notes: e.target.value })} placeholder="Note" className="px-3 py-2 rounded-lg border" />
            <button onClick={saveAdvance} className="px-4 py-2 rounded-lg bg-violet-600 text-white font-semibold">Save Advance</button>
          </div>
          {selectedStudent && (
            <p className="mt-3 text-sm text-secondary-600 dark:text-secondary-300">
              Selected: <span className="font-semibold">{selectedStudent.name}</span> | Roll: <span className="font-semibold">{selectedStudent.rollNumber || 'N/A'}</span> | Room: <span className="font-semibold">{selectedStudent.roomNumber || 'N/A'}</span>
            </p>
          )}
        </div>
      </div>
    </ModernLayout>
  );
};

export default Inventory;
