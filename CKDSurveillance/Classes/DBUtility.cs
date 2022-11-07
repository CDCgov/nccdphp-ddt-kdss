using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using NGDBAccess = NG.NCCDPHP.DataAccess;

namespace CKDSurveillance_RD.Classes
{
    public class DBUtility
    {

        public static NGDBAccess.Sql.SqlDatabase GetSqlDBConnection()
        {
            NGDBAccess.Sql.SqlDatabase sqlDB = new NGDBAccess.Sql.SqlDatabase(ConfigurationManager.AppSettings["Database"], ConfigurationManager.AppSettings["DBAccount"], ConfigurationManager.AppSettings["DBServer"], ConfigurationManager.AppSettings["DBKey"]);
            return sqlDB;

        }

    }
}