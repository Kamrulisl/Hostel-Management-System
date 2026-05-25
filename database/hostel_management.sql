--
-- PostgreSQL database dump
--

\restrict dWplaIcJuCYmyfVMgusKGjkVNZ5FJU9P6H2e9qSWnCj6VvcQ7778tOWMqlTvXUL

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
ALTER TABLE IF EXISTS ONLY public."DailyBazars" DROP CONSTRAINT IF EXISTS "FK_DailyBazars_Users_CreatedById";
ALTER TABLE IF EXISTS ONLY public."Complaints" DROP CONSTRAINT IF EXISTS "FK_Complaints_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."Complaints" DROP CONSTRAINT IF EXISTS "FK_Complaints_Users_ResolvedById";
ALTER TABLE IF EXISTS ONLY public."Bills" DROP CONSTRAINT IF EXISTS "FK_Bills_Users_StudentId";
ALTER TABLE IF EXISTS ONLY public."AdvancePayments" DROP CONSTRAINT IF EXISTS "FK_AdvancePayments_Users_StudentId";
DROP INDEX IF EXISTS public."IX_WeeklyMealSchedules_DayOfWeek_MealType";
DROP INDEX IF EXISTS public."IX_UtilityExpenses_Year_Month_Type";
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
DROP INDEX IF EXISTS public."IX_DailyBazars_CreatedById";
DROP INDEX IF EXISTS public."IX_Complaints_StudentId";
DROP INDEX IF EXISTS public."IX_Complaints_ResolvedById";
DROP INDEX IF EXISTS public."IX_Bills_StudentId_Month_Year";
DROP INDEX IF EXISTS public."IX_AdvancePayments_StudentId_Date";
ALTER TABLE IF EXISTS ONLY public."__EFMigrationsHistory" DROP CONSTRAINT IF EXISTS "PK___EFMigrationsHistory";
ALTER TABLE IF EXISTS ONLY public."WeeklyMealSchedules" DROP CONSTRAINT IF EXISTS "PK_WeeklyMealSchedules";
ALTER TABLE IF EXISTS ONLY public."UtilityExpenses" DROP CONSTRAINT IF EXISTS "PK_UtilityExpenses";
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
ALTER TABLE IF EXISTS ONLY public."DailyBazars" DROP CONSTRAINT IF EXISTS "PK_DailyBazars";
ALTER TABLE IF EXISTS ONLY public."Complaints" DROP CONSTRAINT IF EXISTS "PK_Complaints";
ALTER TABLE IF EXISTS ONLY public."Bills" DROP CONSTRAINT IF EXISTS "PK_Bills";
ALTER TABLE IF EXISTS ONLY public."AuditLogs" DROP CONSTRAINT IF EXISTS "PK_AuditLogs";
ALTER TABLE IF EXISTS ONLY public."AdvancePayments" DROP CONSTRAINT IF EXISTS "PK_AdvancePayments";
DROP TABLE IF EXISTS public."__EFMigrationsHistory";
DROP TABLE IF EXISTS public."WeeklyMealSchedules";
DROP TABLE IF EXISTS public."UtilityExpenses";
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
DROP TABLE IF EXISTS public."DailyBazars";
DROP TABLE IF EXISTS public."Complaints";
DROP TABLE IF EXISTS public."Bills";
DROP TABLE IF EXISTS public."AuditLogs";
DROP TABLE IF EXISTS public."AdvancePayments";
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AdvancePayments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AdvancePayments" (
    "Id" text NOT NULL,
    "StudentId" text NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "Amount" numeric NOT NULL,
    "ReceivedById" text NOT NULL,
    "Notes" text,
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
    "UpdatedAt" timestamp without time zone NOT NULL,
    "AdvancePaid" numeric DEFAULT 0.0 NOT NULL,
    "MealRate" numeric DEFAULT 0.0 NOT NULL,
    "PreviousDue" numeric DEFAULT 0.0 NOT NULL,
    "UtilityCost" numeric DEFAULT 0.0 NOT NULL
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
-- Name: DailyBazars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DailyBazars" (
    "Id" text NOT NULL,
    "Date" timestamp without time zone NOT NULL,
    "ItemsJson" text NOT NULL,
    "TotalAmount" numeric NOT NULL,
    "CreatedById" text NOT NULL,
    "Notes" text,
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
-- Name: UtilityExpenses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UtilityExpenses" (
    "Id" text NOT NULL,
    "Month" integer NOT NULL,
    "Year" integer NOT NULL,
    "Type" text NOT NULL,
    "Amount" numeric NOT NULL,
    "Notes" text,
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
-- Data for Name: AdvancePayments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AdvancePayments" ("Id", "StudentId", "Date", "Amount", "ReceivedById", "Notes", "CreatedAt", "UpdatedAt") FROM stdin;
797ff87ff8b153d325b8ef43	3acdfa641bdfe968502b3d15	2026-05-25 00:00:00	1000	2a8fbe44e221552bf3ea6454	Advance	2026-05-25 14:38:19.955981	2026-05-25 14:38:19.955981
a87fb88a7be7a435914dea16	62450f8f827d568aff2d1d0e	2026-04-11 00:00:00	600	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
858cf348ba110015041de6ec	a027f3f9781c81aa23cde1a2	2026-04-12 00:00:00	700	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
d7e658d13ec77aedc450d98a	ac21bc09cabf3e4524499f21	2026-04-13 00:00:00	800	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
6d8af5e6536dd41be9dc0d49	94376abf17118888318655ee	2026-04-14 00:00:00	900	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
b2c00f8abac21605f8c0183e	005485d041fff18bf989d8ad	2026-04-15 00:00:00	1000	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
3a9b148eca3a2db7ff61ee1f	63a54b4f76f8997b6875ae11	2026-04-16 00:00:00	1100	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
6f47a2b0e6fefdcd53afa819	da53bc3629e9f9c8803332e5	2026-04-17 00:00:00	1200	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
f05c78964d4f2adbd6a6c9b0	baee7cc06393927d525d67f6	2026-04-18 00:00:00	1300	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
e01547ab403d4511369be6af	3d2b3c42be684eba0fb2232f	2026-04-19 00:00:00	1400	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
f06f1d0ed263f107fd9e9698	d0a6263e56e5f052cb12b33f	2026-04-10 00:00:00	1500	2a8fbe44e221552bf3ea6454	April demo advance	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
59969d7e087ab09a2fc5331d	3acdfa641bdfe968502b3d15	2026-04-05 00:00:00	500	2a8fbe44e221552bf3ea6454	Visible demo advance - April first payment	2026-05-25 22:12:34.485713	2026-05-25 22:12:34.485713
88e6060f698dcd7fd2188451	3acdfa641bdfe968502b3d15	2026-04-20 00:00:00	750	2a8fbe44e221552bf3ea6454	Visible demo advance - April second payment	2026-05-25 22:12:34.485713	2026-05-25 22:12:34.485713
ad6b053aa47c74f2549c8615	3acdfa641bdfe968502b3d15	2026-05-08 00:00:00	600	2a8fbe44e221552bf3ea6454	Visible demo advance - May first payment	2026-05-25 22:12:34.485713	2026-05-25 22:12:34.485713
d79b6380d50715f24bfb7028	3acdfa641bdfe968502b3d15	2026-05-22 00:00:00	900	2a8fbe44e221552bf3ea6454	Visible demo advance - May second payment	2026-05-25 22:12:34.485713	2026-05-25 22:12:34.485713
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
1190bd2cfdc49ed4a4d6197f	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 12:49:41.203202	2026-05-25 12:49:41.203241
3a0bd067ff269cce34c65cc5	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 12:50:11.277042	2026-05-25 12:50:11.277042
35e9f35afbe80305cd42f880	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 13:11:30.989856	2026-05-25 13:11:30.989934
c75ca8b8e60118b2e177a42e	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 13:11:32.565959	2026-05-25 13:11:32.565959
c987843942574d9ff76a4537	bc413512843c5139b681c31f	student	LOGIN	User	bc413512843c5139b681c31f	User logged in	{}	2026-05-25 13:18:11.898765	2026-05-25 13:18:11.898765
0c3d65f44b2438c217c2484a	be0ba0ba02ad271dbb3c612b	student	LOGIN	User	be0ba0ba02ad271dbb3c612b	User logged in	{}	2026-05-25 13:31:47.935904	2026-05-25 13:31:47.935904
662ba9c261ba53ccc1bc4b7c	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 14:10:00.394105	2026-05-25 14:10:00.394216
fe8953533399b9caa3aef34c	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 14:16:52.101086	2026-05-25 14:16:52.101119
75707efd8d463f51bc6438c2	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 14:19:06.02224	2026-05-25 14:19:06.02224
5d1c3d3981c93366500cae32	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 14:19:12.278903	2026-05-25 14:19:12.278903
42c85200e4b23d48f4e49434	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 14:20:33.965216	2026-05-25 14:20:33.965216
7f761c56c9f794659f1fae67	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 14:20:34.380512	2026-05-25 14:20:34.380512
468bf2a01dfdbcf214d1d9b6	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 14:20:34.765139	2026-05-25 14:20:34.765139
1fb114ad02ecc9907366d38c	474a93b899cc03d94a78543f	admin	BILL_GENERATE	Bill	\N	Generated bills for 5/2026	{"count":5}	2026-05-25 14:20:36.623444	2026-05-25 14:20:36.623444
40329848dba3a2588edce37b	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 14:21:44.822035	2026-05-25 14:21:44.822064
0d5d1946ec6f8c8523bf8af1	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 14:21:45.606039	2026-05-25 14:21:45.606039
f31d9f46c827954f5652c7ed	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 14:21:46.063698	2026-05-25 14:21:46.063698
452f6e64a9bd9fc9ea66529c	474a93b899cc03d94a78543f	admin	BILL_GENERATE	Bill	\N	Generated bills for 5/2026	{"count":5}	2026-05-25 14:21:48.093385	2026-05-25 14:21:48.093385
a4775287ddba9450d6f2200b	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 14:24:47.20376	2026-05-25 14:24:47.203802
1190ea2b1dec3f5d9abf7196	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 14:28:25.438814	2026-05-25 14:28:25.438839
ef19ae86532c91e24da1bf0b	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 14:33:50.418818	2026-05-25 14:33:50.418872
9d558553ebb7c4422a4903fd	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 14:33:59.911015	2026-05-25 14:33:59.911015
9a18ae42582f308c2dbf8670	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 14:35:44.659572	2026-05-25 14:35:44.659572
4994a048ab3e2831189171e1	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 14:36:02.835291	2026-05-25 14:36:02.835291
9a652c90a82f5d619229d5aa	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 14:37:23.181249	2026-05-25 14:37:23.181249
fb7504da4fb46ade797a1f2a	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 14:49:42.14243	2026-05-25 14:49:42.142621
8dbac0bd762b6d04a1d73a6e	2a8fbe44e221552bf3ea6454	manager	LOGIN	User	2a8fbe44e221552bf3ea6454	User logged in	{}	2026-05-25 14:49:45.422364	2026-05-25 14:49:45.422364
8b419e81669e559271d75828	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 14:54:36.109964	2026-05-25 14:54:36.109964
5c7d52bd2640b0578c192f66	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 15:02:52.764019	2026-05-25 15:02:52.764019
78bbc41a86ce79a4952c90a0	474a93b899cc03d94a78543f	admin	BILL_GENERATE	Bill	\N	Generated bills for 4/2026	{"count":35}	2026-05-25 15:03:06.103276	2026-05-25 15:03:06.103276
208a60ebbe93768cdd78b938	474a93b899cc03d94a78543f	admin	LOGIN	User	474a93b899cc03d94a78543f	User logged in	{}	2026-05-25 16:12:44.171191	2026-05-25 16:12:44.171219
f5ecb54e9b47b099eb022cff	474a93b899cc03d94a78543f	admin	BILL_GENERATE	Bill	\N	Generated bills for 4/2026	{"count":35}	2026-05-25 16:12:47.565117	2026-05-25 16:12:47.565117
6bb471aa8d63280baca2916e	474a93b899cc03d94a78543f	admin	BILL_GENERATE	Bill	\N	Generated bills for 5/2026	{"count":35}	2026-05-25 16:12:50.315536	2026-05-25 16:12:50.315536
3adcccbc4c442aaf997e312a	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 18:49:34.807373	2026-05-25 18:49:34.8074
bc295cfe731dd4a6d1881753	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 18:51:22.457492	2026-05-25 18:51:22.457492
ef17e5497dcefe7a2b3da6d1	3acdfa641bdfe968502b3d15	student	LOGIN	User	3acdfa641bdfe968502b3d15	User logged in	{}	2026-05-25 18:57:57.342822	2026-05-25 18:57:57.342874
\.


