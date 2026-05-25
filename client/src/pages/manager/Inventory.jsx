import { useEffect, useState } from 'react';
import ModernLayout from '../../components/layout/ModernLayout';
import { inventoryService } from '../../services/inventory.service';
import { usersService } from '../../services/users.service';
import { toISODate } from '../../utils/formatDate';
import toast from 'react-hot-toast';

const emptyItem = { itemName: '', quantity: '', unit: 'kg', price: '', total: '' };

const Inventory = () => {
  const today = toISODate(new Date());
  const now = new Date();
  const [date, setDate] = useState(today);
  const [items, setItems] = useState([emptyItem]);
  const [bazars, setBazars] = useState([]);
  const [utilities, setUtilities] = useState([]);
  const [students, setStudents] = useState([]);
  const [utility, setUtility] = useState({ type: 'gas', amount: '', notes: '' });
  const [advance, setAdvance] = useState({ studentId: '', amount: '', notes: '' });

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
      usersService.getAllUsers(),
    ]);
    const defaults = defaultsRes.data.defaults || [];
    setItems(defaults.length ? defaults : [emptyItem]);
    setBazars(bazarRes.data.bazars || []);
    setUtilities(utilityRes.data.utilities || []);
    setStudents((userRes.data.users || []).filter((user) => user.role === 'student'));
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
    await inventoryService.createUtility({ month, year, ...utility, amount: Number(utility.amount) || 0 });
    toast.success('Utility expense added');
    setUtility({ type: 'gas', amount: '', notes: '' });
    load();
  };

  const saveAdvance = async () => {
    if (!advance.studentId || !advance.amount) {
      toast.error('Select student and amount');
      return;
    }
    await inventoryService.createAdvance({ date, ...advance, amount: Number(advance.amount) || 0 });
    toast.success('Advance payment saved');
    setAdvance({ studentId: '', amount: '', notes: '' });
  };

  const totalToday = bazars.reduce((sum, row) => sum + Number(row.totalAmount || 0), 0);
  const utilityTotal = utilities.reduce((sum, row) => sum + Number(row.amount || 0), 0);

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
            <div className="grid grid-cols-1 md:grid-cols-3 gap-3 mb-3">
              <select value={utility.type} onChange={(e) => setUtility({ ...utility, type: e.target.value })} className="px-3 py-2 rounded-lg border">
                <option value="gas">Gas</option>
                <option value="electricity">Electricity</option>
                <option value="water">Water</option>
                <option value="manager_salary">Manager Salary</option>
                <option value="assistant_manager_salary">Assistant Manager Salary</option>
              </select>
              <input value={utility.amount} onChange={(e) => setUtility({ ...utility, amount: e.target.value })} placeholder="Amount" className="px-3 py-2 rounded-lg border" />
              <button onClick={saveUtility} className="px-4 py-2 rounded-lg bg-violet-600 text-white font-semibold">Add</button>
            </div>
            <p className="font-semibold">This month total: Tk {utilityTotal}</p>
          </div>
        </div>

        <div className="card p-6">
          <h2 className="text-xl font-bold gradient-text mb-4">Student Advance Payment</h2>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-3">
            <select value={advance.studentId} onChange={(e) => setAdvance({ ...advance, studentId: e.target.value })} className="px-3 py-2 rounded-lg border">
              <option value="">Select student</option>
              {students.map((student) => <option key={student._id} value={student._id}>{student.name}</option>)}
            </select>
            <input value={advance.amount} onChange={(e) => setAdvance({ ...advance, amount: e.target.value })} placeholder="Amount" className="px-3 py-2 rounded-lg border" />
            <input value={advance.notes} onChange={(e) => setAdvance({ ...advance, notes: e.target.value })} placeholder="Note" className="px-3 py-2 rounded-lg border" />
            <button onClick={saveAdvance} className="px-4 py-2 rounded-lg bg-violet-600 text-white font-semibold">Save Advance</button>
          </div>
        </div>
      </div>
    </ModernLayout>
  );
};

export default Inventory;
