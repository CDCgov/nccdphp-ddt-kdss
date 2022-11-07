using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;


namespace CKDSurveillance_RD.Classes
{
    public class AppCache
    {

        static void SetCache(object obj, string Name)
        {
            if (obj == null)
            {
                HttpContext.Current.Cache.Remove(Name);
            }
            else
            {
                HttpContext.Current.Cache.Add(Name,
                    obj, null, DateTime.Now.AddDays(1),
                    Cache.NoSlidingExpiration, CacheItemPriority.Default, null);
            }
        }



        //Publication Status
        const string SampleCacheName = "SampleCache";
        public static List<object> SampleObjects
        {
            get
            {
                List<object> list = (List<object>)HttpContext.Current.Cache[SampleCacheName];
                if (list == null)
                {
                    //Do something to get your objects
                    SetCache(list, SampleCacheName);
                }

                return list;
            }
            set
            {
                SetCache(value, SampleCacheName);
            }
        }



    }
}