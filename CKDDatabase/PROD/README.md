# PROD

Zip all required files for the KDSS Database PROD environment and prefix them with "KDSSDatabase_PROD". 
For any file containing a CREATE statement, add the GRANT permission at the end. 
Also, ensure all files include a USE statement with the correct database.
Additionally, include documentation listing the scripts in their numbered execution order.

Example:
```
1.20250915_UpdateCurrentAyaFigure.sql
2.20251106_DatabaseUpdate_Object.sql
3.20251106_DatabaseUpdate_Data.sql
```
