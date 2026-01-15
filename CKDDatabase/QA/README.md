# QA

Zip all required files for the KDSS Database QA environment and prefix them with "KDSSDatabase_QA". 
For any file containing a CREATE statement, add the GRANT permission at the end. 
Also, ensure all files include a USE statement with the correct database.
Additionally, prefix each script with a number indicating its execution order.

Example:
```
1.20250915_UpdateCurrentAyaFigure.sql
2.20251106_DatabaseUpdate_Object.sql
3.20251106_DatabaseUpdate_Data.sql
```
