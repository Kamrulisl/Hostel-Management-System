# Hostel Management System

React frontend with an ASP.NET Core MVC Web API backend on .NET 8, Entity Framework Core, and PostgreSQL.

## Stack

- Frontend: React 18, Vite, Tailwind CSS, Material UI
- Backend: ASP.NET Core Web API, MVC controllers, .NET 8
- ORM: Entity Framework Core
- Database: PostgreSQL
- DbContext: `AppDbContext`
- Auth: JWT + BCrypt password hashing

## Main Features

- Student, manager, and admin authentication
- User, menu, meal, attendance, billing, complaint, notice, feedback, inventory, audit, and message APIs
- Weekly repeating meal schedule
- Default meal auto approval
- Student alternative meal and meal cancel requests
- Pending meal approval and approve-all flow for manager/admin
- Daily cooking counts for default, alternative, and cancelled meals
- Student holiday mode
- PostgreSQL SQL dump in `database/hostel_management.sql`

## Default Login

- Admin: `admin@hostel.com` / `Admin@123`
- Manager: `manager@hostel.com` / `Manager@123`
- Student: `rahim@student.com` / `Student@123`

## Linux + VS Code Setup

Install prerequisites:

```bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib nodejs npm
dotnet --version
```

Create database:

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

Run frontend:

```bash
cd client
npm install
npm run dev
```

Open:

- Frontend: `http://localhost:5173`
- Backend: `http://localhost:5000`
- Swagger: `http://localhost:5000/api-docs`

## Windows + Visual Studio Setup

Install:

- Visual Studio 2022 with ASP.NET and web development workload
- .NET 8 SDK
- PostgreSQL
- Node.js LTS

Database:

1. Open pgAdmin or SQL Shell.
2. Create database `hostel_management`.
3. Set postgres password to `root`, or update `server-dotnet/appsettings.json`.

Backend:

1. Open `HostelManagement.sln` in Visual Studio.
2. Set `HostelManagement.Api` as startup project.
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

On Windows, run the same commands from PostgreSQL `bin` folder or add it to PATH.

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
server-dotnet/  ASP.NET Core MVC Web API
database/       PostgreSQL SQL dump
```
