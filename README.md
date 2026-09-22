# KDSS (Chronic Kidney Disease Surveillance System)

## SHARE IT Information
* **Org**: NCCDPHP-OD
* **Contact Email:** chronicshareit@cdc.gov
* **Keywords:** 

## Solution Structure

- `CKD v8.0.sln`  
  Visual Studio 2022 solution file.

- `CKDSurveillance/`  
  ASP.NET Web Forms application (`.NET Framework 4.8`, C#).

- `CKDLib/`  
  Shared class library (`.NET Framework 4.8`, VB.NET), referenced by `CKDSurveillance`.

- `CKDDatabase/`  
  SQL Server Database Project (`.sqlproj`) containing environment release folders and SQL artifacts.

---

## Project Details

### 1) `CKDSurveillance` (Web Application)
Primary web application (`CKDSurveillance_RD`) that serves pages, handlers, controls, and static assets.

Key areas:
- `*.aspx`, `MasterPages/`, `UserControls/` for UI and composition
- `Handlers/*.ashx` and `JSHandler.ashx` for HTTP endpoints
- `Classes/` for app/session constants, utilities, dynamic helper logic
- `scripts/`, `css/`, `images/`, `Documents/`, `PPT/`, `AYA/` for front-end and content assets

Configuration:
- Base config: `Web.config`
- Environment transforms: `Web.DEV.config`, `Web.QA.config`, `Web.PROD.config`, `Web.Scan.config`
- Publish profiles: `Properties/PublishProfiles/*`

### 2) `CKDLib` (Shared Library)
VB.NET library (`ckdlibV2`) used by the web project.

Primary responsibilities:
- SQL connectivity and data access abstractions (`ArborDataAccessV2.vb`, `DBUtil.vb`)
- DB constants and utility helpers (`DBCONSTANTS.vb`, `Utilities.vb`)
- Connection string construction (`GetDBConnectionString.vb`)
- Shared page/map logic (`NCCDPage.vb`, `MapBuilder.vb`)

### 3) `CKDDatabase` (Database Project)
Database release artifact project (`CKDDatabase.sqlproj`) used to track SQL scripts and package environment deployments.

Structure includes:
- `DEV/` release scripts by dated release folder
- `QA/` packaged QA zip artifacts 
- `PROD/` packaged PROD zip artifacts 

---

## Technology Stack

- .NET Framework 4.8
- ASP.NET Web Forms
- C# + VB.NET
- SQL Server Database Project (SSDT)
- NuGet `packages.config` package management

Notable package usage includes:
- `CDC.NCCDPHP.*` libraries
- `Microsoft.Extensions.Configuration.*`
- `System.Data.SqlClient`
- `ClosedXML` / OpenXML packages for document generation paths

---

## Prerequisites

- Visual Studio 2022 with:
  - ASP.NET and web development workload
  - Data storage and processing workload (for SSDT `.sqlproj`)
- .NET Framework 4.8 Developer Pack
- Access to internal dependencies and target SQL Server environments
- NuGet package restore enabled

---

## Getting Started (Visual Studio)

1. Open `CKD v8.0.sln`.
2. Run __Restore NuGet Packages__.
3. Set startup project to `CKDSurveillance`.
4. Select a solution configuration (for example: `DEV`, `QA`, `PROD`, `Debug`, `Release`).
5. Build using __Build > Rebuild Solution__.

---

## Configuration Model

Application behavior is controlled primarily through `CKDSurveillance/Web.config` and transform files.

Important app settings include:
- Database connectivity inputs (`DBServer`, `DBName`)
- Environment and app metadata (`Environment`, `DirPath`, `AppName`)
- Error handling/logging and notifications
- UI/versioning metadata displayed on the site

Security-related settings present in config:
- Request filtering rules
- HTTPS/SSL enforcement integration
- HTTP-only / secure cookie requirements
- Custom error routing

---

## Build and Publish

### Web Application
Publish profiles are defined under:
- `CKDSurveillance/Properties/PublishProfiles/Dev Internet.pubxml`
- `CKDSurveillance/Properties/PublishProfiles/QA Internet.pubxml`

Typical workflow:
1. Select target configuration (`DEV`, `QA`, or `PROD`).
2. Apply the corresponding Web.* transform during publish.
3. Publish to the configured file system target.

### Database Artifacts
Use the SQL project and release folders under `CKDDatabase/` for script tracking and packaging.

Per QA/PROD readme guidance:
- Zip files with required environment prefix
- Include `USE` statements
- Add grants after `CREATE` scripts
- Prefix scripts in execution order

---

## Key Operational Notes

- `CKDSurveillance` depends on `CKDLib`.
- Database connection string construction is centralized in `CKDLib/GetDBConnectionString.vb`.
- Environment-specific values should be managed via transform files, not hardcoded changes.
- The solution includes many static content artifacts; preserve relative paths when moving files.

---

## Repository Contact

- Organization: `NCCDPHP-OD`
- Contact: `chronicshareit@cdc.gov`

