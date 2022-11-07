
function task_page_load_complete() {
    try {

        var sPath = window.location; 
        var pathname = window.location.pathname;
        var sPage = pathname.substring(pathname.lastIndexOf('/') + 1);
        
        var end = new Date();
        var client = (end.getTime() - start.getTime()); //start is defined in the NCCDPage.vb class (Page_init) in CKDLib
        
        var total = 0;
        var svrStr = serverTime;

        //Show the execution times based on Web.Config settings
        if (showTimes > 0) {
            $get("LoadTime").innerHTML += "Load Times: Client: " + addCommas(client) + "ms, Server: " + addCommas(svrStr) + "ms";
        }
        
        if (svrStr != null) {
            total = (parseFloat(svrStr) + client);
        } else {
            total = client;
        }
                
        if (total > threshold) {            
            //Save to the database
            sendToDataBase(svrStr, client, sPath, sPage, total);
            
            //Send an email notification if it takes more than the threshold in the Web.config
            //Threshold is defined in the NCCDPage.vb (Page_Load) class in CKDLib
            SendSlowPageLoadNotification(svrStr, client, sPath, sPage, total);
            
        } else {
            //Only send to the database
            sendToDataBase(svrStr, client, sPath, sPage, total);
        }
    } catch (ex) { }
}

function sendToDataBase(t_svr_load, t_client_load, loc, pagename, totaltime) {

    var msg = "Server Load Time: " + t_svr_load + "|";
    msg += "Client Load Time: " + t_client_load + "|";

    var val = "Subject=CKD Surveillance Slow Page Load|&Message=" + msg + "*DBOnly*&url=" + loc + "|&pagename=" + pagename + "|&totaltime=" + totaltime;    

    $.ajax({
        type: "POST",
        url: "/CKD/SendEmail.ashx",
        data: "Message=" + val,
        success: function(data) {
            //alert("message sent!!!");
        },
        error: function(jqXHR, textStatus, errorThrown) {
            //alert(jqXHR + "status:" + textStatus);
        }
    });
}

function SendSlowPageLoadNotification(t_svr_load, t_client_load, loc, pagename, totaltime) {
    var msg = "Server Load Time: " + t_svr_load + "|";
    msg += "Client Load Time: " + t_client_load + "|";
    
    var val = "Subject=CKD Surveillance Slow Page Load|&Message=" + msg + "*EmailOnly*&url=" + loc + "|&pagename=" + pagename + "|&totaltime=" + totaltime;
        
    
    $.ajax({
        type: "POST",
        url: "/CKD/SendEmail.ashx",
        data: "Message=" + val,
        success: function(data) {
            //alert("message sent!!!");
        },
        error: function(jqXHR, textStatus, errorThrown) {
            //alert(jqXHR + "status:" + textStatus);
        }
    });
}

function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

function RoundIt() {
    $(".ckd-curvy-tab").corner({
        tl: { radius: 20 },
        tr: { radius: 20 },
        bl: { radius: 0 },
        br: { radius: 0 },
        antiAlias: true,
        autoPad: false,
        validTags: ["div"]
        
    });
}

function cleanTabOff() {
    $("div.tabOff .ckd-tab-datasource-type").each(function() {
        var txt = $(this).html();
        $(this).html(txt.replace("Source:", ""));
    });
}


function Toggle(HideOrShow) {
    var ele = document.getElementById("hideContent");

    if (HideOrShow == "S") { //&& ele.style.display != "block") {
        ele.style.display = "block"

        var outerDiv = $("#divOuter");
        try {
            $(ele).offset(outerDiv.offset());
        }
        catch (err) {
            var error = err.Description
        }
        //$(ele).height(outerDiv.height()); // The height is defined in the element on the page, hideContent
    }
    else if (HideOrShow == "H") {        
            ele.style.display = "none";
    }
}


function titleCaseDropDowns() {
    $("option").each(function() {

        //*Build the cap-cased string*
        var capCased = $(this).text().replace(/\w\S*/g, function(txt) { return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase(); }).replace("Egfr", "eGFR");

        //*Clear the text*
        $(this).text("");

        //*Replace the text*
        $(this).text(capCased);
    });
}