--
-- Data for Name: Bills; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Bills" ("Id", "StudentId", "Month", "Year", "TotalMeals", "MealCost", "FixedCost", "TotalAmount", "Status", "PaidAt", "PaymentMethod", "TransactionId", "BreakfastCount", "BreakfastRate", "LunchCount", "LunchRate", "DinnerCount", "DinnerRate", "GeneratedById", "CreatedAt", "UpdatedAt", "AdvancePaid", "MealRate", "PreviousDue", "UtilityCost") FROM stdin;
00b2613808b69f2307904a85	1f73c5a5abb764dcacf6c48e	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:47.07629	2026-05-25 16:12:47.076576	0.0	104.88	0	957.14
08d8276cda64a5189cefb58a	4c8d363ce18fc3f850cf56fc	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:47.323144	2026-05-25 16:12:47.323351	0.0	104.88	0	957.14
11fc5c16c8ebd3c921963e36	005485d041fff18bf989d8ad	4	2026	90	9439.20	0	9396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.624091	2026-05-25 16:12:45.62428	1000	104.88	0	957.14
1575ab77369fa8306d459ee8	f8a3c918aa67340ebc465017	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.442842	2026-05-25 16:12:46.443033	0.0	104.88	0	957.14
15be970a9389d84bdc664f16	fc15c07b5ab015faa668bbde	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.159457	2026-05-25 16:12:46.159611	0.0	104.88	0	957.14
20a50fe0c248f089c12ed954	63a54b4f76f8997b6875ae11	4	2026	90	9439.20	0	9296.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.709498	2026-05-25 16:12:45.709788	1100	104.88	0	957.14
20fd31c4bad4e4341d7fbc7b	94376abf17118888318655ee	4	2026	90	9439.20	0	9496.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.528181	2026-05-25 16:12:45.528449	900	104.88	0	957.14
2134a1f75c4d0f677bbbc5e4	b761720b1572afcc60701676	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.085224	2026-05-25 16:12:46.085531	0.0	104.88	0	957.14
3ed76bf77e041e5ca6820358	a027f3f9781c81aa23cde1a2	4	2026	90	9439.20	0	9696.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.261603	2026-05-25 16:12:45.261763	700	104.88	0	957.14
4302752009ba4508253828bf	3d2b3c42be684eba0fb2232f	4	2026	90	9439.20	0	8996.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.943112	2026-05-25 16:12:45.943264	1400	104.88	0	957.14
4fba932cace4712491181b90	baee7cc06393927d525d67f6	4	2026	90	9439.20	0	9096.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.868322	2026-05-25 16:12:45.868678	1300	104.88	0	957.14
55353797369f3800c9ecb9c3	11a8d02b3d98873356cfa1c4	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.587187	2026-05-25 16:12:46.58732	0.0	104.88	0	957.14
55bfc359b2d87bd7ca516120	9ede9c682fb2b744b91f42d3	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:44.967373	2026-05-25 16:12:44.967737	0.0	104.88	0	957.14
57c7bc9517ff48a0b8c7b8db	d0a6263e56e5f052cb12b33f	4	2026	90	9439.20	0	8896.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.01429	2026-05-25 16:12:46.014424	1500	104.88	0	957.14
5d0f646002525923acabadc7	f4cf177098b1be8090bd4dda	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:47.405019	2026-05-25 16:12:47.405132	0.0	104.88	0	957.14
608e191c91306d6cbffbd136	da53bc3629e9f9c8803332e5	4	2026	90	9439.20	0	9196.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.795935	2026-05-25 16:12:45.796148	1200	104.88	0	957.14
67fe5d9de8307ba5c08fbb75	6625d58ade1b76ce21aa7155	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:47.239993	2026-05-25 16:12:47.240114	0.0	104.88	0	957.14
753bb4f862a457e7075341fb	f029e06fa00b52dc81e8ff92	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.370754	2026-05-25 16:12:46.370875	0.0	104.88	0	957.14
7da1bf15387632ea281a70b5	0b06e7af84c25778e3a8ddbb	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:47.000319	2026-05-25 16:12:47.00054	0.0	104.88	0	957.14
8a1aad37a77baefb69b4d902	254425d723cc5cddc2867f11	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.656258	2026-05-25 16:12:46.656371	0.0	104.88	0	957.14
91d53836fe04b002effbebd6	8f1d543461fe08b3bf1f8dc0	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.863872	2026-05-25 16:12:46.863996	0.0	104.88	0	957.14
9336161ef419df1026e4afa7	be0ba0ba02ad271dbb3c612b	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:44.750045	2026-05-25 16:12:44.750247	0.0	104.88	0	957.14
a59e11ab7b68710848276756	bc413512843c5139b681c31f	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:44.867163	2026-05-25 16:12:44.867405	0.0	104.88	0	957.14
b80bbce1376dd7cde29ccad8	ac21bc09cabf3e4524499f21	4	2026	90	9439.20	0	9596.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.40107	2026-05-25 16:12:45.401248	800	104.88	0	957.14
b9651828a97926132294e7c6	796e488102d7e48fa7f5ce29	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.724375	2026-05-25 16:12:46.724732	0.0	104.88	0	957.14
bb8d370fb1b8bbdab2593d87	06d2e750cd05df2906447617	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.302426	2026-05-25 16:12:46.302594	0.0	104.88	0	957.14
c1d5a26fbbc8831e70be4342	f94b450bae7a78bc1b104045	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.933806	2026-05-25 16:12:46.933941	0.0	104.88	0	957.14
c54e0e0f54b14dfcad96febf	ee035fe5e452171f13f6f523	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.794087	2026-05-25 16:12:46.794265	0.0	104.88	0	957.14
c6c9ab496b268b1a9f1cdb47	16f3c1444d5164ba823581b2	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:47.486334	2026-05-25 16:12:47.486447	0.0	104.88	0	957.14
c7d03b17c7735e4d23485619	2d738cbbc34c343517d78f91	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.071569	2026-05-25 16:12:45.071693	0.0	104.88	0	957.14
cc1c8c160db4790a3c6177d5	792dcb7d39f8217bf113bb35	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.230366	2026-05-25 16:12:46.230558	0.0	104.88	0	957.14
e75ad4039be389d942425459	bf65102ca6f45510aa005795	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:46.517846	2026-05-25 16:12:46.517958	0.0	104.88	0	957.14
e885a00d2298580b115757a6	83b6ffc343022b0ae2b14962	4	2026	90	9439.20	0	10396.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:47.160335	2026-05-25 16:12:47.160584	0.0	104.88	0	957.14
ef48671ed1a8c431cbb72ede	62450f8f827d568aff2d1d0e	4	2026	90	9439.20	0	9796.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:45.166806	2026-05-25 16:12:45.166975	600	104.88	0	957.14
fdb9a34a5612f09898414928	3acdfa641bdfe968502b3d15	4	2026	90	9439.20	0	9146.34	DUE	\N	\N	\N	30	104.88	30	104.88	30	104.88	474a93b899cc03d94a78543f	2026-05-25 16:12:44.632226	2026-05-25 16:12:44.635025	1250	104.88	0	957.14
020c4338a7d069d10b2b903b	f8a3c918aa67340ebc465017	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.201427	2026-05-25 16:12:49.201521	0.0	0.05	10396.34	0.0
2396b4d889fd3719d472fa4b	f029e06fa00b52dc81e8ff92	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.13428	2026-05-25 16:12:49.134384	0.0	0.05	10396.34	0.0
3395e84dcb45620387a31500	6625d58ade1b76ce21aa7155	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:50.098767	2026-05-25 16:12:50.098868	0.0	0.05	10396.34	0.0
3405786e22b9075f12bf4309	792dcb7d39f8217bf113bb35	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.926291	2026-05-25 16:12:48.926394	0.0	0.05	10396.34	0.0
34a6f160749d592c06c6bfc8	3acdfa641bdfe968502b3d15	5	2026	75	3.75	0	6650.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:47.741485	2026-05-25 16:12:47.741619	2500	0.05	9146.34	0.0
34bb634453613aaf5c3e557e	94376abf17118888318655ee	5	2026	75	3.75	0	9500.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.32316	2026-05-25 16:12:48.323232	0.0	0.05	9496.34	0.0
381c7a5f303c384d3f3e4f55	bf65102ca6f45510aa005795	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.265954	2026-05-25 16:12:49.266046	0.0	0.05	10396.34	0.0
5a30bd6a1be75974e9002a0c	bc413512843c5139b681c31f	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:47.890291	2026-05-25 16:12:47.890373	0.0	0.05	10396.34	0.0
67aec6dc6bb997cb5f6afc31	be0ba0ba02ad271dbb3c612b	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:47.814016	2026-05-25 16:12:47.814161	0.0	0.05	10396.34	0.0
69483f1768f535ec0831c4f6	06d2e750cd05df2906447617	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.066555	2026-05-25 16:12:49.066667	0.0	0.05	10396.34	0.0
69d155098f41914fc1a613e4	16f3c1444d5164ba823581b2	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:50.291904	2026-05-25 16:12:50.291964	0.0	0.05	10396.34	0.0
6d738ed1a187e3eda881b7eb	baee7cc06393927d525d67f6	5	2026	75	3.75	0	9100.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.590724	2026-05-25 16:12:48.590794	0.0	0.05	9096.34	0.0
6e189683b8ed3831c7916095	796e488102d7e48fa7f5ce29	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.511442	2026-05-25 16:12:49.511555	0.0	0.05	10396.34	0.0
7043d91071c66ed4e76a00b1	2d738cbbc34c343517d78f91	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.047277	2026-05-25 16:12:48.047374	0.0	0.05	10396.34	0.0
877107049742f0b39f843036	fc15c07b5ab015faa668bbde	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.857512	2026-05-25 16:12:48.857609	0.0	0.05	10396.34	0.0
8b1f0016d9e71933c25e4f84	62450f8f827d568aff2d1d0e	5	2026	75	3.75	0	9800.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.123908	2026-05-25 16:12:48.123998	0.0	0.05	9796.34	0.0
8d8fb876cfbedcbe8f610e42	63a54b4f76f8997b6875ae11	5	2026	75	3.75	0	9300.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.458713	2026-05-25 16:12:48.458843	0.0	0.05	9296.34	0.0
8fe90e3efa603c1b3d23b82b	005485d041fff18bf989d8ad	5	2026	75	3.75	0	9400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.392963	2026-05-25 16:12:48.393098	0.0	0.05	9396.34	0.0
92a6604adbcee78042113243	4c8d363ce18fc3f850cf56fc	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:50.169288	2026-05-25 16:12:50.16937	0.0	0.05	10396.34	0.0
9acce1437ce554761a94b5db	f4cf177098b1be8090bd4dda	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:50.231205	2026-05-25 16:12:50.231288	0.0	0.05	10396.34	0.0
9b89a9374be580e17f139880	b761720b1572afcc60701676	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.789892	2026-05-25 16:12:48.789957	0.0	0.05	10396.34	0.0
afce0af3d4203a9f69573e66	ee035fe5e452171f13f6f523	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.599254	2026-05-25 16:12:49.599333	0.0	0.05	10396.34	0.0
b18d036d517b01fbe808680f	da53bc3629e9f9c8803332e5	5	2026	75	3.75	0	9200.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.52689	2026-05-25 16:12:48.527009	0.0	0.05	9196.34	0.0
b623cf9a9abf89a6125dce19	254425d723cc5cddc2867f11	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.424293	2026-05-25 16:12:49.424579	0.0	0.05	10396.34	0.0
bf60bb93024cf12a149eb869	11a8d02b3d98873356cfa1c4	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.338261	2026-05-25 16:12:49.3385	0.0	0.05	10396.34	0.0
c16bc504935a47c9e68e653d	ac21bc09cabf3e4524499f21	5	2026	75	3.75	0	9600.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.255396	2026-05-25 16:12:48.255497	0.0	0.05	9596.34	0.0
c542fa057da914e90cc57404	0b06e7af84c25778e3a8ddbb	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.85177	2026-05-25 16:12:49.851876	0.0	0.05	10396.34	0.0
cedb6defaa1aebb75aa04903	3d2b3c42be684eba0fb2232f	5	2026	75	3.75	0	9000.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.657703	2026-05-25 16:12:48.657773	0.0	0.05	8996.34	0.0
d34a5a4d209b13a5708be138	a027f3f9781c81aa23cde1a2	5	2026	75	3.75	0	9700.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.189046	2026-05-25 16:12:48.189135	0.0	0.05	9696.34	0.0
d38ef39c35deb524d58d7a33	9ede9c682fb2b744b91f42d3	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:47.96962	2026-05-25 16:12:47.969808	0.0	0.05	10396.34	0.0
e11e6ed79a7e7953a57dba1a	f94b450bae7a78bc1b104045	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.768984	2026-05-25 16:12:49.769204	0.0	0.05	10396.34	0.0
e8a1b1395746102ea74974b7	1f73c5a5abb764dcacf6c48e	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.933258	2026-05-25 16:12:49.933334	0.0	0.05	10396.34	0.0
ea32ab87efc8e0b4e3f3aeb3	8f1d543461fe08b3bf1f8dc0	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:49.682114	2026-05-25 16:12:49.682312	0.0	0.05	10396.34	0.0
fb4b9b9a985ef51eb27ccf02	83b6ffc343022b0ae2b14962	5	2026	75	3.75	0	10400.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:50.014452	2026-05-25 16:12:50.014546	0.0	0.05	10396.34	0.0
fef7a89b64f3eb9c627f4d8e	d0a6263e56e5f052cb12b33f	5	2026	75	3.75	0	8900.09	DUE	\N	\N	\N	25	0.05	25	0.05	25	0.05	474a93b899cc03d94a78543f	2026-05-25 16:12:48.724159	2026-05-25 16:12:48.724242	0.0	0.05	8896.34	0.0
\.


--
-- Data for Name: Complaints; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Complaints" ("Id", "StudentId", "Category", "Title", "Description", "Status", "Priority", "ResolvedById", "ResolvedAt", "AdminNotes", "CreatedAt", "UpdatedAt") FROM stdin;
comp00000000000000000001	3acdfa641bdfe968502b3d15	food	Lunch was too spicy	Please reduce chili in chicken curry.	pending	medium	\N	\N	\N	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
comp00000000000000000002	be0ba0ba02ad271dbb3c612b	maintenance	Water filter issue	Dining water filter needs cleaning.	in-progress	high	474a93b899cc03d94a78543f	\N	Assigned to maintenance team	2026-05-25 15:28:18.757808	2026-05-25 15:28:18.757808
\.


