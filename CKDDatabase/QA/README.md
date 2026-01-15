# QA

- [ ] Zip all required files for the KDSS Database QA environment into a folder prefixed with "KDSSDatabase_QA".
- [ ] For any file containing a CREATE statement, add the GRANT permission at the end. 
- [ ] Ensure each script file includes a USE statement with the correct database at the top.
- [ ] Prefix each script with a number indicating its execution order.

Example of prefix script files:
```
1.20250915_UpdateCurrentAyaFigure.sql
2.20251106_DatabaseUpdate_Object.sql
3.20251106_DatabaseUpdate_Data.sql
```
