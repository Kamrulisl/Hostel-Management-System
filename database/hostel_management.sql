--
-- PostgreSQL database dump
--

\restrict DCkzJoHvBflyZUrKhj3H5kYuB2ndZGQqTZsR0f3ZC4gW9enE3aYWnBwvRuJW7iP

-- Dumped from database version 18.4 (Ubuntu 18.4-1.pgdg24.04+1)
-- Dumped by pg_dump version 18.4 (Ubuntu 18.4-1.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public."StudentHolidayModes" DROP CONSTRAINT IF EXISTS "FK_StudentHolidayModes_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."Notices" DROP CONSTRAINT IF EXISTS "FK_Notices_Users_CreatedById";
ALTER TABLE IF EXISTS ONLY public."Messages" DROP CONSTRAINT IF EXISTS "FK_Messages_Users_SenderId";
ALTER TABLE IF EXISTS ONLY public."Messages" DROP CONSTRAINT IF EXISTS "FK_Messages_Users_ReceiverId";
ALTER TABLE IF EXISTS ONLY public."Menus" DROP CONSTRAINT IF EXISTS "FK_Menus_Users_CreatedById";
ALTER TABLE IF EXISTS ONLY public."MealSelections" DROP CONSTRAINT IF EXISTS "FK_MealSelections_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."MealPlans" DROP CONSTRAINT IF EXISTS "FK_MealPlans_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."Holidays" DROP CONSTRAINT IF EXISTS "FK_Holidays_Settings_SettingsId";
ALTER TABLE IF EXISTS ONLY public."Feedback" DROP CONSTRAINT IF EXISTS "FK_Feedback_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."Complaints" DROP CONSTRAINT IF EXISTS "FK_Complaints_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."Complaints" DROP CONSTRAINT IF EXISTS "FK_Complaints_Users_ResolvedById";
ALTER TABLE IF EXISTS ONLY public."Bills" DROP CONSTRAINT IF EXISTS "FK_Bills_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."Attendance" DROP CONSTRAINT IF EXISTS "FK_Attendance_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."Attendance" DROP CONSTRAINT IF EXISTS "FK_Attendance_Users_MarkedById";
DROP INDEX IF EXISTS public."IX_WeeklyMealSchedules_DayOfWeek_MealType";
DROP INDEX IF EXISTS public."IX_Users_RollNumber";
DROP INDEX IF EXISTS public."IX_Users_Email";
DROP INDEX IF EXISTS public."IX_StudentHolidayModes_StudentId";
DROP INDEX IF EXISTS public."IX_Notices_CreatedById";
DROP INDEX IF EXISTS public."IX_Messages_SenderId";
DROP INDEX IF EXISTS public."IX_Messages_ReceiverId";
DROP INDEX IF EXISTS public."IX_Menus_Date_MealType";
DROP INDEX IF EXISTS public."IX_Menus_CreatedById";
DROP INDEX IF EXISTS public."IX_MealSelections_StudentId_Date";
DROP INDEX IF EXISTS public."IX_MealPlans_StudentId_Date";
DROP INDEX IF EXISTS public."IX_Holidays_SettingsId";
DROP INDEX IF EXISTS public."IX_Feedback_StudentId_Date_MealType";
DROP INDEX IF EXISTS public."IX_Complaints_StudentId";
DROP INDEX IF EXISTS public."IX_Complaints_ResolvedById";
DROP INDEX IF EXISTS public."IX_Bills_StudentId_Month_Year";
DROP INDEX IF EXISTS public."IX_Attendance_StudentId_Date_MealType";
DROP INDEX IF EXISTS public."IX_Attendance_MarkedById";
ALTER TABLE IF EXISTS ONLY public."__EFMigrationsHistory" DROP CONSTRAINT IF EXISTS "PK___EFMigrationsHistory";
ALTER TABLE IF EXISTS ONLY public."WeeklyMealSchedules" DROP CONSTRAINT IF EXISTS "PK_WeeklyMealSchedules";
ALTER TABLE IF EXISTS ONLY public."Users" DROP CONSTRAINT IF EXISTS "PK_Users";
ALTER TABLE IF EXISTS ONLY public."StudentHolidayModes" DROP CONSTRAINT IF EXISTS "PK_StudentHolidayModes";
ALTER TABLE IF EXISTS ONLY public."Settings" DROP CONSTRAINT IF EXISTS "PK_Settings";
ALTER TABLE IF EXISTS ONLY public."Notices" DROP CONSTRAINT IF EXISTS "PK_Notices";
ALTER TABLE IF EXISTS ONLY public."Messages" DROP CONSTRAINT IF EXISTS "PK_Messages";
ALTER TABLE IF EXISTS ONLY public."Menus" DROP CONSTRAINT IF EXISTS "PK_Menus";
ALTER TABLE IF EXISTS ONLY public."MealSelections" DROP CONSTRAINT IF EXISTS "PK_MealSelections";
ALTER TABLE IF EXISTS ONLY public."MealPlans" DROP CONSTRAINT IF EXISTS "PK_MealPlans";
ALTER TABLE IF EXISTS ONLY public."Inventory" DROP CONSTRAINT IF EXISTS "PK_Inventory";
ALTER TABLE IF EXISTS ONLY public."Holidays" DROP CONSTRAINT IF EXISTS "PK_Holidays";
ALTER TABLE IF EXISTS ONLY public."Feedback" DROP CONSTRAINT IF EXISTS "PK_Feedback";
ALTER TABLE IF EXISTS ONLY public."Complaints" DROP CONSTRAINT IF EXISTS "PK_Complaints";
ALTER TABLE IF EXISTS ONLY public."Bills" DROP CONSTRAINT IF EXISTS "PK_Bills";
ALTER TABLE IF EXISTS ONLY public."AuditLogs" DROP CONSTRAINT IF EXISTS "PK_AuditLogs";
ALTER TABLE IF EXISTS ONLY public."Attendance" DROP CONSTRAINT IF EXISTS "PK_Attendance";
DROP TABLE IF EXISTS public."__EFMigrationsHistory";
DROP TABLE IF EXISTS public."WeeklyMealSchedules";
DROP TABLE IF EXISTS public."Users";
DROP TABLE IF EXISTS public."StudentHolidayModes";
DROP TABLE IF EXISTS public."Settings";
DROP TABLE IF EXISTS public."Notices";
DROP TABLE IF EXISTS public."Messages";
DROP TABLE IF EXISTS public."Menus";
DROP TABLE IF EXISTS public."MealSelections";
DROP TABLE IF EXISTS public."MealPlans";
DROP TABLE IF EXISTS public."Inventory";
DROP TABLE IF EXISTS public."Holidays";
DROP TABLE IF EXISTS public."Feedback";
DROP TABLE IF EXISTS public."Complaints";
DROP TABLE IF EXISTS public."Bills";
DROP TABLE IF EXISTS public."AuditLogs";
DROP TABLE IF EXISTS public."Attendance";
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Attendance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Attendance" (
    "Id" text NOT NULL,
    "StudentId" text NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "MealType" text NOT NULL,
    "Present" boolean NOT NULL,
    "Approved" boolean NOT NULL,
    "ApprovedById" text,
    "ApprovedAt" timestamp without time zone,
    "MarkedById" text NOT NULL,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: AuditLogs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditLogs" (
    "Id" text NOT NULL,
    "ActorId" text,
    "ActorRole" text,
    "Action" text NOT NULL,
    "EntityType" text NOT NULL,
    "EntityId" text,
    "Description" text,
    "MetadataJson" text NOT NULL,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: Bills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Bills" (
    "Id" text NOT NULL,
    "StudentId" text NOT NULL,
    "Month" integer NOT NULL,
    "Year" integer NOT NULL,
    "TotalMeals" integer NOT NULL,
    "MealCost" numeric NOT NULL,
    "FixedCost" numeric NOT NULL,
    "TotalAmount" numeric NOT NULL,
    "Status" text NOT NULL,
    "PaidAt" timestamp without time zone,
    "PaymentMethod" text,
    "TransactionId" text,
    "BreakfastCount" integer NOT NULL,
    "BreakfastRate" numeric NOT NULL,
    "LunchCount" integer NOT NULL,
    "LunchRate" numeric NOT NULL,
    "DinnerCount" integer NOT NULL,
    "DinnerRate" numeric NOT NULL,
    "GeneratedById" text,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: Complaints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Complaints" (
    "Id" text NOT NULL,
    "StudentId" text NOT NULL,
    "Category" text NOT NULL,
    "Title" text NOT NULL,
    "Description" text NOT NULL,
    "Status" text NOT NULL,
    "Priority" text NOT NULL,
    "ResolvedById" text,
    "ResolvedAt" timestamp without time zone,
    "AdminNotes" text,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: Feedback; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Feedback" (
    "Id" text NOT NULL,
    "StudentId" text NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "MealType" text NOT NULL,
    "Rating" integer NOT NULL,
    "Comment" text,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: Holidays; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Holidays" (
    "Id" text NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "Reason" text NOT NULL,
    "SettingsId" text NOT NULL
);