--
-- Data for Name: DailyBazars; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DailyBazars" ("Id", "Date", "ItemsJson", "TotalAmount", "CreatedById", "Notes", "CreatedAt", "UpdatedAt") FROM stdin;
69f6ff4e9201a71bcc6c5c9b	2026-05-25 00:00:00	[{"itemName":"Rice","quantity":2,"unit":"kg","price":70}]	140	2a8fbe44e221552bf3ea6454	\N	2026-05-25 13:11:32.959255	2026-05-25 13:11:32.959255
e05e1f4b7c7a9de6865518a7	2026-04-01 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10505	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
6ee9818611f593f7bcd52407	2026-04-02 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10540	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
e100f1b97440f7bd174130f4	2026-04-03 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10575	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
d56acba2bc45f41c099bd890	2026-04-04 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10610	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
48d8f61cd993f0b62b52c397	2026-04-05 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10645	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
6cd09a39dae42cedacda2863	2026-04-06 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10680	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
77b8eb439eb7758bddcc31ae	2026-04-07 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10715	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
070c9e3de12b9e212436e453	2026-04-08 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10750	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
d352a0d5467558cae38e302e	2026-04-09 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10785	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
80478eae494d4ae089d1038c	2026-04-10 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10820	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
1761a56ffa612d24e6b56d3c	2026-04-11 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10855	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
f6245ab9adbf906e3c7ab344	2026-04-12 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10890	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
cd160d154b514ab85fd6174a	2026-04-13 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10925	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
839c14b52ebe1a551c96bf4e	2026-04-14 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10960	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
7d86289393160d9cc95ab5e8	2026-04-15 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	10995	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
3849ec3116d594493fa84775	2026-04-16 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11030	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
a14d7818283302c3c42eb7bc	2026-04-17 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11065	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
d34adab91654e0ad99bd2f78	2026-04-18 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11100	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
8e2ed94b00c72a1cacaa9405	2026-04-19 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11135	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
d42a0f50f745254b206adbe2	2026-04-20 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11170	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
1e161f7b5d43525ed395fa30	2026-04-21 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11205	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
bdca77aa9dceb5de866f3bf4	2026-04-22 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11240	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
526864e5a495e9c99bcdecb7	2026-04-23 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11275	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
bc60cb43fb35445438a5d70a	2026-04-24 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11310	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
3cff5eb3c2c60adba8963d72	2026-04-25 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11345	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
bb9c6aa945afe42cc909d6c0	2026-04-26 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11380	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
53705dfb2504b7d557339837	2026-04-27 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11415	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
192a38632dee607ec1bfc2a8	2026-04-28 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11450	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
cc7b8f646b1ca6a77f76fad0	2026-04-29 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11485	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
5a3c952acaa27f2bdefc62c5	2026-04-30 00:00:00	[{"itemName":"Rice","quantity":35,"unit":"kg","price":70,"total":2450},{"itemName":"Dal","quantity":8,"unit":"kg","price":130,"total":1040},{"itemName":"Vegetable","quantity":18,"unit":"kg","price":60,"total":1080},{"itemName":"Fish/Chicken","quantity":20,"unit":"kg","price":220,"total":4400},{"itemName":"Oil/Spices","quantity":1,"unit":"set","price":1500,"total":1500}]	11520	2a8fbe44e221552bf3ea6454	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
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
91f6d8d5ab7027deb04b1916	3acdfa641bdfe968502b3d15	2026-05-26 00:00:00	t	t	t	2026-05-25 10:34:40.472443	2026-05-25 14:40:08.090836	2026-05-25 10:34:48.917668	474a93b899cc03d94a78543f	default	[{"name":"Ruti","description":""},{"name":"Vegetable","description":""},{"name":"Tea","description":""}]	approved	default	[{"name":"Polao","description":""},{"name":"Chicken Curry","description":""},{"name":"Salad","description":""}]	approved	default	[{"name":"Rice","description":""},{"name":"Beef Curry","description":""},{"name":"Dal","description":""}]	approved	
8725863df58a446c99ca7a86	62450f8f827d568aff2d1d0e	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
201adbf8c6c376c3699a659a	62450f8f827d568aff2d1d0e	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7394712723401deae0fc62a6	62450f8f827d568aff2d1d0e	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
51d53af13014d944bc46eaad	62450f8f827d568aff2d1d0e	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d519fcf221688749c7396609	62450f8f827d568aff2d1d0e	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ae3a451f306ccf7b1dd4149b	62450f8f827d568aff2d1d0e	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0cb8820bf3982e29554ee7b9	62450f8f827d568aff2d1d0e	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
663381438d2e83815493ee2a	62450f8f827d568aff2d1d0e	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fea8bdcd453ea936f0a0b338	62450f8f827d568aff2d1d0e	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b94cd57104349575093268e4	62450f8f827d568aff2d1d0e	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4f8529f8ea4d9c3a38e480a7	62450f8f827d568aff2d1d0e	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fecff69580cc9dc4148da702	62450f8f827d568aff2d1d0e	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
677da412c8c98ba3b3f69a02	62450f8f827d568aff2d1d0e	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ea60dafd442b2a61554b4000	62450f8f827d568aff2d1d0e	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
caf2c4cccc7f89dec88086f3	62450f8f827d568aff2d1d0e	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ebcbc6ce7d109564108bf88a	62450f8f827d568aff2d1d0e	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
39391f32c01fe8c0183e18d8	62450f8f827d568aff2d1d0e	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c12698bcb00c72f968ff5a93	62450f8f827d568aff2d1d0e	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e45e0ad1f4865a1905d029d3	62450f8f827d568aff2d1d0e	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
099b72eec699b54142971b84	62450f8f827d568aff2d1d0e	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b7ea70d9b8bc2fba38a906df	62450f8f827d568aff2d1d0e	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ef9129690c956e7427c32382	62450f8f827d568aff2d1d0e	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0318a2d2b54c7d330780c459	62450f8f827d568aff2d1d0e	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
59fd2cd9975389d6aff88a1f	62450f8f827d568aff2d1d0e	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5f578c9d5b7e59460fb4b3c3	62450f8f827d568aff2d1d0e	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
75b96ccc4e020ae6d2a5bd5b	62450f8f827d568aff2d1d0e	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ed38124d343b1413b2bfe395	62450f8f827d568aff2d1d0e	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b98bde0b356d60eba21e2f5e	62450f8f827d568aff2d1d0e	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
696aa4330e9c9e248d3c1cae	62450f8f827d568aff2d1d0e	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
df6eadf63873a11dea9517e4	62450f8f827d568aff2d1d0e	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
445e1ae645d43cbadd77a8ae	a027f3f9781c81aa23cde1a2	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8839926d7bcc3089754e38d0	a027f3f9781c81aa23cde1a2	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8f0fdb596db339b03e10c60d	a027f3f9781c81aa23cde1a2	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fb46851e2c2bc62db667c9cb	a027f3f9781c81aa23cde1a2	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
402c33f142c474da62ced929	a027f3f9781c81aa23cde1a2	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
08d0b9d9bb1c0f283898a3bd	a027f3f9781c81aa23cde1a2	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5629c6fdac9e626a8617e5ed	a027f3f9781c81aa23cde1a2	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
29a058d353057ee759870b70	a027f3f9781c81aa23cde1a2	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5c0d36d996d0289a22a1fb93	a027f3f9781c81aa23cde1a2	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a48cf33f9cecc697d31f9d46	a027f3f9781c81aa23cde1a2	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8ca49151a3c13e9e77b66639	a027f3f9781c81aa23cde1a2	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
46d0b64fc4c8ee5b03b70cf3	a027f3f9781c81aa23cde1a2	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
23af05428eb3a632618d35b6	a027f3f9781c81aa23cde1a2	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f598eb92fef26f6057176fd7	a027f3f9781c81aa23cde1a2	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7b3d5e6826430cac7ad1f40d	a027f3f9781c81aa23cde1a2	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
266b57798594813c879a8344	a027f3f9781c81aa23cde1a2	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
39d7c1adb340ee88156e466c	a027f3f9781c81aa23cde1a2	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0eb21252a0ad33c62e15d4e9	a027f3f9781c81aa23cde1a2	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6b105ccbc6a1ed9c9b4a617a	a027f3f9781c81aa23cde1a2	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
be3ecc8930253d6dbb07e489	a027f3f9781c81aa23cde1a2	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
089799770aa8b0ac6663768b	a027f3f9781c81aa23cde1a2	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e63ee39a79dbe4b6d5f44383	a027f3f9781c81aa23cde1a2	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1b601e13076f9943219e4ebe	a027f3f9781c81aa23cde1a2	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e4d4b55a6e52dbfdaa090a95	a027f3f9781c81aa23cde1a2	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
32943658bc261d9746b0b3cc	a027f3f9781c81aa23cde1a2	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
94bcf1c079acac4ca831dd13	a027f3f9781c81aa23cde1a2	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dc941cf46e2f4987ebab7534	a027f3f9781c81aa23cde1a2	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
71bd8ee330170b3101a51e7a	a027f3f9781c81aa23cde1a2	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f1c961d72573dc33fba7a67c	a027f3f9781c81aa23cde1a2	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b55965e0e9f3e0d81e266422	a027f3f9781c81aa23cde1a2	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
85e285b3a3d60c017d35196b	ac21bc09cabf3e4524499f21	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f43451d3b9e1028c1e3b633d	ac21bc09cabf3e4524499f21	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
20fd5b80ecd17ccfc793f4db	ac21bc09cabf3e4524499f21	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fb8940b1cb656347c25dece0	ac21bc09cabf3e4524499f21	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fa18b6ece29db4980cc57443	ac21bc09cabf3e4524499f21	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
96fca8c19fb5493e01874c73	ac21bc09cabf3e4524499f21	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ffa19d55b271ac2e9cbb95e5	ac21bc09cabf3e4524499f21	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a4e1878416652705de657346	ac21bc09cabf3e4524499f21	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a1acaaca28c4ac3c77ce480d	ac21bc09cabf3e4524499f21	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ddfe33d79e019967b66b90f5	ac21bc09cabf3e4524499f21	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8caccf069041ab0d0d580266	ac21bc09cabf3e4524499f21	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
80ff55561641dd2eabd41fb5	ac21bc09cabf3e4524499f21	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6b91b4cbbf435df6f51d13bd	ac21bc09cabf3e4524499f21	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
be8b50ae6312f7513c7040bb	ac21bc09cabf3e4524499f21	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fdb3d3e6a3cdefdcb6d42f99	ac21bc09cabf3e4524499f21	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2c8e2e1dd59ae0bb211ea546	ac21bc09cabf3e4524499f21	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ca9c14c2a09a930563b06dab	ac21bc09cabf3e4524499f21	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
49fcf583a26c36034d60396e	ac21bc09cabf3e4524499f21	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8aca162fdaf783a4e126679b	ac21bc09cabf3e4524499f21	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
479fdb24487d00ddacd352bd	ac21bc09cabf3e4524499f21	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d6bf207fbf011bdefe1a51d6	ac21bc09cabf3e4524499f21	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d27050f8831acecf8c8bc86c	ac21bc09cabf3e4524499f21	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c61247e05385cdad44d0d0ec	ac21bc09cabf3e4524499f21	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d8cd41d1f431baadc0945c3a	ac21bc09cabf3e4524499f21	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
60966f6e4251c2801ffa88fc	ac21bc09cabf3e4524499f21	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
db69fb3ec16132256f1b403b	ac21bc09cabf3e4524499f21	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0fb181bf43660c3b273dc261	ac21bc09cabf3e4524499f21	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fe2cf06d9b1dd516a311f5ba	ac21bc09cabf3e4524499f21	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8c5ca24f6e50d9a4e4fd8ad2	ac21bc09cabf3e4524499f21	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c5d08188a4ae304b35276583	ac21bc09cabf3e4524499f21	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4a7d6adf143ff0d326e5d166	94376abf17118888318655ee	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
30d4365ba05c57ab1d870c89	94376abf17118888318655ee	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ad493a8785729769b7d61cca	94376abf17118888318655ee	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
93f2233b9d4b05756d2686e5	94376abf17118888318655ee	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
95c7c40369748ccfd71961e1	94376abf17118888318655ee	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
09e38c8e2cf3e9f26238478b	94376abf17118888318655ee	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
421c3b51d6c24a38a17ad885	94376abf17118888318655ee	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ba32361b1d38b849e1c4f2b5	94376abf17118888318655ee	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3e02f7df985203818f218d1a	94376abf17118888318655ee	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
864e74376bafc6aff438e32b	94376abf17118888318655ee	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b2880df4582434e791d1ab67	94376abf17118888318655ee	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ba6008833580b4d7125426b4	94376abf17118888318655ee	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6de546b50ba416f3deca6c20	94376abf17118888318655ee	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
22067be04869bdf7de0729c1	94376abf17118888318655ee	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
57bddd39299440e956d695d2	94376abf17118888318655ee	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
85398f33b115fded18397203	94376abf17118888318655ee	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8630834c8a75fc695499758c	94376abf17118888318655ee	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7729df2b06d98ad9e60870fb	94376abf17118888318655ee	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
392047d667bbed0978ad873c	94376abf17118888318655ee	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2069293720f3f00fbbbea11c	94376abf17118888318655ee	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1bc90e5b069c665dbea359e6	94376abf17118888318655ee	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a154831453cc08841d5f8dde	94376abf17118888318655ee	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0f1f71683f4e13b53fcb0a46	94376abf17118888318655ee	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
28d1cc29078cb3157340d605	94376abf17118888318655ee	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ad218febff491c0b4422be50	94376abf17118888318655ee	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0b5501e01018b4ab6b6cbfbc	94376abf17118888318655ee	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b236094563a67334f0d96641	94376abf17118888318655ee	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6d1464eb41baf0c21cacb234	94376abf17118888318655ee	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0fb8710bd24bf993cba9d2fa	94376abf17118888318655ee	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2fbeb4603ffcdf6115435b50	94376abf17118888318655ee	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
015c4dbc37cd83a03dd045c2	005485d041fff18bf989d8ad	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
245a9bfacdb42bee89ee6f32	005485d041fff18bf989d8ad	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4bf0ba5967691946bf8cbc0c	005485d041fff18bf989d8ad	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1bf33f884a8ea92455657f52	005485d041fff18bf989d8ad	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0112cb7a00090c50ac8f7778	005485d041fff18bf989d8ad	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bd22141b44fd70872d9699cd	005485d041fff18bf989d8ad	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cb2c1560383f255e0225f8d6	005485d041fff18bf989d8ad	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a8fbf7083601bac28c8893f6	005485d041fff18bf989d8ad	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
852523cf96ea2e876f36d986	005485d041fff18bf989d8ad	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f30132ca025abfec7fd3815d	005485d041fff18bf989d8ad	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
77ac4b7c477ca466a83653b9	005485d041fff18bf989d8ad	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ce8d4dac40729161685b33ba	005485d041fff18bf989d8ad	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
375ef3ca9d0c54cebf82efa6	005485d041fff18bf989d8ad	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fe5914ebbacf3f3ea2ed6b91	005485d041fff18bf989d8ad	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0662061add7054fd62059f1f	005485d041fff18bf989d8ad	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cc7d4a091fb6cf1c538fd64e	005485d041fff18bf989d8ad	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dbcce1013011f5fa9377c44e	005485d041fff18bf989d8ad	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b07e8e2ed00a378446d84a04	005485d041fff18bf989d8ad	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9370793334e80f908ff81d8a	005485d041fff18bf989d8ad	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cd420ad0555840801999f5ab	005485d041fff18bf989d8ad	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
62fda18e973a6b054f21f622	005485d041fff18bf989d8ad	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
08697452298919d35b249ad8	005485d041fff18bf989d8ad	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3b3f11d81893df851203f269	005485d041fff18bf989d8ad	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6997fc90903bc2d0cf8b3c31	005485d041fff18bf989d8ad	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5115af0152b923d2a908f5e2	005485d041fff18bf989d8ad	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
68f76abe2aab8da4f77a7f1d	005485d041fff18bf989d8ad	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b0c6f609778df8322611028f	005485d041fff18bf989d8ad	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ca037d82ddeb786200890b35	005485d041fff18bf989d8ad	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
428e8bf416a618f155513768	005485d041fff18bf989d8ad	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1761f0f2b91f105bec15aba4	005485d041fff18bf989d8ad	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
78121cd2efebdd928fbd7207	63a54b4f76f8997b6875ae11	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
546bb136c590fab86cc584fa	63a54b4f76f8997b6875ae11	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
38eb44058a0c3ee12d43cf66	63a54b4f76f8997b6875ae11	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bb5f9b68b00e8fd832d5d1e7	63a54b4f76f8997b6875ae11	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cdb49a45ca5bf1f5c653efde	63a54b4f76f8997b6875ae11	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e50baca8ca9c58dc6127d58f	63a54b4f76f8997b6875ae11	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fee9cd62ffbe667b7f1118d9	63a54b4f76f8997b6875ae11	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fc26d94e10f875870b4ecabc	63a54b4f76f8997b6875ae11	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dac1aa21b2969d491f71e185	63a54b4f76f8997b6875ae11	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
06004cbf470706440d59c4d0	63a54b4f76f8997b6875ae11	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e50d018bcb725277aaf75642	63a54b4f76f8997b6875ae11	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
58c3f10793e04c0f6f21a75d	63a54b4f76f8997b6875ae11	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1fb29e6c800820d24f96052a	63a54b4f76f8997b6875ae11	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e1931f9ae33bb094a1f38c3d	63a54b4f76f8997b6875ae11	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
56da7e051e9a598d7b907f33	63a54b4f76f8997b6875ae11	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e3c37f4fe1a39a700fe3a50e	63a54b4f76f8997b6875ae11	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5e683e9e5544c9c39f181fbc	63a54b4f76f8997b6875ae11	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
94c258bcef337d1128980293	63a54b4f76f8997b6875ae11	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
366cff367a6f56166e08c0d3	63a54b4f76f8997b6875ae11	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c6a8ece7a8a0cf24d9b67c2f	63a54b4f76f8997b6875ae11	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9c2a5ff5f61b23caca5c299b	63a54b4f76f8997b6875ae11	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d811cb5f3bf518e1d0115af0	63a54b4f76f8997b6875ae11	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
77fee2b4581db061e616696c	63a54b4f76f8997b6875ae11	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ce61810075b32340b4028c1d	63a54b4f76f8997b6875ae11	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8a343e519fe44b85cdccb2f1	63a54b4f76f8997b6875ae11	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
023c9ca1e7fa8c74841ad5b0	63a54b4f76f8997b6875ae11	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
de85c9ff267b15a0ec0f8620	63a54b4f76f8997b6875ae11	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ce979b6864134ada8556d66d	63a54b4f76f8997b6875ae11	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
77d76a7b7dff58070fb88d15	63a54b4f76f8997b6875ae11	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0eaba6e81d26b166be71c3ae	63a54b4f76f8997b6875ae11	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
307f0159c82780667be5ecb1	da53bc3629e9f9c8803332e5	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8b66490f156ba57a30850371	da53bc3629e9f9c8803332e5	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
16d0cef0415666e08e1d6b2b	da53bc3629e9f9c8803332e5	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
58951c13e6b9e76a712ad78f	da53bc3629e9f9c8803332e5	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
df397299a9c488cafbfb40d2	da53bc3629e9f9c8803332e5	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1619392b21f23fc54500bdb9	da53bc3629e9f9c8803332e5	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
16132a9c426ca86efc3507e8	da53bc3629e9f9c8803332e5	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6b038ec745f106831b7f019c	da53bc3629e9f9c8803332e5	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
88a044e44d1faeb5b33e5127	da53bc3629e9f9c8803332e5	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bc6b9f4a309907deae47cc6d	da53bc3629e9f9c8803332e5	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ec3522db6f6c25772c5ce438	da53bc3629e9f9c8803332e5	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
25c452bc59b65f08fa0e11f4	da53bc3629e9f9c8803332e5	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4e9319ec8d101cd4cb5b7101	da53bc3629e9f9c8803332e5	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
618f81301872f1feda5d22df	da53bc3629e9f9c8803332e5	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
49acdf4ddf7a1818775c6e6f	da53bc3629e9f9c8803332e5	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cac3c194bf4cb444ba5653c2	da53bc3629e9f9c8803332e5	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9fbe38caf41b9288264a3bcf	da53bc3629e9f9c8803332e5	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1e58266ff79e20a917fef22f	da53bc3629e9f9c8803332e5	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
37cf7404120af03992728b1c	da53bc3629e9f9c8803332e5	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0be90c7966180edc35fb919a	da53bc3629e9f9c8803332e5	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b235d211919c658735b5888b	da53bc3629e9f9c8803332e5	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
13cb315c692ce139c825f95d	da53bc3629e9f9c8803332e5	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
42fde918eb90fe32e1d07d98	da53bc3629e9f9c8803332e5	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e8e31a576fea90e84bbf3a08	da53bc3629e9f9c8803332e5	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9b7f66927b42567fb3afabab	da53bc3629e9f9c8803332e5	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c4ae04f26d3eaa8d1524cf00	da53bc3629e9f9c8803332e5	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
33e73ec53cb39793bb1fb021	da53bc3629e9f9c8803332e5	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3ab6a6c9661ea55347f9a374	da53bc3629e9f9c8803332e5	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ea0053bc7896155d71e738b0	da53bc3629e9f9c8803332e5	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
13b7703b98f10ace8187482e	da53bc3629e9f9c8803332e5	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
23ea87e05c14486a3fcefde2	baee7cc06393927d525d67f6	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1ca3607da65d1d8bd402bec1	baee7cc06393927d525d67f6	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
99d36d505a83ebc8628440b8	baee7cc06393927d525d67f6	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e7f802836367bae7156c8447	baee7cc06393927d525d67f6	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d39be53a625ce59c4a142bc6	baee7cc06393927d525d67f6	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
58977c8ca0f1e703bb0ef20b	baee7cc06393927d525d67f6	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
121367f97412307bae601a24	baee7cc06393927d525d67f6	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
428cf3ba8af8cf6f08909fe5	baee7cc06393927d525d67f6	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3e839050d69a4cb8705703dd	baee7cc06393927d525d67f6	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f97b9f77b2f6335e137ed248	baee7cc06393927d525d67f6	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
61a4ad32a2ada2e5243d08b6	baee7cc06393927d525d67f6	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
993f31b0c7d516070593fcd0	baee7cc06393927d525d67f6	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
054e120fadc7f77eb8ba7f62	baee7cc06393927d525d67f6	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f5b20ea9823a73b2796674d2	baee7cc06393927d525d67f6	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6fca5e6b202f6221f64ba5dc	baee7cc06393927d525d67f6	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
17cc5da3e341d257198eda73	baee7cc06393927d525d67f6	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
46aabe45b5986407e19e98ef	baee7cc06393927d525d67f6	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d289050fe5e7b50057e63c69	baee7cc06393927d525d67f6	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
768c75a3c31f1b24e1c819b2	baee7cc06393927d525d67f6	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f17671e4312f524ff5d09584	baee7cc06393927d525d67f6	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
edae7c8a5ccfa1af804188ca	baee7cc06393927d525d67f6	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
97af33d519f01830cf6cd826	baee7cc06393927d525d67f6	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d1c070dc9de65751ca666648	baee7cc06393927d525d67f6	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dbd9af20b4a843cd00860a9e	baee7cc06393927d525d67f6	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
62f3ba494af389c3f7f02b3c	baee7cc06393927d525d67f6	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f54cfda26cf075793645809c	baee7cc06393927d525d67f6	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a1d3575e71aa65e066485160	baee7cc06393927d525d67f6	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f862a58723e9ecc2c5fcad41	baee7cc06393927d525d67f6	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
93a6864dbf420e9d658ca21c	baee7cc06393927d525d67f6	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
00dfb95a66d7f7e670ef87bd	baee7cc06393927d525d67f6	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ffbeba07efed5a3775f24196	3d2b3c42be684eba0fb2232f	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
85ebe85097ae961c015e2782	3d2b3c42be684eba0fb2232f	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
aa07b17d9d5708deb06d9569	3d2b3c42be684eba0fb2232f	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f72631756545b8a7780ed56b	3d2b3c42be684eba0fb2232f	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b12d922472e3c15f0f69bb39	3d2b3c42be684eba0fb2232f	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ecd828c1ba1e24cef8459b17	3d2b3c42be684eba0fb2232f	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dea261db1ee3c985d71bb020	3d2b3c42be684eba0fb2232f	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
08c482ac0a22e0dec7ff640c	3d2b3c42be684eba0fb2232f	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dcfa65b3f84787b8ec246df7	3d2b3c42be684eba0fb2232f	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
04193c93a37ff07b2f0db515	3d2b3c42be684eba0fb2232f	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e6500e86c5ec05f2566bb0a5	3d2b3c42be684eba0fb2232f	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c3914e52aa0c810b0bf99f7f	3d2b3c42be684eba0fb2232f	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9efd9c14ddcddb98faac29cf	3d2b3c42be684eba0fb2232f	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d9f998ea2f570ee8de548d90	3d2b3c42be684eba0fb2232f	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7f948e01c03227d472e80ec5	3d2b3c42be684eba0fb2232f	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
eb7f7e5522b617ac6a60c5cb	3d2b3c42be684eba0fb2232f	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
901db83e68acb54b683b97ff	3d2b3c42be684eba0fb2232f	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a10087ab022532b489b3e897	3d2b3c42be684eba0fb2232f	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c9baedac8212bd378af7f092	3d2b3c42be684eba0fb2232f	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c1a3aa98bf585f0c02695d4a	3d2b3c42be684eba0fb2232f	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e15d2542119f0523d191bb43	3d2b3c42be684eba0fb2232f	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6b2d7578faa75e0f8852bfb1	3d2b3c42be684eba0fb2232f	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cf5da0441d2faa3f49ff031a	3d2b3c42be684eba0fb2232f	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ccd8e3a64ffea6708658756d	3d2b3c42be684eba0fb2232f	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
37b52fdbc328b6ec3f2bbcb3	3d2b3c42be684eba0fb2232f	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7fbbc7606748aa9872df9f7d	3d2b3c42be684eba0fb2232f	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2498cd7e0283b12046418bf3	3d2b3c42be684eba0fb2232f	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8469dc681f72264c01441fc5	3d2b3c42be684eba0fb2232f	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
72ea23e5fd64ce2b3107fd49	3d2b3c42be684eba0fb2232f	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
858d3bbd1886f0e8e9ee0857	3d2b3c42be684eba0fb2232f	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0573acf70b05414508d997fe	d0a6263e56e5f052cb12b33f	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
57796d13f8d482d924507dd5	d0a6263e56e5f052cb12b33f	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
63a47541ed8645b37fb1153f	d0a6263e56e5f052cb12b33f	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e56620556334844d6e0a1ef2	d0a6263e56e5f052cb12b33f	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
32fd3a72609e9d577dcd85f9	d0a6263e56e5f052cb12b33f	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
82ce95812b3a7f5ee43a8f5a	d0a6263e56e5f052cb12b33f	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fe39d3eea13e1a7ad4fb538a	d0a6263e56e5f052cb12b33f	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d33734f6141e9800104c917c	d0a6263e56e5f052cb12b33f	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cb2291ec7cc6db8dcd9e651c	d0a6263e56e5f052cb12b33f	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
06f4fd282457dd50dd0452a4	d0a6263e56e5f052cb12b33f	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bb86c97571f456d65f46f824	d0a6263e56e5f052cb12b33f	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b4c57bb189099958f7f0d331	d0a6263e56e5f052cb12b33f	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
39bc87ef7eec5ef8482127ed	d0a6263e56e5f052cb12b33f	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
80a9224e19ae978c339e2567	d0a6263e56e5f052cb12b33f	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6a3d8ece83b10f74d15961b8	d0a6263e56e5f052cb12b33f	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
002a887bd50c8606b30c7865	d0a6263e56e5f052cb12b33f	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fb937de83ec58dbeab383a86	d0a6263e56e5f052cb12b33f	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fb824ae3f7ea46992c5594bc	d0a6263e56e5f052cb12b33f	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3d3c01e57e49672d62e21120	d0a6263e56e5f052cb12b33f	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3905ad2f7918bc042ace74f3	d0a6263e56e5f052cb12b33f	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5f7c636d9bc40efff8db9851	d0a6263e56e5f052cb12b33f	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cd12b4e2cfd71cf3873a71e7	d0a6263e56e5f052cb12b33f	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
373c1b2fe205e3b411280d93	d0a6263e56e5f052cb12b33f	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e214088382ef8bb954f3d8db	d0a6263e56e5f052cb12b33f	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0b4f3b39b56c1a3a64905d35	d0a6263e56e5f052cb12b33f	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
234c343625f5ef86d5cfb1f3	d0a6263e56e5f052cb12b33f	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c414268ff28960dd1ed1656a	d0a6263e56e5f052cb12b33f	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ba50f98ad457e768838d5b97	d0a6263e56e5f052cb12b33f	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e0ba12060feb82557922a025	d0a6263e56e5f052cb12b33f	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
34c2fbd2a67ca16fe36d2cfb	d0a6263e56e5f052cb12b33f	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2f3782b0cd07d89c7fd7a383	b761720b1572afcc60701676	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
73e2c4b23765ade3f500c096	b761720b1572afcc60701676	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8f10070312684e9f03499316	b761720b1572afcc60701676	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
677f978b0b2a8f31adaf8cae	b761720b1572afcc60701676	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
706b77b1608912613b4bc1c3	b761720b1572afcc60701676	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dc2f727c3af4aaf8aa755d35	b761720b1572afcc60701676	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3e7f00901dcefe3d6e50015a	b761720b1572afcc60701676	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
beccf8ff36272e05df3097f6	b761720b1572afcc60701676	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
94c5593c3ede5502b89dcb29	b761720b1572afcc60701676	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b7ca11a92ad2e07ca0b164f5	b761720b1572afcc60701676	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
48504de3a21ff913c9d1d6a5	b761720b1572afcc60701676	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a184ade33d884cb7cb63c157	b761720b1572afcc60701676	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
df798961e0dbb696fd8f29bc	b761720b1572afcc60701676	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
99b6109fc9660a3e60aeda3a	b761720b1572afcc60701676	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f9cb5055b3cd9285053805b5	b761720b1572afcc60701676	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
97c80a9033b96a5c54a6b3a6	b761720b1572afcc60701676	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0d7cb40c44a5071e4aa5f6f9	b761720b1572afcc60701676	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f789b4091cb68df1dd874337	b761720b1572afcc60701676	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
93f938bf795f2bf01bc46461	b761720b1572afcc60701676	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
696f7b56bcd0ec7a5b71adff	b761720b1572afcc60701676	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9428530a0c38aaabf86ab410	b761720b1572afcc60701676	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0f9a549a4e89892cc3f68269	b761720b1572afcc60701676	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ea247ed61c008b22fcb8246f	b761720b1572afcc60701676	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
91d888d39e87addc532414c2	b761720b1572afcc60701676	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
becc78b6022f39cb112bcf62	b761720b1572afcc60701676	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dc5326e28f04f7852abba879	b761720b1572afcc60701676	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
69e5087226c4ef87f5e647c7	b761720b1572afcc60701676	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
de7a49f56900d09d1f742860	b761720b1572afcc60701676	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c427ad920567f841ee5f2fae	b761720b1572afcc60701676	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a9923f6c5132fd457e71fe68	b761720b1572afcc60701676	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c6a977c55f021dacb8ddf913	fc15c07b5ab015faa668bbde	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ccb0661d7b919d8abd0625a4	fc15c07b5ab015faa668bbde	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b15e138f7a73a132525217d5	fc15c07b5ab015faa668bbde	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8ae1cebcd50e0e9b0b4c8744	fc15c07b5ab015faa668bbde	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6a9c5afdba393ae2ce0f3cd5	fc15c07b5ab015faa668bbde	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fff7daf0d12086af805d8439	fc15c07b5ab015faa668bbde	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a68f93132d328eb64e4924a3	fc15c07b5ab015faa668bbde	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6ee6d1bdcf3b349d3186aaba	fc15c07b5ab015faa668bbde	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1e9179e9488f80f60b5aede4	fc15c07b5ab015faa668bbde	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7b88a09c2687097136e85455	fc15c07b5ab015faa668bbde	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
46ae96f4134abbe7b0081858	fc15c07b5ab015faa668bbde	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a917e26c3cad27e1aee8b643	fc15c07b5ab015faa668bbde	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
19266df7528134a1b7eeb2b3	fc15c07b5ab015faa668bbde	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
92b46d0039218e33f6ec862b	fc15c07b5ab015faa668bbde	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
45773a6e2df5ca29ecfd5f28	fc15c07b5ab015faa668bbde	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
078bf7c1a60855118243a6c5	fc15c07b5ab015faa668bbde	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0b1f64d4d2b0ca914b898e1b	fc15c07b5ab015faa668bbde	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7b7a13acea275185cb213329	fc15c07b5ab015faa668bbde	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
461be9ca056a7385ea65c089	fc15c07b5ab015faa668bbde	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bd63a2117aa7c65755757cfe	fc15c07b5ab015faa668bbde	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
df8c6c0e3a156c408ebda1d9	fc15c07b5ab015faa668bbde	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b8900f257fd7f75b06feafd7	fc15c07b5ab015faa668bbde	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5dd7f7140fece9633eb346b7	fc15c07b5ab015faa668bbde	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f3bf2f7d8364243bcd2b4dc5	fc15c07b5ab015faa668bbde	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
483075caf0b67978633f746e	fc15c07b5ab015faa668bbde	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3d2de79e47c58d64d6291451	fc15c07b5ab015faa668bbde	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b3ee680df96afa0e2e1c3590	fc15c07b5ab015faa668bbde	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c680297941adb34956534738	fc15c07b5ab015faa668bbde	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
608fce716c2bfc997b6c2435	fc15c07b5ab015faa668bbde	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
116e85965a007927fa265d66	fc15c07b5ab015faa668bbde	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4bae6709a97c7d79a0a8d6dd	792dcb7d39f8217bf113bb35	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dbf4e1fd4e2a5fabf1cf4bf8	792dcb7d39f8217bf113bb35	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4e91b21661c5296a6957a1cd	792dcb7d39f8217bf113bb35	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
01e6189be5a9e418de47fb39	792dcb7d39f8217bf113bb35	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9f907b382fe7a372c86be893	792dcb7d39f8217bf113bb35	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
677c7469dde71bf78c53c65c	792dcb7d39f8217bf113bb35	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
eaff3ea28e201a98c928b062	792dcb7d39f8217bf113bb35	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
257b8f1aa881cf1fe972c227	792dcb7d39f8217bf113bb35	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
732c2e878e7465ee2272349e	792dcb7d39f8217bf113bb35	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
32c2dcfaf9297ba7010e5a4b	792dcb7d39f8217bf113bb35	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0767fe2dc53e0ec4c8857c3f	792dcb7d39f8217bf113bb35	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
70e95f7f2c57bcfeb37de862	792dcb7d39f8217bf113bb35	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e69031068d1b60597a86e8d1	792dcb7d39f8217bf113bb35	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
62516cbd1b496569f6042137	792dcb7d39f8217bf113bb35	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3e0fcbeb129515bcbeb1f2b5	792dcb7d39f8217bf113bb35	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d1a267721ee545c495d37fbc	792dcb7d39f8217bf113bb35	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3c9092bcb9cbac30bada6850	792dcb7d39f8217bf113bb35	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8070f178f0a177a6074d7c79	792dcb7d39f8217bf113bb35	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2f798bf24f6053b4823edafd	792dcb7d39f8217bf113bb35	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5b2401dec59c6f444c1570c4	792dcb7d39f8217bf113bb35	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f4478d6fd324157006a47908	792dcb7d39f8217bf113bb35	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7f760d942aacb528b66fbba4	792dcb7d39f8217bf113bb35	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6bf9da9c59d3ad172d04df70	792dcb7d39f8217bf113bb35	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
407d7cd0d68d617530c77d55	792dcb7d39f8217bf113bb35	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7d5181c52a3184c14a518fa6	792dcb7d39f8217bf113bb35	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
057b47a147bd60b3350c70f2	792dcb7d39f8217bf113bb35	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cc0d75e6c3eeb61f502e574e	792dcb7d39f8217bf113bb35	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
11e8336b679d7605161167a1	792dcb7d39f8217bf113bb35	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
528ca9166b4e4d128098617a	792dcb7d39f8217bf113bb35	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
98d7a2c057d45be715267eb6	792dcb7d39f8217bf113bb35	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
719879d30ca19afe06b2ea77	06d2e750cd05df2906447617	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
22b8cf499cd33cb16260f114	06d2e750cd05df2906447617	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fa2582827f60ab8184838272	06d2e750cd05df2906447617	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c1eb6820f8c536611a57ccf0	06d2e750cd05df2906447617	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
33d2f4a0b8299c160d2abbae	06d2e750cd05df2906447617	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
99f54ce1b5c73eaa36b8a904	06d2e750cd05df2906447617	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7b519afa259463b52f943c74	06d2e750cd05df2906447617	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f7386c8cd8649d6bdd2f5841	06d2e750cd05df2906447617	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
60ed408bf4b981189e5cb33d	06d2e750cd05df2906447617	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6c8fdc7921253f88cb2becec	06d2e750cd05df2906447617	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8ba4b3690e941acdd4a22789	06d2e750cd05df2906447617	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5ab8328c008e5940fda9ef17	06d2e750cd05df2906447617	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3d7ad818b35ded29e64555dc	06d2e750cd05df2906447617	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b38d6f680f3fc04ecc1b1c48	06d2e750cd05df2906447617	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
78b3c76091724cc272b56334	06d2e750cd05df2906447617	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a4da688eff4c5391570f177a	06d2e750cd05df2906447617	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
883052b31efcd13b0fc650db	06d2e750cd05df2906447617	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9a8cca5308166d0f8b468fa8	06d2e750cd05df2906447617	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0b47c947a88d324f586569a2	06d2e750cd05df2906447617	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7a5bcca0e3dfc8f15e625a36	06d2e750cd05df2906447617	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6afe71abae451501792496be	06d2e750cd05df2906447617	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
662d781f7bcb310940ef9e9b	06d2e750cd05df2906447617	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2700426a17902103ce4965bb	06d2e750cd05df2906447617	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8c8a107cd17d5eb8d9c71774	06d2e750cd05df2906447617	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3b6ed2caacabbb0125ce73e3	06d2e750cd05df2906447617	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1ca93d5c136ce7d58b13ade0	06d2e750cd05df2906447617	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
08b8e2b2de9945ec40d6f514	06d2e750cd05df2906447617	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9dc4baf2c9b634a731bfd68f	06d2e750cd05df2906447617	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5728115c428ad245faeb8bf9	06d2e750cd05df2906447617	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a3aa79d3c7b79e398058bf15	06d2e750cd05df2906447617	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dbe9abc9878d5fcec24f8a0c	f029e06fa00b52dc81e8ff92	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
64ca9840ae42d5f0e74b7cd6	f029e06fa00b52dc81e8ff92	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
93d9afdab9e5b402f1b5c463	f029e06fa00b52dc81e8ff92	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2c9e572c567c52446f5e6abd	f029e06fa00b52dc81e8ff92	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
da928731d51e4a5f19749b71	f029e06fa00b52dc81e8ff92	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ef3f6e646eb4f9bbca6a2ca4	f029e06fa00b52dc81e8ff92	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4a185d0a59f3d4ef9a9492e4	f029e06fa00b52dc81e8ff92	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f72ffe7eed99cdb8f30109e9	f029e06fa00b52dc81e8ff92	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9fd78f17945aa15e0fedcddb	f029e06fa00b52dc81e8ff92	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a4e5608a19b7dcf9fb86e428	f029e06fa00b52dc81e8ff92	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4150bc710cced77172d8b5a4	f029e06fa00b52dc81e8ff92	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
beeb10b32efda28766e1473a	f029e06fa00b52dc81e8ff92	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
94e89b3a169fd2122b6c7f83	f029e06fa00b52dc81e8ff92	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d459054c31c5b9ca1896325e	f029e06fa00b52dc81e8ff92	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4275b12a98d7088ce7e4ed4d	f029e06fa00b52dc81e8ff92	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5e274e8e6c27e630e22a48b4	f029e06fa00b52dc81e8ff92	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
672d8333eec49e5c81c5d617	f029e06fa00b52dc81e8ff92	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
32342c766982ebb5aea97047	f029e06fa00b52dc81e8ff92	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8a28c135df46a2902b4c2d4d	f029e06fa00b52dc81e8ff92	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d390f8e008b76f70c2e0e056	f029e06fa00b52dc81e8ff92	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
24ed4760660422f85f4d1e38	f029e06fa00b52dc81e8ff92	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7e87f4530c42da3fcb4691ea	f029e06fa00b52dc81e8ff92	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
70fbddd8e8329de3f3095ff2	f029e06fa00b52dc81e8ff92	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
68436797687fd28c4e0b7f1a	f029e06fa00b52dc81e8ff92	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
01dbbf8bdc0c02aef18bdb1e	f029e06fa00b52dc81e8ff92	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fdb624a44f1fdce41f3a05d3	f029e06fa00b52dc81e8ff92	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6e240a81849de0443f5cc962	f029e06fa00b52dc81e8ff92	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
36e1a1dcb69f8f1111db5705	f029e06fa00b52dc81e8ff92	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6c9caf4b2f760dacb8cc3f03	f029e06fa00b52dc81e8ff92	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
53642def4d8bc8ca1f3dace7	f029e06fa00b52dc81e8ff92	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d3cc88f23ee2bb8ce55780ce	f8a3c918aa67340ebc465017	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e7334b5235c0e639d2c6a91d	f8a3c918aa67340ebc465017	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
28e0ab26e6dab528398e0d3d	f8a3c918aa67340ebc465017	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b8ceb2e7b0e3e0a0e56a90bc	f8a3c918aa67340ebc465017	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
89f79c57323af08b22f1fc1f	f8a3c918aa67340ebc465017	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
483695661dd923563c7eeb6a	f8a3c918aa67340ebc465017	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
001604118379b970b97eea48	f8a3c918aa67340ebc465017	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1ddcb3d011a84671be119a54	f8a3c918aa67340ebc465017	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
944f13945fd137a8bcb60dd9	f8a3c918aa67340ebc465017	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2e26efd2c928af3f28ee427f	f8a3c918aa67340ebc465017	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
22c0d52649faaacec8580d9f	f8a3c918aa67340ebc465017	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dcf0f0583b05129da2b01238	f8a3c918aa67340ebc465017	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
63ebc25e64d8b1ee1213e901	f8a3c918aa67340ebc465017	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
412d1c65961c33a9e0909eba	f8a3c918aa67340ebc465017	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
13c655a0370a39d4af7f96f1	f8a3c918aa67340ebc465017	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f9a668aebc14939fef8b5506	f8a3c918aa67340ebc465017	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e0657608fa47ad166054437e	f8a3c918aa67340ebc465017	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
70abfb89b34f002a2891642c	f8a3c918aa67340ebc465017	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a865f16ac836614305020e93	f8a3c918aa67340ebc465017	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b0b4f8f6674dc9636cfdab88	f8a3c918aa67340ebc465017	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1ac58796b719bae3d5045ef9	f8a3c918aa67340ebc465017	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2f2f5619f20f98553175960b	f8a3c918aa67340ebc465017	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6af7c7adb56657415db7d7ad	f8a3c918aa67340ebc465017	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
55d2622bab46d7db1893db2f	f8a3c918aa67340ebc465017	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3b7f633bdbbd9c44b56646f3	f8a3c918aa67340ebc465017	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
420dcefc1b06167979e9d25d	f8a3c918aa67340ebc465017	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0b6931e456825a5decf6aedf	f8a3c918aa67340ebc465017	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
383c536c1d29c90f02751bec	f8a3c918aa67340ebc465017	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
51bc5b16ef162c7623ba24dd	f8a3c918aa67340ebc465017	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a27104a5b73736cdfa79452f	f8a3c918aa67340ebc465017	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bac6cb9f74ab1a407364153d	bf65102ca6f45510aa005795	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b4dc8ee98635a0a25e87d84b	bf65102ca6f45510aa005795	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8d791ddedaefa600a1a0466a	bf65102ca6f45510aa005795	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
24786a6c11703293ee347138	bf65102ca6f45510aa005795	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
89b4df165bce4b3fa4caae49	bf65102ca6f45510aa005795	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d7605b7cd4f966b798a44b01	bf65102ca6f45510aa005795	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7e064b2e4c75f4fdbfe9ba74	bf65102ca6f45510aa005795	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a3254d01fe5b4acd3586dba8	bf65102ca6f45510aa005795	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
08bb919ea886ae8e1b51efa2	bf65102ca6f45510aa005795	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d815f3beb3acd29cfef0d540	bf65102ca6f45510aa005795	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0a4cedbb9ba9627583361f99	bf65102ca6f45510aa005795	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
387d5f7c0ea30f9120ffe327	bf65102ca6f45510aa005795	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f14b97fb905df8f808650f15	bf65102ca6f45510aa005795	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a72908fe2d4d8f7793bfdb67	bf65102ca6f45510aa005795	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bd7e678e0eb1e2ca49d40949	bf65102ca6f45510aa005795	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b1c70b21f9d4c8cc7c5a304a	bf65102ca6f45510aa005795	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e3925d9c49e003e4f71e2565	bf65102ca6f45510aa005795	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
45a734726a6bdeac54618068	bf65102ca6f45510aa005795	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
009a0ebbfc02e1194273c3ce	bf65102ca6f45510aa005795	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f33485d9395af71fe8847539	bf65102ca6f45510aa005795	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a91709b94152825f700cc32a	bf65102ca6f45510aa005795	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
66550ac2e3c3d3bdbec96e8a	bf65102ca6f45510aa005795	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5ca1f00d2de39866cf57b7c2	bf65102ca6f45510aa005795	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1183ef8b1c9eec8a00ac47e1	bf65102ca6f45510aa005795	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0850a2819c606cc5ceec1862	bf65102ca6f45510aa005795	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c8eea8c54fed87f84f089573	bf65102ca6f45510aa005795	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
eff7e7968f72f6aeebb3caf1	bf65102ca6f45510aa005795	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9ea3f6cb288412fb3b8a68c5	bf65102ca6f45510aa005795	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e8947b3e778e738b3880a59e	bf65102ca6f45510aa005795	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4cb45752af1f93db4a4104a6	bf65102ca6f45510aa005795	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
129328f7d586f2a36a336c19	11a8d02b3d98873356cfa1c4	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f3f9f5f9ec5a25754d98a6b1	11a8d02b3d98873356cfa1c4	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5445a4c2dea19f0f4c719c1c	11a8d02b3d98873356cfa1c4	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8c3086b5754c8997e34ed998	11a8d02b3d98873356cfa1c4	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2d5981b3a64ecfb538ee2dd0	11a8d02b3d98873356cfa1c4	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ab1377a0f905a3fa21f8f807	11a8d02b3d98873356cfa1c4	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1916b208e8e9da05e7f03cbc	11a8d02b3d98873356cfa1c4	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
174d58325a5d527c1fb67deb	11a8d02b3d98873356cfa1c4	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ab2930a63edbc98e297b4650	11a8d02b3d98873356cfa1c4	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ee4edfddfdded38e8ad1112e	11a8d02b3d98873356cfa1c4	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7fc16428d3adfd84f3c7bc74	11a8d02b3d98873356cfa1c4	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1d8e0927bf11e434251bd8bc	11a8d02b3d98873356cfa1c4	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6c288929f4d0f5f57d0c3e17	11a8d02b3d98873356cfa1c4	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
49df496a6c26d76f64586280	11a8d02b3d98873356cfa1c4	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c58f84b2ffed38c8ce4e0ce6	11a8d02b3d98873356cfa1c4	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a1b876f1132baf3b2c349894	11a8d02b3d98873356cfa1c4	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b4a902ef2fe85ba3a11a0d11	11a8d02b3d98873356cfa1c4	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5ec75358dbff799cd937e618	11a8d02b3d98873356cfa1c4	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c069a5c0322cf6526f2ee3d8	11a8d02b3d98873356cfa1c4	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
90d582f179191bb00fde3e84	11a8d02b3d98873356cfa1c4	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5ca123108212511e7a2d6398	11a8d02b3d98873356cfa1c4	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a8900e543f417f746b7a214c	11a8d02b3d98873356cfa1c4	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
60f17855fd44dca653620452	11a8d02b3d98873356cfa1c4	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4792713be5cfc8cf1b406de1	11a8d02b3d98873356cfa1c4	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cae3bf826fd61c242a7f93f2	11a8d02b3d98873356cfa1c4	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ba0772fbc0428279a1aa8c16	11a8d02b3d98873356cfa1c4	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5e47cd337a488937cdc1a9fc	11a8d02b3d98873356cfa1c4	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
13e6d1176e2e70e2c711b870	11a8d02b3d98873356cfa1c4	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cf1db8d5f513cf16d6691483	11a8d02b3d98873356cfa1c4	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bd6445729b9bcc5ad4aa16f8	11a8d02b3d98873356cfa1c4	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
58901bc29f37ccc2e46452c6	254425d723cc5cddc2867f11	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5a1d06a6603cc5cf783dd806	254425d723cc5cddc2867f11	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b7d5d8ffeedb9551ec850d5d	254425d723cc5cddc2867f11	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f77a5458aac0ef4a4fe012e0	254425d723cc5cddc2867f11	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6e7a584a5c671584eee3a9ed	254425d723cc5cddc2867f11	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
889a9e481dd5fd05bec8db99	254425d723cc5cddc2867f11	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1d3f792698c64b353e561523	254425d723cc5cddc2867f11	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4a1d10bdafe1481d302118a3	254425d723cc5cddc2867f11	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ddeea85dc36deca035622ea0	254425d723cc5cddc2867f11	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2890afb7f9b8be855c9d4f54	254425d723cc5cddc2867f11	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f04789c5a1c512a1c4ec9752	254425d723cc5cddc2867f11	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b8891d75e6ce8e14e0fbac31	254425d723cc5cddc2867f11	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fff22a30bb3df5cd096e1cda	254425d723cc5cddc2867f11	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d205ccbbad76a3e2f0f82d57	254425d723cc5cddc2867f11	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6bb99a4cfd7457d06edf5512	254425d723cc5cddc2867f11	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a5812d056488374f681856ef	254425d723cc5cddc2867f11	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
78d72df2e5dc0c2e66199551	254425d723cc5cddc2867f11	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dfeae8f87d9544df0aface4f	254425d723cc5cddc2867f11	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2ef8cf3d5ed7d54bb4e1f34d	254425d723cc5cddc2867f11	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
82bdf851c4062f0ca51bce98	254425d723cc5cddc2867f11	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cd54d1a0add52f0a68c0f54c	254425d723cc5cddc2867f11	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fcb84895aab4efa0a337b83d	254425d723cc5cddc2867f11	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1aa581d02920d27117b1d676	254425d723cc5cddc2867f11	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
906acae02c9be921b3936618	254425d723cc5cddc2867f11	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3bf37ad34eaf2c357117845b	254425d723cc5cddc2867f11	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
936d6a83f5feb1e05cbc8616	254425d723cc5cddc2867f11	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e3377326b75202f743841529	254425d723cc5cddc2867f11	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f50e30c1cba4075f2c4890f9	254425d723cc5cddc2867f11	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fb689fbb8306e1a14dbe67f9	254425d723cc5cddc2867f11	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f0c21a937e1d504819c9ceee	254425d723cc5cddc2867f11	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
12a34963b595a4fadab144df	796e488102d7e48fa7f5ce29	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3c6665f805769967817b7d17	796e488102d7e48fa7f5ce29	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
947bc1b88c4a4218d74b049d	796e488102d7e48fa7f5ce29	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
62779e17b7c963a532ea5c62	796e488102d7e48fa7f5ce29	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2f5b185b68c3d900bfbfd202	796e488102d7e48fa7f5ce29	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0ff9739d730180ecd130a4da	796e488102d7e48fa7f5ce29	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2550f9ba70ef28547b7711ed	796e488102d7e48fa7f5ce29	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0b51c23b5ba0917991e2587b	796e488102d7e48fa7f5ce29	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
881a7e8f8fb001758b9d682a	796e488102d7e48fa7f5ce29	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fe904ea582d6486620fd28eb	796e488102d7e48fa7f5ce29	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
239b0ee762cdb7f78ca32295	796e488102d7e48fa7f5ce29	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
920336e4579a6755f6bf76c7	796e488102d7e48fa7f5ce29	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
98eb6d90df79ff93153b5369	796e488102d7e48fa7f5ce29	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
814b2a977ce6a47dbd899d1b	796e488102d7e48fa7f5ce29	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9c7328c94ea014d5c4aa418a	796e488102d7e48fa7f5ce29	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6a3f9722519dfa9474d663bd	796e488102d7e48fa7f5ce29	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cbd1da4a7334dea6c74ed7bf	796e488102d7e48fa7f5ce29	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
91c0937b03f2bc7f6a95404a	796e488102d7e48fa7f5ce29	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
84a2539ac7fa200394c15e12	796e488102d7e48fa7f5ce29	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
116aadbcfd527bf2b9d901c5	796e488102d7e48fa7f5ce29	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8611407e5b9c891620fcde9b	796e488102d7e48fa7f5ce29	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e0119114e6dd109c28dc1024	796e488102d7e48fa7f5ce29	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7e689c9d7a2630dd7e6ce232	796e488102d7e48fa7f5ce29	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d67e60cccc6e9008cf1193d8	796e488102d7e48fa7f5ce29	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f45398f6150f71bfa7fffcdc	796e488102d7e48fa7f5ce29	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9ff76bb8c4836b38995e94e7	796e488102d7e48fa7f5ce29	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8f4dc3ea961f898b0f93cb03	796e488102d7e48fa7f5ce29	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
978d1cf0326d27e0aca4210a	796e488102d7e48fa7f5ce29	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3d178afe4ffc933e942f72fc	796e488102d7e48fa7f5ce29	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d813b929757914d7e21f35f8	796e488102d7e48fa7f5ce29	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5d32389533a596b6b530025d	ee035fe5e452171f13f6f523	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4f79bf46c1d6a45cd78fc290	ee035fe5e452171f13f6f523	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
22cc2cb4aa472e385983a4bd	ee035fe5e452171f13f6f523	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
38cbda8eda3764aa41599f13	ee035fe5e452171f13f6f523	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e661661e1e6c4a5bf916b3f5	ee035fe5e452171f13f6f523	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c3c523d59908cc72200d6754	ee035fe5e452171f13f6f523	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0cccab59d0508ede96a9b073	ee035fe5e452171f13f6f523	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7aa138f406feb7fdfe7d3c97	ee035fe5e452171f13f6f523	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c5c017a0e1b7eed4a5018fd0	ee035fe5e452171f13f6f523	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5536e5a1e7b980fa950d3fcc	ee035fe5e452171f13f6f523	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ef6f4c1440ba1406fa5a40ef	ee035fe5e452171f13f6f523	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4b31ca8907fed0ade2488e76	ee035fe5e452171f13f6f523	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ddbbb677fafdd6ddebc71c68	ee035fe5e452171f13f6f523	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9acb825844a013712ad5e49d	ee035fe5e452171f13f6f523	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6c06091558dbd323fa071b64	ee035fe5e452171f13f6f523	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dedfeb9f89fda114feeeea4d	ee035fe5e452171f13f6f523	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d84d069eb38b2300c24a966d	ee035fe5e452171f13f6f523	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3dcbdf90072e9c1eb123fc05	ee035fe5e452171f13f6f523	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
41e19588f1464ba771579968	ee035fe5e452171f13f6f523	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
528724da17cfabceb6a6a121	ee035fe5e452171f13f6f523	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e7d59632d4568e9d8c3cd130	ee035fe5e452171f13f6f523	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b03defd921da76e19f55d9a9	ee035fe5e452171f13f6f523	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fb06aaad1d9955078d9764b3	ee035fe5e452171f13f6f523	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
55202df4e3c6f155bf8599ac	ee035fe5e452171f13f6f523	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cb765a8215dc4e81d063d1a2	ee035fe5e452171f13f6f523	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ed6b10d42c7dc0938f218c93	ee035fe5e452171f13f6f523	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4ac9903a9e9e2edcc46cd240	ee035fe5e452171f13f6f523	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
75b6ad80ad40b2f027e1ca8e	ee035fe5e452171f13f6f523	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4f2ec9a2b1a302f3dc904ed0	ee035fe5e452171f13f6f523	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
29086909cabd47d4c3f8478f	ee035fe5e452171f13f6f523	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8a852f9855364020e29fc02e	8f1d543461fe08b3bf1f8dc0	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
86bd7f5eea5ad8aaf2913dc0	8f1d543461fe08b3bf1f8dc0	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
57d276e1f6e29b5d69fe50a2	8f1d543461fe08b3bf1f8dc0	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
75eedcb57eedbf4c6f1a6cb1	8f1d543461fe08b3bf1f8dc0	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6b7d7cf0f070fb33dd158e0b	8f1d543461fe08b3bf1f8dc0	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9e1a8f138bbf6d595e5b18a2	8f1d543461fe08b3bf1f8dc0	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5258018ac98bb10631123506	8f1d543461fe08b3bf1f8dc0	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e2f5af91862d314954f86b85	8f1d543461fe08b3bf1f8dc0	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
28cfaba2d27272cd787b6fa8	8f1d543461fe08b3bf1f8dc0	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a37e7b7a717c15f8e56294f1	8f1d543461fe08b3bf1f8dc0	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
46887d8f5dddaa7d5bcacd87	8f1d543461fe08b3bf1f8dc0	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bbabe8ed69797352a8b2af56	8f1d543461fe08b3bf1f8dc0	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5390a56f27d6f73aaf6f8e89	8f1d543461fe08b3bf1f8dc0	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
96023060c9ecdfb3e5d821fc	8f1d543461fe08b3bf1f8dc0	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b1763a3d4f3a3d0778916fdd	8f1d543461fe08b3bf1f8dc0	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4280ff806e450779a8449bfd	8f1d543461fe08b3bf1f8dc0	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a5be03057b3585ad3e5d9788	8f1d543461fe08b3bf1f8dc0	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
72668183746b9d4fb059a053	8f1d543461fe08b3bf1f8dc0	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7d1b4398fd7186c685a35a17	8f1d543461fe08b3bf1f8dc0	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
649c27a4de41148bcbfb8817	8f1d543461fe08b3bf1f8dc0	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
895be012589523f8651c5641	8f1d543461fe08b3bf1f8dc0	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4d6f250963a4e5ef330dc2f4	8f1d543461fe08b3bf1f8dc0	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
951453a62908644ae3cb8ba4	8f1d543461fe08b3bf1f8dc0	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
274ccb5df1ae36ce5f746b57	8f1d543461fe08b3bf1f8dc0	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f012a1d69fe72f40bc0dd313	8f1d543461fe08b3bf1f8dc0	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
820fb93e1d4696ce3b487837	8f1d543461fe08b3bf1f8dc0	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2ead41d2b84b4b41ce053310	8f1d543461fe08b3bf1f8dc0	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6953070356ef1943a2bd022d	8f1d543461fe08b3bf1f8dc0	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2151eacdb51d84c91159d946	8f1d543461fe08b3bf1f8dc0	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
59619c7a665b3532175f8fa2	8f1d543461fe08b3bf1f8dc0	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
89834daa0db005cbbaf5283f	f94b450bae7a78bc1b104045	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b428ad393b87091b31199caa	f94b450bae7a78bc1b104045	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1bdd42865a233d7b3d2f126a	f94b450bae7a78bc1b104045	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5932e28a3de0e3fc23f4e29b	f94b450bae7a78bc1b104045	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6b15c9ec349c7ca9a701c7b3	f94b450bae7a78bc1b104045	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
31dc78bb3940621953fc727c	f94b450bae7a78bc1b104045	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c413181e3d50dfcbe27a61b3	f94b450bae7a78bc1b104045	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
372d3a41c7cdad2aec3bb60e	f94b450bae7a78bc1b104045	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
12c7b877781c90ffadfa4166	f94b450bae7a78bc1b104045	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c828129261f34172a2e9bbaf	f94b450bae7a78bc1b104045	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
62394470931feb460fff1655	f94b450bae7a78bc1b104045	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b4562963b1f649d9924bcbd8	f94b450bae7a78bc1b104045	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cb829a163dcb823a77d09fba	f94b450bae7a78bc1b104045	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
bdf092e158f09aae8bfd6ca1	f94b450bae7a78bc1b104045	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
627311981d7575ac49652677	f94b450bae7a78bc1b104045	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
293b6e959f6380f52af646a7	f94b450bae7a78bc1b104045	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
22d3fbcab437d29f72d7fead	f94b450bae7a78bc1b104045	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8d3426a0c29212d2c25dd077	f94b450bae7a78bc1b104045	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e6daedfa5ff97fe145e958c1	f94b450bae7a78bc1b104045	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8c92200e218baf697c3957fc	f94b450bae7a78bc1b104045	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
37f306630bfb4adc300371fb	f94b450bae7a78bc1b104045	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fc0e9185fc96fe6968a072ad	f94b450bae7a78bc1b104045	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7898e5c90dc2dbb94fe4bb74	f94b450bae7a78bc1b104045	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e8c5caceacf5f2ff783a6940	f94b450bae7a78bc1b104045	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
40924beb16d4cb698708a31d	f94b450bae7a78bc1b104045	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e958863be0052f91b72d443e	f94b450bae7a78bc1b104045	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
315d8584a2ca72eb4fbfa05a	f94b450bae7a78bc1b104045	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
77cf0b4e760d0d1c4e4fa339	f94b450bae7a78bc1b104045	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b98f84286784aff910c7b60e	f94b450bae7a78bc1b104045	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a55c3fbf3795e22e5ea7d5a4	f94b450bae7a78bc1b104045	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0894e5ecfc02280d2f2751c4	0b06e7af84c25778e3a8ddbb	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
743a08e4ce62b22328d7f575	0b06e7af84c25778e3a8ddbb	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4480cec46ce8e3e8a13940de	0b06e7af84c25778e3a8ddbb	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0cffd4c9d4f93a1c43b22d95	0b06e7af84c25778e3a8ddbb	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e487e435c3c08740890a7feb	0b06e7af84c25778e3a8ddbb	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1cbb00a927975cd4a1860d0a	0b06e7af84c25778e3a8ddbb	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9fd80b0e1c80a167c6426207	0b06e7af84c25778e3a8ddbb	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3da5ea9a255c08e60e7c91ed	0b06e7af84c25778e3a8ddbb	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
65b02214e13cd77f50bb3fb0	0b06e7af84c25778e3a8ddbb	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c8973330a44b212167f462cd	0b06e7af84c25778e3a8ddbb	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
460eb60be1d0a4ea290edab9	0b06e7af84c25778e3a8ddbb	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cf2bc628fe512cc989fca134	0b06e7af84c25778e3a8ddbb	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
db2356c5b99b7585a4197b95	0b06e7af84c25778e3a8ddbb	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d68ce3b87259295504cd2d90	0b06e7af84c25778e3a8ddbb	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dae5869a5c59d0b981ccf74e	0b06e7af84c25778e3a8ddbb	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1997d1d9381acbd12431271e	0b06e7af84c25778e3a8ddbb	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
63a89092df7b6eac5d7feb8e	0b06e7af84c25778e3a8ddbb	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9179d009f18a3efa4f8d58b9	0b06e7af84c25778e3a8ddbb	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
78366238fe65d96553cb90c2	0b06e7af84c25778e3a8ddbb	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
520426f1261b1f8f5d9e98c6	0b06e7af84c25778e3a8ddbb	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6f04aa337aad4a822b37dc9f	0b06e7af84c25778e3a8ddbb	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c4aaf81bad13dbe22c03ad90	0b06e7af84c25778e3a8ddbb	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
947479b422d138260f6cecea	0b06e7af84c25778e3a8ddbb	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9794d89b0d192699b364de44	0b06e7af84c25778e3a8ddbb	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ecf53d965bc3c3bb839e41ce	0b06e7af84c25778e3a8ddbb	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
839c8e8690e222485f0d8470	0b06e7af84c25778e3a8ddbb	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2e9fe956c9192472a258e079	0b06e7af84c25778e3a8ddbb	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ac761ebe96edc97910072140	0b06e7af84c25778e3a8ddbb	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
74f7fc8aef7d798c85c29373	0b06e7af84c25778e3a8ddbb	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c73550bbd2e138ff8a6cfcfa	0b06e7af84c25778e3a8ddbb	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0f46fd2ba0b00a7bd44ea21a	1f73c5a5abb764dcacf6c48e	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f1447de063ee08917615e666	1f73c5a5abb764dcacf6c48e	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c10b3420b112792bbe9a312d	1f73c5a5abb764dcacf6c48e	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
aab6e8f02cfe08f6db656698	1f73c5a5abb764dcacf6c48e	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4a9fe5ae75a7fd71fafa670c	1f73c5a5abb764dcacf6c48e	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
47d044456dbe2ffcccf87f03	1f73c5a5abb764dcacf6c48e	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8a2e660b0eff266898d2c8d9	1f73c5a5abb764dcacf6c48e	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
95da65051064835d85606d65	1f73c5a5abb764dcacf6c48e	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e8075d525c8a35ab5ae3f37a	1f73c5a5abb764dcacf6c48e	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
420affac9f1d52b9634c10c4	1f73c5a5abb764dcacf6c48e	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f7c34491b6bb38a09ea17ceb	1f73c5a5abb764dcacf6c48e	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ea907fc17f74417e712352bd	1f73c5a5abb764dcacf6c48e	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
51613e207bb6cfee4ea0283c	1f73c5a5abb764dcacf6c48e	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d04e8d67f70f302a78ef445d	1f73c5a5abb764dcacf6c48e	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e024441e12a14a0a1beda5c9	1f73c5a5abb764dcacf6c48e	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
954497456d6622fa216c1c92	1f73c5a5abb764dcacf6c48e	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
492d745851cc9686c59cf254	1f73c5a5abb764dcacf6c48e	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e6a41cc8e7926ca1353df643	1f73c5a5abb764dcacf6c48e	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
79489bd66d425d0614aa9ae2	1f73c5a5abb764dcacf6c48e	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
870a16997b378abc4cb9272c	1f73c5a5abb764dcacf6c48e	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a35869c2161dced4afc9505f	1f73c5a5abb764dcacf6c48e	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0c515e5e6c007beb8886b808	1f73c5a5abb764dcacf6c48e	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2212f893647ead071ae77f21	1f73c5a5abb764dcacf6c48e	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cfe7e20f19c6d3ab402dfd0b	1f73c5a5abb764dcacf6c48e	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2187db27a658d2df8e9ae86e	1f73c5a5abb764dcacf6c48e	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e7c6cece6a1e30dca891c460	1f73c5a5abb764dcacf6c48e	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
613d3879f68c82276bb698e6	1f73c5a5abb764dcacf6c48e	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d0950be487a79591b4393ada	1f73c5a5abb764dcacf6c48e	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
73b3d4f811742b0878067235	1f73c5a5abb764dcacf6c48e	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7d8b7552a0557174eef836ac	1f73c5a5abb764dcacf6c48e	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
69796f0ca5fd5b6ab44ac6ed	83b6ffc343022b0ae2b14962	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a43dcbdd4d9ebe45fe7e97ca	83b6ffc343022b0ae2b14962	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
815f1b645b7a037e77f2eed1	83b6ffc343022b0ae2b14962	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0b479eb8c3451beb8ea9a5d2	83b6ffc343022b0ae2b14962	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5b3901af0c48358422c82526	83b6ffc343022b0ae2b14962	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
eb0985b40b5a2e255d7223af	83b6ffc343022b0ae2b14962	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f5eb2269dc3d71c1f84703da	83b6ffc343022b0ae2b14962	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
80570079d1c0ef79a8a8b78c	83b6ffc343022b0ae2b14962	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c03eb3edb1a912bb91f062f6	83b6ffc343022b0ae2b14962	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3b915a3270c96a288c61dc88	83b6ffc343022b0ae2b14962	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a42f9ccdf46a8d42f2f27e6b	83b6ffc343022b0ae2b14962	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
78ff525fdcda7fd7cc7f044e	83b6ffc343022b0ae2b14962	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8ebe6386fcb478cef6d0b675	83b6ffc343022b0ae2b14962	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fed8b03f8ff528b8e57516a0	83b6ffc343022b0ae2b14962	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
46ed5b73c0ae3e4e80766c4f	83b6ffc343022b0ae2b14962	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
477b66e9f31c0bb96a20dcd1	83b6ffc343022b0ae2b14962	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8e75d57a582b456cb02efb3f	83b6ffc343022b0ae2b14962	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9bae3aeb548e3162c2043576	83b6ffc343022b0ae2b14962	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c353f7d2a340f56d59110817	83b6ffc343022b0ae2b14962	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6a99d9044f0c4a20e6675676	83b6ffc343022b0ae2b14962	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
293a2707e4bc98033c4171d8	83b6ffc343022b0ae2b14962	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a6e389893bc7005e3c924a5d	83b6ffc343022b0ae2b14962	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cdf1bb18add95f9a687f7745	83b6ffc343022b0ae2b14962	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d5171f0770643634a57eeee1	83b6ffc343022b0ae2b14962	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
55422422dffb0f5a911766f7	83b6ffc343022b0ae2b14962	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
32bd23b464262659600cd46f	83b6ffc343022b0ae2b14962	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
556a08a174c7c1b78a0a0dda	83b6ffc343022b0ae2b14962	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7bc685954011111e5f688f78	83b6ffc343022b0ae2b14962	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f97f2a59c86b63dfe3935b8f	83b6ffc343022b0ae2b14962	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fb8367d3975e1049741a7dfb	83b6ffc343022b0ae2b14962	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
76a29ba88e427465259f292c	6625d58ade1b76ce21aa7155	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2b4e8aafcbdf251e688a68cf	6625d58ade1b76ce21aa7155	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e47b519c9b4159a557333202	6625d58ade1b76ce21aa7155	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dd494c93c15792cc10e09745	6625d58ade1b76ce21aa7155	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3d73d66f5d70b003bbdfe40c	6625d58ade1b76ce21aa7155	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ec93df0ff4403e437e0f282a	6625d58ade1b76ce21aa7155	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fd3972ca914e9536b97d1517	6625d58ade1b76ce21aa7155	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d681afabc792fc48f8931890	6625d58ade1b76ce21aa7155	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
acc5655e6edf421437f589ba	6625d58ade1b76ce21aa7155	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
63971132670c5adf9eb3f4b0	6625d58ade1b76ce21aa7155	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d457609e7e4f237444df203d	6625d58ade1b76ce21aa7155	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2d9c25fd23d8565b4ae88ad8	6625d58ade1b76ce21aa7155	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7c53bb3d875779e6b2897157	6625d58ade1b76ce21aa7155	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a3417d4d4b9e48dcffec33a4	6625d58ade1b76ce21aa7155	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a26c1e8abf6bb8d29af92168	6625d58ade1b76ce21aa7155	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
29e2542bec6b7088bc5fa129	6625d58ade1b76ce21aa7155	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e8006bccbe9d99cd6e137ff1	6625d58ade1b76ce21aa7155	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a5680dcdc01da96489f8856e	6625d58ade1b76ce21aa7155	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0707282d8bfff02be4f58809	6625d58ade1b76ce21aa7155	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e87ce0b8aeb739f8096852f1	6625d58ade1b76ce21aa7155	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
81ae3d785fad88cf03993961	6625d58ade1b76ce21aa7155	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1308ecb6b2b27cc1a5963e83	6625d58ade1b76ce21aa7155	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
eb7c523e081cac3ad47823cf	6625d58ade1b76ce21aa7155	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
10e7d09650b4c9f02da5cc64	6625d58ade1b76ce21aa7155	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ceeefafaef16d927bcdfbcf5	6625d58ade1b76ce21aa7155	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5824a30a7cac958211739a8f	6625d58ade1b76ce21aa7155	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
002a50c69f6f713da44670cf	6625d58ade1b76ce21aa7155	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ff52ab2e00785a11c1ff56da	6625d58ade1b76ce21aa7155	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1c05ff6fb620e6c9284b2015	6625d58ade1b76ce21aa7155	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
97a9f15421aad44964048fef	6625d58ade1b76ce21aa7155	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2df6c34318ddebd5f8e50552	4c8d363ce18fc3f850cf56fc	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f5bffcb31d7c4b5544c8e4b0	4c8d363ce18fc3f850cf56fc	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
1619ce973f97137f4c860110	4c8d363ce18fc3f850cf56fc	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
551abd4d8ff18e67e9351d63	4c8d363ce18fc3f850cf56fc	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7ff955fdf9284d338c4a83d6	4c8d363ce18fc3f850cf56fc	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fbf866ae0de12c8af178e87c	4c8d363ce18fc3f850cf56fc	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f7b2d52e2c710da47a3b1392	4c8d363ce18fc3f850cf56fc	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
657e1737666465ddbb28cf6b	4c8d363ce18fc3f850cf56fc	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
99c24670920861c359db076f	4c8d363ce18fc3f850cf56fc	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4f2c2058ce5afa0a3cccc6b4	4c8d363ce18fc3f850cf56fc	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6ecbd9bd3eeef7ae138e7d71	4c8d363ce18fc3f850cf56fc	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4b22e33cf3e9f9bdd240e5e8	4c8d363ce18fc3f850cf56fc	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7434b7e3759c839b92b7d095	4c8d363ce18fc3f850cf56fc	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a1aa3d0aed7ff3f7d9cd8bd7	4c8d363ce18fc3f850cf56fc	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2ba73fca96f0c1426dd530de	4c8d363ce18fc3f850cf56fc	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b1cdde3a274562bf088577e3	4c8d363ce18fc3f850cf56fc	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9edcc100fd10c3300547d9c7	4c8d363ce18fc3f850cf56fc	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
287bc6e16b9b96f1268d2390	4c8d363ce18fc3f850cf56fc	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
5e49782891aa8e4219659ed7	4c8d363ce18fc3f850cf56fc	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
06bcf72b85a40e6f94c9ca30	4c8d363ce18fc3f850cf56fc	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b21d13d406fd4568ac19f052	4c8d363ce18fc3f850cf56fc	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f0987eeeda9123805d18d1c9	4c8d363ce18fc3f850cf56fc	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d7304a6e70143c9a87ff57e7	4c8d363ce18fc3f850cf56fc	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c6050141ca8b40656aa44bd4	4c8d363ce18fc3f850cf56fc	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7ad822b0cb60c9bc70897b97	4c8d363ce18fc3f850cf56fc	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
e2fa336047a481761144f7d9	4c8d363ce18fc3f850cf56fc	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
baf189fcd620b587ab773dd2	4c8d363ce18fc3f850cf56fc	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b22cffc5c0d71b4569a6646d	4c8d363ce18fc3f850cf56fc	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
f36419bfd4646c50f5661a48	4c8d363ce18fc3f850cf56fc	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
29235d307f5e506d0c562e2f	4c8d363ce18fc3f850cf56fc	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7d912092e2a5a289b71f7326	f4cf177098b1be8090bd4dda	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
54aae6d3dc7dd55d4661849f	f4cf177098b1be8090bd4dda	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
167509753b457d8e692f4fe3	f4cf177098b1be8090bd4dda	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8d7c2042953c3931cd9921af	f4cf177098b1be8090bd4dda	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8df19e9906afa42cdd43fd09	f4cf177098b1be8090bd4dda	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
764b04322a3489ec37d2ef44	f4cf177098b1be8090bd4dda	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
891aa0d5c14e807ed125f61b	f4cf177098b1be8090bd4dda	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
4bae5eb613d5b2d97be7620f	f4cf177098b1be8090bd4dda	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7bebd7e25fdd8787e1820e50	f4cf177098b1be8090bd4dda	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d062f782eff87afb7212057f	f4cf177098b1be8090bd4dda	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dbec6cb54abf9c081d43b801	f4cf177098b1be8090bd4dda	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
744bb67bbe2679efc2a03270	f4cf177098b1be8090bd4dda	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
484ae68a9a0aee4e9ea57995	f4cf177098b1be8090bd4dda	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
24a3d09c00b8c164521c9e2e	f4cf177098b1be8090bd4dda	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
0224684db50a60eb0fedb57b	f4cf177098b1be8090bd4dda	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
907e11cabe7b1b1a839f53d0	f4cf177098b1be8090bd4dda	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
9cc7b6b342d12a6f23ccd7d3	f4cf177098b1be8090bd4dda	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a02b6f3208d0c8960f6a9f78	f4cf177098b1be8090bd4dda	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
482a831ba085d67028b4d8a7	f4cf177098b1be8090bd4dda	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6ececb2d7771e0ba0476291d	f4cf177098b1be8090bd4dda	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
03fb074ef4fc2c5c85850713	f4cf177098b1be8090bd4dda	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
07fe2edd9ac4e5526a6cb2ef	f4cf177098b1be8090bd4dda	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7463729d17e88ec5b522cad8	f4cf177098b1be8090bd4dda	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cd70dda647c1f5aa95978e3c	f4cf177098b1be8090bd4dda	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
308468f97a3570c2b5934e05	f4cf177098b1be8090bd4dda	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8ef1e71a34da0865f0eba61e	f4cf177098b1be8090bd4dda	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
df6ccf006d2abd36a9ab75e2	f4cf177098b1be8090bd4dda	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
86563bb3dcc72a5f9c72a287	f4cf177098b1be8090bd4dda	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
27393e5d30636a741fd465d9	f4cf177098b1be8090bd4dda	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
182e5ff2fdcefd6fbb9af259	f4cf177098b1be8090bd4dda	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
090e1abf5f27fb4395c9f79a	16f3c1444d5164ba823581b2	2026-04-01 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d32115c2ef2db0399d5e1d36	16f3c1444d5164ba823581b2	2026-04-02 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
8fcfe31c0aff0ec8ee5736a5	16f3c1444d5164ba823581b2	2026-04-03 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
3d6a5ed3c8adaaf3a3b26391	16f3c1444d5164ba823581b2	2026-04-04 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
7992a53f144bdf6ff80316e0	16f3c1444d5164ba823581b2	2026-04-05 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b4f2ebac00d64c9f4e96910c	16f3c1444d5164ba823581b2	2026-04-06 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
62859dbd3011187673de6849	16f3c1444d5164ba823581b2	2026-04-07 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
badb8f4c9865121266e06d32	16f3c1444d5164ba823581b2	2026-04-08 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
749665fbce1f08cdc07588b0	16f3c1444d5164ba823581b2	2026-04-09 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
da2d845fa3cdd8f3aafd6103	16f3c1444d5164ba823581b2	2026-04-10 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c7bbe6325e95890e505c9ff6	16f3c1444d5164ba823581b2	2026-04-11 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
390fd81f9db98a77c276f478	16f3c1444d5164ba823581b2	2026-04-12 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
870e3367564d0db9d221514b	16f3c1444d5164ba823581b2	2026-04-13 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fa5e00a1fd3f04fd9b59916d	16f3c1444d5164ba823581b2	2026-04-14 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
631379c782b67b5def094cd0	16f3c1444d5164ba823581b2	2026-04-15 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
c24955bf544d4cd7a5a704c1	16f3c1444d5164ba823581b2	2026-04-16 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
412433ab50801e3461df6fe5	16f3c1444d5164ba823581b2	2026-04-17 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b6cb2d32ed758567beb78816	16f3c1444d5164ba823581b2	2026-04-18 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
13493d80084945f956decf9d	16f3c1444d5164ba823581b2	2026-04-19 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fd7e57ecbb988e21a5b70657	16f3c1444d5164ba823581b2	2026-04-20 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
cb0a7300be3ac644af4ff992	16f3c1444d5164ba823581b2	2026-04-21 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
a80fdd803ff9433cb989cfd9	16f3c1444d5164ba823581b2	2026-04-22 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
ebc4a8206abfd9124ebb67f6	16f3c1444d5164ba823581b2	2026-04-23 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
687b15b9b9faf74e6faa4e8d	16f3c1444d5164ba823581b2	2026-04-24 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
d44949640bfd086087b0bd10	16f3c1444d5164ba823581b2	2026-04-25 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
6a6234670ba8cbff9bee33ee	16f3c1444d5164ba823581b2	2026-04-26 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
fee08c32bb107bef3cbe8b0d	16f3c1444d5164ba823581b2	2026-04-27 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
2b18c9917dc1c29c9d5f5fb3	16f3c1444d5164ba823581b2	2026-04-28 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
b9b38a3a3efeff6384c09ec1	16f3c1444d5164ba823581b2	2026-04-29 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
dd8a3086ccc8124c56cc6c2f	16f3c1444d5164ba823581b2	2026-04-30 00:00:00	t	t	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164	\N	\N	default	[]	approved	default	[]	approved	default	[]	approved	\N
239d7a10af20d8c4474cd5f3	3acdfa641bdfe968502b3d15	2026-05-27 00:00:00	t	f	t	2026-05-25 18:51:22.49936	2026-05-25 18:51:22.502463	\N	\N	default	[]	approved	default	[]	approved	cancel	[]	pending	\N
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
7f435e042e84696068a66ae1	3acdfa641bdfe968502b3d15	2a8fbe44e221552bf3ea6454	test message	f	\N	2026-05-25 13:11:33.185262	2026-05-25 13:11:33.185262
48f918dd1653685ead1f2850	2a8fbe44e221552bf3ea6454	3acdfa641bdfe968502b3d15	Smoke test message	f	\N	2026-05-25 14:20:36.088609	2026-05-25 14:20:36.088609
347a7b653e11a32f08b11fc5	2a8fbe44e221552bf3ea6454	3acdfa641bdfe968502b3d15	Smoke test message	f	\N	2026-05-25 14:21:47.454211	2026-05-25 14:21:47.454211
708e679cc472b137b688789c	be0ba0ba02ad271dbb3c612b	2a8fbe44e221552bf3ea6454	hi	f	\N	2026-05-25 16:09:53.30544	2026-05-25 16:09:53.30544
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
24260bc52bdebbfce5610858	bc413512843c5139b681c31f	f	2026-05-21 00:00:00	2026-06-23 00:00:00	Home	2026-05-25 11:06:55.823014	2026-05-25 13:20:09.397873
71c19bbe8c8e600980930c23	3acdfa641bdfe968502b3d15	f	2026-05-25 00:00:00	2026-05-26 00:00:00	test	2026-05-25 14:29:29.228024	2026-05-25 14:40:22.626439
8dafd9fe72ef4836ff31eb9d	be0ba0ba02ad271dbb3c612b	f	2026-05-04 00:00:00	2026-09-30 00:00:00		2026-05-25 13:44:38.788746	2026-05-25 18:51:51.637596
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
62450f8f827d568aff2d1d0e	April Student 01	april.student01@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-001	APR-101	01910000001	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
a027f3f9781c81aa23cde1a2	April Student 02	april.student02@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-002	APR-102	01910000002	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
ac21bc09cabf3e4524499f21	April Student 03	april.student03@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-003	APR-103	01910000003	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
94376abf17118888318655ee	April Student 04	april.student04@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-004	APR-104	01910000004	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
005485d041fff18bf989d8ad	April Student 05	april.student05@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-005	APR-201	01910000005	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
63a54b4f76f8997b6875ae11	April Student 06	april.student06@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-006	APR-202	01910000006	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
da53bc3629e9f9c8803332e5	April Student 07	april.student07@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-007	APR-203	01910000007	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
baee7cc06393927d525d67f6	April Student 08	april.student08@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-008	APR-204	01910000008	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
3d2b3c42be684eba0fb2232f	April Student 09	april.student09@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-009	APR-301	01910000009	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
d0a6263e56e5f052cb12b33f	April Student 10	april.student10@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-010	APR-302	01910000010	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
b761720b1572afcc60701676	April Student 11	april.student11@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-011	APR-303	01910000011	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
fc15c07b5ab015faa668bbde	April Student 12	april.student12@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-012	APR-304	01910000012	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
792dcb7d39f8217bf113bb35	April Student 13	april.student13@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-013	APR-401	01910000013	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
06d2e750cd05df2906447617	April Student 14	april.student14@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-014	APR-402	01910000014	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
f029e06fa00b52dc81e8ff92	April Student 15	april.student15@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-015	APR-403	01910000015	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
f8a3c918aa67340ebc465017	April Student 16	april.student16@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-016	APR-404	01910000016	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
bf65102ca6f45510aa005795	April Student 17	april.student17@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-017	APR-501	01910000017	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
11a8d02b3d98873356cfa1c4	April Student 18	april.student18@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-018	APR-502	01910000018	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
254425d723cc5cddc2867f11	April Student 19	april.student19@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-019	APR-503	01910000019	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
796e488102d7e48fa7f5ce29	April Student 20	april.student20@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-020	APR-504	01910000020	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
ee035fe5e452171f13f6f523	April Student 21	april.student21@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-021	APR-601	01910000021	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
8f1d543461fe08b3bf1f8dc0	April Student 22	april.student22@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-022	APR-602	01910000022	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
f94b450bae7a78bc1b104045	April Student 23	april.student23@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-023	APR-603	01910000023	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
0b06e7af84c25778e3a8ddbb	April Student 24	april.student24@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-024	APR-604	01910000024	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
1f73c5a5abb764dcacf6c48e	April Student 25	april.student25@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-025	APR-701	01910000025	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
83b6ffc343022b0ae2b14962	April Student 26	april.student26@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-026	APR-702	01910000026	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
6625d58ade1b76ce21aa7155	April Student 27	april.student27@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-027	APR-703	01910000027	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
4c8d363ce18fc3f850cf56fc	April Student 28	april.student28@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-028	APR-704	01910000028	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
f4cf177098b1be8090bd4dda	April Student 29	april.student29@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-029	APR-801	01910000029	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
16f3c1444d5164ba823581b2	April Student 30	april.student30@student.com	$2a$12$K.ozlgnBCYoISujiAxHuf.4DYXM.MeWfz4nrOmKdNhUYoQZD71piu	student	APR-030	APR-802	01910000030	t	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
\.


