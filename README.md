# Hostel Management System

Hostel Management System is a full-stack hostel mess management project. The frontend is built with React and Vite, and the backend is an ASP.NET Core Web API project on .NET 8 using MVC controllers, Entity Framework Core, and PostgreSQL.

The system supports student, manager, and admin workflows for meal selection, weekly menu management, holiday mode, daily bazar, utility expenses, advance payments, monthly billing, complaints, notices, feedback, chat, analytics, and audit logs.

## Technology Stack

| Area | Technology |
| --- | --- |
| Frontend | React 18, Vite, JavaScript, Tailwind CSS, Material UI, React Router, Axios |
| Backend | ASP.NET Core Web API, .NET 8, MVC controllers, C# |
| ORM | Entity Framework Core |
| Database | PostgreSQL |
| DbContext | `AppDbContext` |
| Authentication | JWT Bearer authentication, BCrypt password hashing |
| API Docs | Swagger/OpenAPI at `/api-docs` |
| Tools | VS Code, Visual Studio 2022, dotnet CLI, npm, Git |

## Main Features

- Role-based authentication for student, manager, and admin.
- Protected dashboards and routes.
- Weekly repeating meal schedule for 7 days.
- Breakfast, lunch, and dinner support.
- Default and alternative meal options.
- Student meal selection calendar.
- Previous-day meal change/cancel workflow.
- Default meals are auto-approved.
- Alternative and cancelled meals stay pending until approval.
- Manager/admin pending meal approval and approve-all flow.
- Daily cooking count for kitchen planning.
- Student holiday mode with future date ranges.
- Daily bazar entries with item list, quantity, price, date, and notes.
- Multiple bazar entries per day.
- Utility expenses including gas, electricity, water, salary, and custom expenses.
- Student advance payment records with date-wise history.
- Monthly billing using one meal rate:

```text
Meal Rate = Total Monthly Bazar Cost / Total Billable Meals
Monthly Bill = Meal Rate * Student Meal Count + Utility Share + Previous Due - Advance Paid
```

- Complaints, notices, feedback, chat, analytics, settings, and audit logs.
- PostgreSQL SQL dump included at `database/hostel_management.sql`.

## Role-wise Work

### Student

- Login to student dashboard.
- View menu and selected meal.
- Select default meal, request alternative meal, or cancel meal for allowed future dates.
- Use holiday mode for future date ranges.
- View monthly bill, old due, advance paid, and payment status.
- View date-wise advance payment history.
- Submit complaints and view complaint history.
- Give meal feedback.
- Read notices.
- Use chat.
- View profile information.

### Manager

- Login to manager dashboard.
- Manage weekly repeating meal schedule.
- Set default and alternative meals.
- View and approve pending meal requests.
- Approve all pending meal requests together.
- View daily cooking count.
- Add daily bazar entries.
- Add utility expenses.
- Record student advance payments.
- Search students by name or roll for advance payment.
- View feedback summary and reports.
- Use chat.

### Admin

- Login to admin dashboard.
- Manage users and student count.
- Create, update, delete, activate/deactivate, and export users.
- Manage notices.
- Manage complaints and statuses.
- Generate, regenerate, reset, and update monthly bills.
- View billing statistics.
- View analytics.
- Manage settings and holidays.
- View audit logs and audit trails.
- Use chat.

## Database Tables

The active application tables are:

- `Users`
- `Menus`
- `MealPlans`
- `MealSelections`
- `WeeklyMealSchedules`
- `StudentHolidayModes`
- `Complaints`
- `Notices`
- `Feedback`
- `Settings`
- `Holidays`
- `Inventory`
- `DailyBazars`
- `UtilityExpenses`
- `AdvancePayments`
- `Bills`
- `Messages`
- `AuditLogs`

Entity Framework also uses `__EFMigrationsHistory`.

## API Modules

| Route | Module |
| --- | --- |
| `/api/v1/auth` | Register, login, current user |
| `/api/v1/users` | Admin user management |
| `/api/v1/meals` | Meal selection, holiday mode, weekly schedule, approvals, cooking counts |
| `/api/v1/menus` | Menu CRUD and today's menu |
| `/api/v1/meal-plans` | Student meal plans |
| `/api/v1/billing` | Student bills, bill generation, bill stats |
| `/api/v1/inventory` | Daily bazar, utilities, advance payments, inventory endpoints |
| `/api/v1/complaints` | Complaint submission and management |
| `/api/v1/notices` | Notice CRUD |
| `/api/v1/feedback` | Student feedback and summary |
| `/api/v1/messages` | Chat messages |
| `/api/v1/analytics` | Overview, meal, billing, feedback, complaint analytics |
| `/api/v1/settings` | System settings and holidays |
| `/api/v1/audit` | Audit logs |
| `/api/v1/payments` | Payment placeholder endpoints |
| `/health` | Health check |

## Default Login

| Role | Email | Password |
| --- | --- | --- |
| Admin | `admin@hostel.com` | `Admin@123` |
| Manager | `manager@hostel.com` | `Manager@123` |
| Student | `rahim@student.com` | `Student@123` |

## Linux + VS Code Setup

Install prerequisites:

```bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib nodejs npm
dotnet --version
```

Create PostgreSQL database:

```bash
sudo -u postgres psql
ALTER USER postgres WITH PASSWORD 'root';
CREATE DATABASE hostel_management;
\q
```

Run backend:

```bash
dotnet restore server-dotnet/HostelManagement.Api.csproj
dotnet ef database update --project server-dotnet/HostelManagement.Api.csproj
dotnet run --project server-dotnet/HostelManagement.Api.csproj --urls http://localhost:5000
```

Run frontend from the `client` folder:

```bash
cd client
npm install
npm run dev -- --host 0.0.0.0
```

Open:

- Frontend: `http://localhost:5173`
- Backend: `http://localhost:5000`
- Swagger: `http://localhost:5000/api-docs`

## Windows + Visual Studio Setup

Install:

- Visual Studio 2022 with ASP.NET and web development workload.
- .NET 8 SDK.
- PostgreSQL.
- Node.js LTS.

Database:

1. Open pgAdmin or SQL Shell.
2. Create database `hostel_management`.
3. Set postgres password to `root`, or update `server-dotnet/appsettings.json`.

Backend:

1. Open `HostelManagement.sln` in Visual Studio.
2. Set `HostelManagement.Api` as the startup project.
3. Open Package Manager Console and run:

```powershell
Update-Database
```

4. Start the API. It should run on `http://localhost:5000`.

Frontend:

```powershell
cd client
npm install
npm run dev
```

## Import SQL Dump

If you want to restore the included SQL dump instead of running migrations:

```bash
createdb -h localhost -U postgres hostel_management
psql -h localhost -U postgres -d hostel_management -f database/hostel_management.sql
```

On Windows, run the same commands from the PostgreSQL `bin` folder or add PostgreSQL to `PATH`.

## Useful Commands

```bash
dotnet build server-dotnet/HostelManagement.Api.csproj
dotnet ef migrations add MigrationName --project server-dotnet/HostelManagement.Api.csproj
dotnet ef database update --project server-dotnet/HostelManagement.Api.csproj
npm run build --prefix client
```

## Project Structure

```text
client/         React frontend
server-dotnet/  ASP.NET Core MVC Web API backend
database/       PostgreSQL SQL dump
```

## Git Notes

Generated folders are ignored and should not be committed:

```text
bin/
obj/
node_modules/
dist/
```

If `bin/` or `obj/` is deleted, the project will still build. .NET recreates them automatically during restore/build/run.
