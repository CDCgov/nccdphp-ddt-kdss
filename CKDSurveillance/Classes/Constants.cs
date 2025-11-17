public enum CartNavItem
{
    SelectPublication = 1,
    Cart = 2,
    Shipping = 3,
    OrderSummary = 4,
    Confirmation = 5
}

public class ApplicationConstants
{
    public static readonly string USER_INFO_CACHE_KEY = "UserInfoObj:";
    public static readonly string SEND_MAIL = "SendMail";
    public static readonly string NOTIFY_ENABLED = "NotifyEnabled";
    public static readonly string NOTIFY_TEST_TO = "NotifyTestTo";
    public static readonly string MAIL_SENDER = "MailSender";
    public static readonly string NOTIFY_BCC = "NotifyBcc";
    public static readonly string SMTP_MAIL_Server = "MailServer";

    public static readonly string SECONDARY_WINDOW_WIDTH = "800";
    public static readonly string SECONDARY_WINDOW_HEIGHT = "600";

}

public class ContentConstants
{
    public static readonly string ADMIN_TAB = "ADMIN_TAB";
    public static readonly string SYSTEM_SETTINGS_TAB = "SYSTEM_SETTINGS_TAB";
    public static readonly string REPORTS_TAB = "REPORTS_TAB";
    public static readonly string ORDERS_TAB = "ORDERS_TAB";
    public static readonly string PUBLICATION_TAB = "PUBLICATION_TAB";
    public static readonly string USER_ADMIN_PAGE = "USER_ADMIN_PAGE";
    public static readonly string FIRSTNAME_FLD = "FIRSTNAME_FLD";
    public static readonly string LASTNAME_FLD = "LASTNAME_FLD";
    public static readonly string MIDDLENAME_FLD = "MIDDLENAME_FLD";
    public static readonly string EMAIL_FLD = "EMAIL_FLD";
    public static readonly string PHONE_FLD = "PHONE_FLD";
}


public class controlModes
{
    public static readonly string Cart = "viewcart";
    public static readonly string OrderDetails = "vieworderdetails";
    public static readonly string OrderSummary = "viewordersummary";
    public static readonly string OrderConfirmation = "vieworderconfirmation";
    public static readonly string PrintOrderConfirmation = "printorderconfirmation";

}

public class SessionConstants
{
    public static readonly string SESSION_CART = "session_cart";
    public static readonly string SESSION_ORDER = "session_order";
}

public class FacetConstants
{

    public static readonly string FACET_TABLEID = "TableId";
    public static readonly string FACET_TABLENANME = "TableName";
    public static readonly string FACET_GROUPID = "GroupId";
    public static readonly string FACET_GROUPTBLNAME = "GroupTblName";
    public static readonly string FACET_COLUMNID = "ColumnId";
    public static readonly string FACET_COUNT = "Count";
    public static readonly string FACET_NAME = "Name";

}

public class SearchResultConstants
{
    public static readonly string SEARCH_RESULT_ROW_NUM = "RowNumber";
    public static readonly string SEARCH_RESULT_PUB_ID = "pub_id";
    public static readonly string SEARCH_RESULT_PUB_NUMBER = "pub_number";
    public static readonly string SEARCH_RESULT_PUB_YEAR = "PublishYear";
    public static readonly string SEARCH_RESULT_PUB_TITLE = "Pub_long_title";
    public static readonly string SEARCH_RESULT_PUB_FORMAT = "FormatDesc";

    public static readonly int SEARCH_RESULTS_TABLE_PUBS = 0;
    public static readonly int SEARCH_RESULTS_TABLE_PUB_COUNT = 1;
    public static readonly int SEARCH_RESULTS_TABLE_TOPICS = 2;
    public static readonly int SEARCH_RESULTS_TABLE_FORMAT = 3;
    public static readonly int SEARCH_RESULTS_TABLE_AUDIENCES = 4;
    public static readonly int SEARCH_RESULTS_TABLE_LANGUAGES = 5;




}


public class FacetTableConstants
{
    public static readonly string FACET_TOPIC = "01";
    public static readonly string FACET_FORMAT = "02";
    public static readonly string FACET_AUDIENCE = "03";
    public static readonly string FACET_LANGUAGE = "04";
    public static readonly string FACET_PUB_YEAR = "05";
}

public class  DotNetChartStyle
{
    public static readonly string Column = "10";
    public static readonly string Line = "3";
    public static readonly string StackedColumn = "11";
    public static readonly string BoxPlot = "28";
    public static readonly string StateLevelMap = "5";
    public static readonly string CountyLevelMap = "6";
}