--
-- Data for Name: UtilityExpenses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."UtilityExpenses" ("Id", "Month", "Year", "Type", "Amount", "Notes", "CreatedAt", "UpdatedAt") FROM stdin;
7345c71a5b197113bde44657	4	2026	gas	12000	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
1b14f17c84000e4390a274d1	4	2026	electricity	18000	April full demo seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
741e544fda06f69c3950ee00	4	2026	internet_bill	3500	April extra custom bill seed	2026-05-25 21:02:41.078164	2026-05-25 21:02:41.078164
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
20260525130402_BazarUtilityAdvanceBilling	8.0.18
20260525185653_MultipleHolidayRanges	8.0.18
20260525190313_DropAttendance	8.0.18
\.


--
-- Name: AdvancePayments PK_AdvancePayments; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AdvancePayments"
    ADD CONSTRAINT "PK_AdvancePayments" PRIMARY KEY ("Id");


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
-- Name: DailyBazars PK_DailyBazars; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DailyBazars"
    ADD CONSTRAINT "PK_DailyBazars" PRIMARY KEY ("Id");


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
-- Name: UtilityExpenses PK_UtilityExpenses; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UtilityExpenses"
    ADD CONSTRAINT "PK_UtilityExpenses" PRIMARY KEY ("Id");


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
-- Name: IX_AdvancePayments_StudentId_Date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_AdvancePayments_StudentId_Date" ON public."AdvancePayments" USING btree ("StudentId", "Date");


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
-- Name: IX_DailyBazars_CreatedById; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_DailyBazars_CreatedById" ON public."DailyBazars" USING btree ("CreatedById");


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