--
-- Name: Inventory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Inventory" (
    "Id" text NOT NULL,
    "ItemName" text NOT NULL,
    "Category" text NOT NULL,
    "Quantity" numeric NOT NULL,
    "Unit" text NOT NULL,
    "MinThreshold" numeric NOT NULL,
    "Price" numeric NOT NULL,
    "Supplier" text,
    "LastRestocked" timestamp without time zone NOT NULL,
    "ExpiryDate" timestamp without time zone,
    "Status" text NOT NULL,
    "Notes" text,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: MealPlans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MealPlans" (
    "Id" text NOT NULL,
    "StudentId" text NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "Breakfast" boolean NOT NULL,
    "Lunch" boolean NOT NULL,
    "Dinner" boolean NOT NULL,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: MealSelections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MealSelections" (
    "Id" text NOT NULL,
    "StudentId" text NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "Breakfast" boolean NOT NULL,
    "Lunch" boolean NOT NULL,
    "Dinner" boolean NOT NULL,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL,
    "ApprovedAt" timestamp without time zone,
    "ApprovedById" text,
    "BreakfastChoice" text DEFAULT ''::text NOT NULL,
    "BreakfastItemsJson" text DEFAULT ''::text NOT NULL,
    "BreakfastStatus" text DEFAULT ''::text NOT NULL,
    "DinnerChoice" text DEFAULT ''::text NOT NULL,
    "DinnerItemsJson" text DEFAULT ''::text NOT NULL,
    "DinnerStatus" text DEFAULT ''::text NOT NULL,
    "LunchChoice" text DEFAULT ''::text NOT NULL,
    "LunchItemsJson" text DEFAULT ''::text NOT NULL,
    "LunchStatus" text DEFAULT ''::text NOT NULL,
    "Note" text
);