CREATE INDEX "IX_StudentHolidayModes_StudentId" ON public."StudentHolidayModes" USING btree ("StudentId");


--
-- Name: IX_Users_Email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Users_Email" ON public."Users" USING btree ("Email");


--
-- Name: IX_Users_RollNumber; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Users_RollNumber" ON public."Users" USING btree ("RollNumber");


--
-- Name: IX_UtilityExpenses_Year_Month_Type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_UtilityExpenses_Year_Month_Type" ON public."UtilityExpenses" USING btree ("Year", "Month", "Type");


--
-- Name: IX_WeeklyMealSchedules_DayOfWeek_MealType; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_WeeklyMealSchedules_DayOfWeek_MealType" ON public."WeeklyMealSchedules" USING btree ("DayOfWeek", "MealType");


--
-- Name: AdvancePayments FK_AdvancePayments_Users_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AdvancePayments"
    ADD CONSTRAINT "FK_AdvancePayments_Users_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


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
-- Name: DailyBazars FK_DailyBazars_Users_CreatedById; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DailyBazars"
    ADD CONSTRAINT "FK_DailyBazars_Users_CreatedById" FOREIGN KEY ("CreatedById") REFERENCES public."Users"("Id") ON DELETE CASCADE;


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

\unrestrict dWplaIcJuCYmyfVMgusKGjkVNZ5FJU9P6H2e9qSWnCj6VvcQ7778tOWMqlTvXUL