--
-- Name: Menus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Menus" (
    "Id" text NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "MealType" text NOT NULL,
    "ItemsJson" text NOT NULL,
    "ImageUrl" text NOT NULL,
    "CreatedById" text NOT NULL,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: Messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Messages" (
    "Id" text NOT NULL,
    "SenderId" text NOT NULL,
    "ReceiverId" text NOT NULL,
    "Text" text NOT NULL,
    "Read" boolean NOT NULL,
    "ReadAt" timestamp without time zone,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: Notices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Notices" (
    "Id" text NOT NULL,
    "Title" text NOT NULL,
    "Content" text NOT NULL,
    "Category" text NOT NULL,
    "IsPinned" boolean NOT NULL,
    "TargetAudience" text NOT NULL,
    "CreatedById" text NOT NULL,
    "ExpiresAt" timestamp without time zone,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: Settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Settings" (
    "Id" text NOT NULL,
    "BreakfastPrice" numeric NOT NULL,
    "LunchPrice" numeric NOT NULL,
    "DinnerPrice" numeric NOT NULL,
    "CutoffTime" text NOT NULL,
    "CutoffDaysBefore" integer NOT NULL,
    "ExtraCharges" numeric NOT NULL,
    "DiscountPercentage" numeric NOT NULL,
    "TaxPercentage" numeric NOT NULL,
    "MessName" text NOT NULL,
    "MessAddress" text NOT NULL,
    "ContactEmail" text NOT NULL,
    "ContactPhone" text NOT NULL,
    "EnableEmailNotifications" boolean NOT NULL,
    "EnableSmsNotifications" boolean NOT NULL,
    "UpdatedById" text,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: StudentHolidayModes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."StudentHolidayModes" (
    "Id" text NOT NULL,
    "StudentId" text NOT NULL,
    "IsEnabled" boolean NOT NULL,
    "StartDate" timestamp without time zone,
    "EndDate" timestamp without time zone,
    "Reason" text,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: Users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Users" (
    "Id" text NOT NULL,
    "Name" text NOT NULL,
    "Email" text NOT NULL,
    "PasswordHash" text NOT NULL,
    "Role" text NOT NULL,
    "RollNumber" text,
    "RoomNumber" text,
    "Phone" text,
    "IsActive" boolean NOT NULL,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: WeeklyMealSchedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."WeeklyMealSchedules" (
    "Id" text NOT NULL,
    "DayOfWeek" integer NOT NULL,
    "MealType" text NOT NULL,
    "DefaultItemsJson" text NOT NULL,
    "AlternativeItemsJson" text NOT NULL,
    "IsActive" boolean NOT NULL,
    "UpdatedById" text,
    "CreatedAt" timestamp without time zone NOT NULL,
    "UpdatedAt" timestamp without time zone NOT NULL
);


--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


--
-- Data for Name: Attendance; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Attendance" ("Id", "StudentId", "Date", "MealType", "Present", "Approved", "ApprovedById", "ApprovedAt", "MarkedById", "CreatedAt", "UpdatedAt") FROM stdin;
att000000000000000000001	3acdfa641bdfe968502b3d15	2026-05-25 00:00:00	lunch	t	t	2a8fbe44e221552bf3ea6454	2026-05-25 15:28:18.757808	2a8fbe44e221552bf3ea6454	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
1640c36083c0257131f3afed	bc413512843c5139b681c31f	2026-05-25 00:00:00	lunch	t	f	\N	\N	bc413512843c5139b681c31f	2026-05-25 09:31:51.878875	2026-05-25 09:31:51.878875
att000000000000000000002	be0ba0ba02ad271dbb3c612b	2026-05-25 00:00:00	lunch	t	t	2a8fbe44e221552bf3ea6454	2026-05-25 10:07:01.942405	be0ba0ba02ad271dbb3c612b	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
b12ad8f123cfc7c1db45c19f	bc413512843c5139b681c31f	2026-05-25 00:00:00	dinner	t	t	2a8fbe44e221552bf3ea6454	2026-05-25 10:07:04.565508	bc413512843c5139b681c31f	2026-05-25 09:31:54.577657	2026-05-25 09:31:54.577657
aab769ad39eb517a4e4adfcf	bc413512843c5139b681c31f	2026-05-25 00:00:00	breakfast	t	t	2a8fbe44e221552bf3ea6454	2026-05-25 10:07:05.648673	bc413512843c5139b681c31f	2026-05-25 09:31:48.734719	2026-05-25 09:31:48.734719
\.


--
-- Data for Name: AuditLogs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AuditLogs" ("Id", "ActorId", "ActorRole", "Action", "EntityType", "EntityId", "Description", "MetadataJson", "CreatedAt", "UpdatedAt") FROM stdin;
5e5f375dfdbd93129a39223b	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 09:51:08.265478	2026-05-25 09:51:08.265537
e2e5c6a295c074a7e4a6f5d5	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 09:51:08.917897	2026-05-25 09:51:08.917897
a6c70303167a786d3906a3ec	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 10:04:17.849015	2026-05-25 10:04:17.849015
23e54cda573e0a6cf63f409e	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 10:06:20.148785	2026-05-25 10:06:20.148786
59f42650afb939663b5b89a1	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 10:34:38.560044	2026-05-25 10:34:38.560137
f9dbfa248eb768430bf41a83	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 10:34:39.980959	2026-05-25 10:34:39.98096
c15435818f9303471ffc4ea7	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 10:34:48.860389	2026-05-25 10:34:48.860389
2e431e49f3c2fbd598390702	474a93b899cc03d94a78543f	admin	APPROVE_ALL	MealSelection	\N	Approved 1 meal requests	{}	2026-05-25 10:34:48.930458	2026-05-25 10:34:48.930458
40b158ba30371d0cf1c72a80	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 10:54:48.692627	2026-05-25 10:54:48.692662
7b702ad2b47fbed387b7ef82	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 10:54:48.699934	2026-05-25 10:54:48.699934
37f85d4acb5136e7f858d368	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 10:54:48.692624	2026-05-25 10:54:48.692659
b67f9844804e2b187d2f522e	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 10:56:44.09682	2026-05-25 10:56:44.09682
d716f4ca6b44de1033a3637b	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 10:58:29.340603	2026-05-25 10:58:29.340603
46e3b58b90ff053906f03cb7	bc413512843c5139b681c31f	student	LOGIN	User	bc413512843c5139b681c31f	User logged in	{}	2026-05-25 10:59:20.470115	2026-05-25 10:59:20.470115
b1cdb8b657073af41ef73010	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 11:22:14.669507	2026-05-25 11:22:14.669588
2f692de6057abbedeaf07037	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 11:22:15.714239	2026-05-25 11:22:15.714239
7852e282e6aaaa19b6b29677	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 11:24:15.251053	2026-05-25 11:24:15.251132
e0c70dc8920255e73189e1f5	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 11:24:16.479718	2026-05-25 11:24:16.479718
\.


--
-- Data for Name: Bills; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Bills" ("Id", "StudentId", "Month", "Year", "TotalMeals", "MealCost", "FixedCost", "TotalAmount", "Status", "PaidAt", "PaymentMethod", "TransactionId", "BreakfastCount", "BreakfastRate", "LunchCount", "LunchRate", "DinnerCount", "DinnerRate", "GeneratedById", "CreatedAt", "UpdatedAt") FROM stdin;
bill0000000000000000001	3acdfa641bdfe968502b3d15	5	2026	3	150	2000	2150	DUE	\N	\N	\N	1	35	1	60	1	55	474a93b899cc03d94a78543f	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
bill0000000000000000002	be0ba0ba02ad271dbb3c612b	5	2026	2	115	2000	2115	PAID	2026-05-25 15:28:18.757808	cash	CASH-001	0	35	1	60	1	55	474a93b899cc03d94a78543f	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: Complaints; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Complaints" ("Id", "StudentId", "Category", "Title", "Description", "Status", "Priority", "ResolvedById", "ResolvedAt", "AdminNotes", "CreatedAt", "UpdatedAt") FROM stdin;
comp00000000000000000001	3acdfa641bdfe968502b3d15	food	Lunch was too spicy	Please reduce chili in chicken curry.	pending	medium	\N	\N	\N	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
comp00000000000000000002	be0ba0ba02ad271dbb3c612b	maintenance	Water filter issue	Dining water filter needs cleaning.	in-progress	high	474a93b899cc03d94a78543f	\N	Assigned to maintenance team	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: Feedback; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Feedback" ("Id", "StudentId", "Date", "MealType", "Rating", "Comment", "CreatedAt", "UpdatedAt") FROM stdin;
feed0000000000000000001	3acdfa641bdfe968502b3d15	2026-05-25 00:00:00	lunch	4	Good meal overall.	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
feed0000000000000000002	be0ba0ba02ad271dbb3c612b	2026-05-25 00:00:00	dinner	5	Khichuri was excellent.	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: Holidays; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Holidays" ("Id", "Date", "Reason", "SettingsId") FROM stdin;
\.


--
-- Data for Name: Inventory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Inventory" ("Id", "ItemName", "Category", "Quantity", "Unit", "MinThreshold", "Price", "Supplier", "LastRestocked", "ExpiryDate", "Status", "Notes", "CreatedAt", "UpdatedAt") FROM stdin;
inv000000000000000000001	Rice	grains	120	kg	30	75	Local Bazaar	2026-05-25 15:28:18.757808	\N	in-stock	Miniket rice	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
inv000000000000000000002	Lentil	grains	25	kg	20	140	Wholesale Store	2026-05-25 15:28:18.757808	\N	low-stock	Masoor dal	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
inv000000000000000000003	Milk	dairy	0	l	10	90	Dairy Farm	2026-05-25 15:28:18.757808	2026-05-30 15:28:18.757808	out-of-stock	Restock needed	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
inv000000000000000000004	Potato	vegetables	60	kg	15	35	Vegetable Market	2026-05-25 15:28:18.757808	\N	in-stock		2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: MealPlans; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."MealPlans" ("Id", "StudentId", "Date", "Breakfast", "Lunch", "Dinner", "CreatedAt", "UpdatedAt") FROM stdin;
plan00000000000000000001	3acdfa641bdfe968502b3d15	2026-05-26 00:00:00	t	t	f	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: MealSelections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."MealSelections" ("Id", "StudentId", "Date", "Breakfast", "Lunch", "Dinner", "CreatedAt", "UpdatedAt", "ApprovedAt", "ApprovedById", "BreakfastChoice", "BreakfastItemsJson", "BreakfastStatus", "DinnerChoice", "DinnerItemsJson", "DinnerStatus", "LunchChoice", "LunchItemsJson", "LunchStatus", "Note") FROM stdin;
sel000000000000000000001	3acdfa641bdfe968502b3d15	2026-05-25 00:00:00	t	t	t	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
sel000000000000000000002	be0ba0ba02ad271dbb3c612b	2026-05-25 00:00:00	f	t	t	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
91f6d8d5ab7027deb04b1916	3acdfa641bdfe968502b3d15	2026-05-26 00:00:00	t	t	t	2026-05-25 10:34:40.472443	2026-05-25 11:24:16.97512	2026-05-25 10:34:48.917668	474a93b899cc03d94a78543f	default	[]	approved	default	[]	approved	alternative	[{"name": "Tuesday Alternative Lunch", "description": "Weekly alternative option"}]	pending	\N
\.


--
-- Data for Name: Menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Menus" ("Id", "Date", "MealType", "ItemsJson", "ImageUrl", "CreatedById", "CreatedAt", "UpdatedAt") FROM stdin;
menu00000000000000000001	2026-05-25 00:00:00	breakfast	[{"name":"Paratha","description":"Fresh paratha"},{"name":"Egg Curry","description":"Boiled egg curry"}]		2a8fbe44e221552bf3ea6454	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
menu00000000000000000002	2026-05-25 00:00:00	lunch	[{"name":"Rice","description":"Steamed rice"},{"name":"Chicken Curry","description":"Spicy chicken curry"},{"name":"Dal","description":"Lentil soup"}]		2a8fbe44e221552bf3ea6454	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
menu00000000000000000003	2026-05-25 00:00:00	dinner	[{"name":"Khichuri","description":"Mixed rice and lentil"},{"name":"Beef Curry","description":"Rich beef curry"}]		2a8fbe44e221552bf3ea6454	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: Messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Messages" ("Id", "SenderId", "ReceiverId", "Text", "Read", "ReadAt", "CreatedAt", "UpdatedAt") FROM stdin;
\.


--
-- Data for Name: Notices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Notices" ("Id", "Title", "Content", "Category", "IsPinned", "TargetAudience", "CreatedById", "ExpiresAt", "CreatedAt", "UpdatedAt") FROM stdin;
notice000000000000000001	Monthly Bill Published	May mess bills have been generated. Please pay before due date.	general	t	students	474a93b899cc03d94a78543f	2026-06-14 15:28:18.757808	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
notice000000000000000002	Kitchen Maintenance	Dinner may be delayed by 15 minutes tomorrow due to maintenance.	maintenance	f	all	474a93b899cc03d94a78543f	2026-06-01 15:28:18.757808	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: Settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Settings" ("Id", "BreakfastPrice", "LunchPrice", "DinnerPrice", "CutoffTime", "CutoffDaysBefore", "ExtraCharges", "DiscountPercentage", "TaxPercentage", "MessName", "MessAddress", "ContactEmail", "ContactPhone", "EnableEmailNotifications", "EnableSmsNotifications", "UpdatedById", "CreatedAt", "UpdatedAt") FROM stdin;
settings0000000000000001	35	60	55	20:00	1	100	0	0	Smart Hostel Mess	Dhaka Hostel Campus	mess@hostel.com	01700000000	f	f	474a93b899cc03d94a78543f	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: StudentHolidayModes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."StudentHolidayModes" ("Id", "StudentId", "IsEnabled", "StartDate", "EndDate", "Reason", "CreatedAt", "UpdatedAt") FROM stdin;
24260bc52bdebbfce5610858	bc413512843c5139b681c31f	f	\N	\N	\N	2026-05-25 11:06:55.823014	2026-05-25 11:07:28.431846
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Users" ("Id", "Name", "Email", "PasswordHash", "Role", "RollNumber", "RoomNumber", "Phone", "IsActive", "CreatedAt", "UpdatedAt") FROM stdin;
474a93b899cc03d94a78543f	Admin	admin@hostel.com	$2a$12$dWHWQIkBDC6nLzre.2sAqe6BprrIX4GZi4tclffs8A3SH0wpMir9W	admin	\N	\N	\N	t	2026-05-25 09:26:17.13412	2026-05-25 09:26:17.13412
2a8fbe44e221552bf3ea6454	Mess Manager	manager@hostel.com	$2a$12$wlnxiuYdEuh/6RBKiaDmaux9vaOXSlnWwXEtD/d.WrghwAflu3emy	manager	\N	\N	01700000001	t	2026-05-25 09:27:38.428021	2026-05-25 09:27:38.428021
3acdfa641bdfe968502b3d15	Rahim Uddin	rahim@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	CSE-001	A-101	01800000001	t	2026-05-25 09:27:38.555291	2026-05-25 09:27:38.555291
be0ba0ba02ad271dbb3c612b	Karim Ahmed	karim@student.com	$2a$12$yipSQZtmSxGT91R9DZBpO.s5ea8rLxNmH7s0w411HvVd81RdBMVra	student	CSE-002	A-102	01800000002	t	2026-05-25 09:27:38.562282	2026-05-25 09:27:38.562282
bc413512843c5139b681c31f	Nusrat Jahan	nusrat@student.com	$2a$12$41ly6yr2hhgJAzVHPymv2.NoJ1qSJZUoPGiECIhbfbsqgvxh0pCbi	student	CSE-003	A-103	01800000003	t	2026-05-25 09:29:41.45034	2026-05-25 09:29:41.45034
9ede9c682fb2b744b91f42d3	Mim Akter	mim@student.com	$2a$12$n/dHnRj1yNlzoKrYXH3HZOdpcLd2QXIfuTQrNMHSf5OPCps3unuYi	student	CSE-005	B-202	01800000005	t	2026-05-25 09:29:41.548447	2026-05-25 09:29:41.548447
2d738cbbc34c343517d78f91	Sabbir Hossain	sabbir@student.com	$2a$12$LBRlAH06VhNoCykA7fSpyeFi/Rz3ViAVwcLeO5D626gV2nAmc9q.2	student	CSE-004	B-201	01800000004	t	2026-05-25 09:29:41.536485	2026-05-25 09:29:41.536485
7161b632029b8295fcd67d08	Super Admin	superadmin@hostel.com	$2a$12$2dosTU8SGsBHZeSOK3JYwu2GvIRwft70yCvhL1.KB7kIH5MJm6hg.	admin	\N	\N	01700000003	t	2026-05-25 09:29:50.421105	2026-05-25 09:29:50.421105
8b68ca29b7aecbf52f2ef6f6	Assistant Manager	assistant.manager@hostel.com	$2a$12$Qrl9.3W8E6nelfna4YdEau5Sw9HgO8eRs6AmdQCzKiQ6FMZ6D7J3e	manager	\N	\N	01700000002	t	2026-05-25 09:29:50.429339	2026-05-25 09:29:50.429339
\.


--
-- Data for Name: WeeklyMealSchedules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."WeeklyMealSchedules" ("Id", "DayOfWeek", "MealType", "DefaultItemsJson", "AlternativeItemsJson", "IsActive", "UpdatedById", "CreatedAt", "UpdatedAt") FROM stdin;
10bd6ac7349e4c18450815bf	3	breakfast	[{"name":"Bread","description":""},{"name":"Jam","description":""},{"name":"Banana","description":""},{"name":"Tea","description":""}]	[{"name": "Wednesday Alternative Breakfast", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.265829	2026-05-25 10:34:40.265829
156f1f8a047f3e659ca74faf	3	lunch	[{"name":"Rice","description":""},{"name":"Egg Curry","description":""},{"name":"Vegetable","description":""}]	[{"name": "Wednesday Alternative Lunch", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.265938	2026-05-25 10:34:40.265938
15c5e1acf4b9545375fa220c	0	breakfast	[{"name":"Paratha","description":""},{"name":"Egg Curry","description":""},{"name":"Tea","description":""}]	[{"name": "Sunday Alternative Breakfast", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.215326	2026-05-25 10:34:40.215326
15cc2d629558061218d76d35	6	lunch	[{"name":"Rice","description":""},{"name":"Mutton Curry","description":""},{"name":"Dal","description":""}]	[{"name": "Saturday Alternative Lunch", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.267006	2026-05-25 10:34:40.267006
2717b29ea9ca9749adf05f4a	0	dinner	[{"name":"Khichuri","description":""},{"name":"Beef Curry","description":""},{"name":"Salad","description":""}]	[{"name": "Sunday Alternative Dinner", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.264927	2026-05-25 10:34:40.264927
33073fccbadace362d54fb16	5	dinner	[{"name":"Rice","description":""},{"name":"Fish Fry","description":""},{"name":"Dal","description":""}]	[{"name": "Friday Alternative Dinner", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.266693	2026-05-25 10:34:40.266693
3a3cff30dc34bbf251ceff9f	2	dinner	[{"name":"Polao","description":""},{"name":"Chicken Curry","description":""},{"name":"Salad","description":""}]	[{"name": "Tuesday Alternative Dinner", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.265734	2026-05-25 10:34:40.265734
3f7b6e85d9a23436f7e2a14e	4	breakfast	[{"name":"Noodles","description":""},{"name":"Egg","description":""},{"name":"Tea","description":""}]	[{"name": "Thursday Alternative Breakfast", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.266171	2026-05-25 10:34:40.266171
4f4a08386275ace4fed04822	3	dinner	[{"name":"Rice","description":""},{"name":"Fish Curry","description":""},{"name":"Dal","description":""}]	[{"name": "Wednesday Alternative Dinner", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.266037	2026-05-25 10:34:40.266038
66ce891df4c16561b2149d10	5	breakfast	[{"name":"Paratha","description":""},{"name":"Halwa","description":""},{"name":"Tea","description":""}]	[{"name": "Friday Alternative Breakfast", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.266491	2026-05-25 10:34:40.266491
6e1fb1575889e1bfb5164ac7	5	lunch	[{"name":"Biriyani","description":""},{"name":"Salad","description":""},{"name":"Borhani","description":""}]	[{"name": "Friday Alternative Lunch", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.266598	2026-05-25 10:34:40.266598
7efa856975143cfffe95404c	1	lunch	[{"name":"Rice","description":""},{"name":"Fish Curry","description":""},{"name":"Dal","description":""}]	[{"name": "Monday Alternative Lunch", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.265219	2026-05-25 10:34:40.265219
97f534dbe843fd498b08178a	2	breakfast	[{"name":"Ruti","description":""},{"name":"Vegetable","description":""},{"name":"Tea","description":""}]	[{"name": "Tuesday Alternative Breakfast", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.265477	2026-05-25 10:34:40.265477
c2dfa2ebc09f7162590ca4c4	2	lunch	[{"name":"Rice","description":""},{"name":"Beef Curry","description":""},{"name":"Dal","description":""}]	[{"name": "Tuesday Alternative Lunch", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.265573	2026-05-25 10:34:40.265573
c5abe2b913ce8ea6f0800a85	1	dinner	[{"name":"Rice","description":""},{"name":"Lentil Soup","description":""},{"name":"Vegetable","description":""}]	[{"name": "Monday Alternative Dinner", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.265378	2026-05-25 10:34:40.265378
c8bc07ca8a5f30363c8fbe33	4	dinner	[{"name":"Rice","description":""},{"name":"Beef Bhuna","description":""},{"name":"Vegetable","description":""}]	[{"name": "Thursday Alternative Dinner", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.266394	2026-05-25 10:34:40.266394
d0a4e35e314f1642fc95d894	4	lunch	[{"name":"Rice","description":""},{"name":"Chicken Roast","description":""},{"name":"Dal","description":""}]	[{"name": "Thursday Alternative Lunch", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.26629	2026-05-25 10:34:40.26629
d4380251974a0bf67ad77a42	0	lunch	[{"name":"Rice","description":""},{"name":"Chicken Curry","description":""},{"name":"Dal","description":""}]	[{"name": "Sunday Alternative Lunch", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.264663	2026-05-25 10:34:40.264663
d4e0ffebdb77c4ecd66532a6	1	breakfast	[{"name":"Khichuri","description":""},{"name":"Boiled Egg","description":""},{"name":"Tea","description":""}]	[{"name": "Monday Alternative Breakfast", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.265075	2026-05-25 10:34:40.265075
d55df1681207e27a1a48c79b	6	dinner	[{"name":"Polao","description":""},{"name":"Roast Chicken","description":""},{"name":"Salad","description":""}]	[{"name": "Saturday Alternative Dinner", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.267173	2026-05-25 10:34:40.267173
ee6b487c3c15790fa4150a99	6	breakfast	[{"name":"Khichuri","description":""},{"name":"Egg Fry","description":""},{"name":"Tea","description":""}]	[{"name": "Saturday Alternative Breakfast", "description": "Weekly alternative option"}]	t	\N	2026-05-25 10:34:40.266853	2026-05-25 10:34:40.266853
\.


--
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20260525084458_InitialCreate	8.0.18
20260525094845_SplitMealSelections	8.0.18
20260525103146_WeeklyMealWorkflow	8.0.18
\.


--
-- Name: Attendance PK_Attendance; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "PK_Attendance" PRIMARY KEY ("Id");


--
-- Name: AuditLogs PK_AuditLogs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditLogs"
    ADD CONSTRAINT "PK_AuditLogs" PRIMARY KEY ("Id");


--
-- Name: Bills PK_Bills; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Bills"
    ADD CONSTRAINT "PK_Bills" PRIMARY KEY ("Id");


--
-- Name: Complaints PK_Complaints; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Complaints"
    ADD CONSTRAINT "PK_Complaints" PRIMARY KEY ("Id");


--
-- Name: Feedback PK_Feedback; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Feedback"
    ADD CONSTRAINT "PK_Feedback" PRIMARY KEY ("Id");


--
-- Name: Holidays PK_Holidays; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Holidays"
    ADD CONSTRAINT "PK_Holidays" PRIMARY KEY ("Id");


--
-- Name: Inventory PK_Inventory; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inventory"
    ADD CONSTRAINT "PK_Inventory" PRIMARY KEY ("Id");


--
-- Name: MealPlans PK_MealPlans; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MealPlans"
    ADD CONSTRAINT "PK_MealPlans" PRIMARY KEY ("Id");


--
-- Name: MealSelections PK_MealSelections; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MealSelections"
    ADD CONSTRAINT "PK_MealSelections" PRIMARY KEY ("Id");


--
-- Name: Menus PK_Menus; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Menus"
    ADD CONSTRAINT "PK_Menus" PRIMARY KEY ("Id");


--
-- Name: Messages PK_Messages; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "PK_Messages" PRIMARY KEY ("Id");


--
-- Name: Notices PK_Notices; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Notices"
    ADD CONSTRAINT "PK_Notices" PRIMARY KEY ("Id");


--
-- Name: Settings PK_Settings; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Settings"
    ADD CONSTRAINT "PK_Settings" PRIMARY KEY ("Id");


--
-- Name: StudentHolidayModes PK_StudentHolidayModes; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."StudentHolidayModes"
    ADD CONSTRAINT "PK_StudentHolidayModes" PRIMARY KEY ("Id");


--
-- Name: Users PK_Users; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");


--
-- Name: WeeklyMealSchedules PK_WeeklyMealSchedules; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."WeeklyMealSchedules"
    ADD CONSTRAINT "PK_WeeklyMealSchedules" PRIMARY KEY ("Id");


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: IX_Attendance_MarkedById; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Attendance_MarkedById" ON public."Attendance" USING btree ("MarkedById");


--
-- Name: IX_Attendance_StudentId_Date_MealType; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Attendance_StudentId_Date_MealType" ON public."Attendance" USING btree ("StudentId", "Date", "MealType");


--
-- Name: IX_Bills_StudentId_Month_Year; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Bills_StudentId_Month_Year" ON public."Bills" USING btree ("StudentId", "Month", "Year");


--
-- Name: IX_Complaints_ResolvedById; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Complaints_ResolvedById" ON public."Complaints" USING btree ("ResolvedById");


--
-- Name: IX_Complaints_StudentId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Complaints_StudentId" ON public."Complaints" USING btree ("StudentId");


--
-- Name: IX_Feedback_StudentId_Date_MealType; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Feedback_StudentId_Date_MealType" ON public."Feedback" USING btree ("StudentId", "Date", "MealType");


--
-- Name: IX_Holidays_SettingsId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Holidays_SettingsId" ON public."Holidays" USING btree ("SettingsId");


--
-- Name: IX_MealPlans_StudentId_Date; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_MealPlans_StudentId_Date" ON public."MealPlans" USING btree ("StudentId", "Date");


--
-- Name: IX_MealSelections_StudentId_Date; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_MealSelections_StudentId_Date" ON public."MealSelections" USING btree ("StudentId", "Date");


--
-- Name: IX_Menus_CreatedById; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Menus_CreatedById" ON public."Menus" USING btree ("CreatedById");


--
-- Name: IX_Menus_Date_MealType; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Menus_Date_MealType" ON public."Menus" USING btree ("Date", "MealType");


--
-- Name: IX_Messages_ReceiverId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Messages_ReceiverId" ON public."Messages" USING btree ("ReceiverId");


--
-- Name: IX_Messages_SenderId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Messages_SenderId" ON public."Messages" USING btree ("SenderId");


--
-- Name: IX_Notices_CreatedById; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Notices_CreatedById" ON public."Notices" USING btree ("CreatedById");


--
-- Name: IX_StudentHolidayModes_StudentId; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_StudentHolidayModes_StudentId" ON public."StudentHolidayModes" USING btree ("StudentId");


--
-- Name: IX_Users_Email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Users_Email" ON public."Users" USING btree ("Email");


--
-- Name: IX_Users_RollNumber; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Users_RollNumber" ON public."Users" USING btree ("RollNumber");


--
-- Name: IX_WeeklyMealSchedules_DayOfWeek_MealType; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_WeeklyMealSchedules_DayOfWeek_MealType" ON public."WeeklyMealSchedules" USING btree ("DayOfWeek", "MealType");


--
-- Name: Attendance FK_Attendance_Users_MarkedById; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "FK_Attendance_Users_MarkedById" FOREIGN KEY ("MarkedById") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Attendance FK_Attendance_Users_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "FK_Attendance_Users_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Bills FK_Bills_Users_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Bills"
    ADD CONSTRAINT "FK_Bills_Users_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Complaints FK_Complaints_Users_ResolvedById; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Complaints"
    ADD CONSTRAINT "FK_Complaints_Users_ResolvedById" FOREIGN KEY ("ResolvedById") REFERENCES public."Users"("Id");


--
-- Name: Complaints FK_Complaints_Users_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Complaints"
    ADD CONSTRAINT "FK_Complaints_Users_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Feedback FK_Feedback_Users_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Feedback"
    ADD CONSTRAINT "FK_Feedback_Users_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Holidays FK_Holidays_Settings_SettingsId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Holidays"
    ADD CONSTRAINT "FK_Holidays_Settings_SettingsId" FOREIGN KEY ("SettingsId") REFERENCES public."Settings"("Id") ON DELETE CASCADE;


--
-- Name: MealPlans FK_MealPlans_Users_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MealPlans"
    ADD CONSTRAINT "FK_MealPlans_Users_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: MealSelections FK_MealSelections_Users_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MealSelections"
    ADD CONSTRAINT "FK_MealSelections_Users_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Menus FK_Menus_Users_CreatedById; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Menus"
    ADD CONSTRAINT "FK_Menus_Users_CreatedById" FOREIGN KEY ("CreatedById") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Messages FK_Messages_Users_ReceiverId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "FK_Messages_Users_ReceiverId" FOREIGN KEY ("ReceiverId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Messages FK_Messages_Users_SenderId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "FK_Messages_Users_SenderId" FOREIGN KEY ("SenderId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: Notices FK_Notices_Users_CreatedById; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Notices"
    ADD CONSTRAINT "FK_Notices_Users_CreatedById" FOREIGN KEY ("CreatedById") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: StudentHolidayModes FK_StudentHolidayModes_Users_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."StudentHolidayModes"
    ADD CONSTRAINT "FK_StudentHolidayModes_Users_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict DCkzJoHvBflyZUrKhj3H5kYuB2ndZGQqTZsR0f3ZC4gW9enE3aYWnBwvRuJW7iP

