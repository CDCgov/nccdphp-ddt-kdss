var N = 1000;
var color1 = "#7b3294";
var color1Light = "#c2a5cf";
var colorX = "#ffa7b5";
var colorY = "#fdae61";
var colorCKDDark = "#226491";
var colorPovDark = "#eb8430";
var colorSelected = colorPovDark;
var colorCKDDarkArray = [];
var colorCKDLightArray = [];
var colorPOVDarkArray = [];
var colorPOVLightArray = [];
var colorSelectedDarkArray = colorPOVDarkArray;
var colorSelectedLightArray = colorPOVLightArray;
var mindataval = 2;
var selectedstateid = "";

var minX = 0;
var maxX = 100;
var minY = 0;
var maxY = 100;

var minVal = 0;
var maxVal = 100;

var selectedFips = '';

const ckd_colorarray_tabs = ["#dfdddd", "#d6d8da", "#d0d4d7", "#c9d0d5", "#c3ccd2", "#bcc8cf", "#b6c3cd", "#afbfca", "#a9bbc8", "#a2b7c5", "#9cb3c2", "#96afc0", "#8faabd", "#89a6ba", "#82a2b8", "#7c9eb5", "#759ab3", "#6f96b0", "#6891ad", "#628dab", "#5c89a8", "#5585a5", "#4f81a3", "#487da0", "#42789e", "#3b749b", "#357098", "#2e6c96", "#286893", "#226491"];

const pov_colorarray_tabs = ["#dfdddd", "#e2d9d9", "#e4d6d5", "#e7d2d1", "#e9cecd", "#ebcbc8", "#edc7c4", "#efc4bf", "#f1c0ba", "#f2bdb5", "#f4b9af", "#f5b6aa", "#f6b2a4", "#f6af9e", "#f7ac99", "#f8a893", "#f8a58c", "#f8a286", "#f89f80", "#f89c79", "#f79973", "#f6966c", "#f69365", "#f4915e", "#f38e57", "#f28c4f", "#f08948", "#ee8740", "#ec8537", "#ea832e"];

function updateSelectedColor(colorType) {
    colorSelected = colorType;
    processData(allstateData);
    processData(allcountyData);
    changeColor();
}

function CKD_Selected() {    
    minVal = minY;
    maxVal = maxY;
    document.getElementById("main_map_title").innerHTML = "Chronic kidney disease";
    updateSelectedColor(colorCKDDark);
}

function Pov_Selected() {
    minVal = minX;
    maxVal = maxX;
    document.getElementById("main_map_title").innerHTML = "Population in poverty by county";
    updateSelectedColor(colorPovDark);
}

function changeColor() {
    
    if (county_counties_tabs != null) {
        var allCounties = topojson.feature(global_us_tabs, global_us_tabs.objects.counties).features; //finding all counties
        var countiesarray = [];

        if (selectedstateid != "") {
            allCounties.forEach(function (c) { //then loop through all of the counties and filter out based on the first two characters (which is the state)
                var sid = selectedstateid;
                var cid = c.id + "";
                if (cid.slice(0, sid.length) === sid && cid.length - sid.length == 3) countiesarray.push(c);
            });
        }
        else {
            countiesarray = allCounties;
        }

        if (colorSelected == colorCKDDark)
            global_csv_tabs = mapData.filter(val => val.datatype.includes("CKD"));//csvdata; //adding this passed int data to the global data
        else
            global_csv_tabs = mapData.filter(val => val.datatype.includes("POV"));//csvdata; //adding this passed int data to the global data

        county_counties_tabs.data(countiesarray)
            .style("fill", function (cdata) { //loading the csv data in the queue
            var filtercountyrow = global_csv_tabs.filter(function (d, i) {
                return (d.fipscounty == cdata.id); //just match on the countyid from the countiesarray and match it with the fipscounty columns fro mthe excel file and then return the whole row of data
            });

            if (filtercountyrow.length === 0)
                dataval = "MIA";
            else
                dataval = filtercountyrow[0]["countydatavalue"];

            var colorval;
                colorval = setColorVal(dataval, "");
            if (selectedFips != "" && cdata.id != selectedFips)
                colorval = "#ddd";
            return colorval;
        });
    }

    if (state_counties_tabs != null) {
        var allCounties = topojson.feature(global_us_tabs, global_us_tabs.objects.counties).features; //finding all counties
        var countiesarray = [];

        if (selectedstateid != "") {
            allCounties.forEach(function (c) { //then loop through all of the counties and filter out based on the first two characters (which is the state)
                var sid = selectedstateid;
                var cid = c.id + "";
                if (cid.slice(0, sid.length) === sid && cid.length - sid.length == 3) countiesarray.push(c);
            });
        }
        else {
            countiesarray = allCounties;
        }

        if (colorSelected == colorCKDDark)
            global_csv_tabs = mapData.filter(val => val.datatype.includes("CKD"));//csvdata; //adding this passed int data to the global data
        else
            global_csv_tabs = mapData.filter(val => val.datatype.includes("POV"));//csvdata; //adding this passed int data to the global data

        state_counties_tabs.data(countiesarray)
            .style("fill", function (cdata) { //loading the csv data in the queue
                var filtercountyrow = global_csv_tabs.filter(function (d, i) {
                    return (d.fipscounty == cdata.id); //just match on the countyid from the countiesarray and match it with the fipscounty columns fro mthe excel file and then return the whole row of data
                });

                if (filtercountyrow.length === 0)
                    dataval = "MIA";
                else
                    dataval = filtercountyrow[0]["countydatavalue"];

                var colorval;
                colorval = setColorVal(dataval, "");
                if (selectedFips != "" && cdata.id != selectedFips)
                    colorval = "#ddd";
                return colorval;
            });
    }
}

var x = [],
    lightX = [],
    y = [],
    lightY = [],
    text = [],
    lightText = [],
    ids = [],
    lightIds = [],
    states = [],
    lightStates = [],
    standard_deviation = [];

function drawPlot(chartname) {
    var graphDiv = document.getElementById(chartname);

    Plotly.newPlot(
        graphDiv,
        [            
            {
                name: "",
                type: "scatter",
                mode: "markers",
                text: lightText,
                hovertemplate: '<br><b>Population in poverty threshold</b>: %{x} %' +
                    '<br><b>CKD Prevalence </b>: %{y} %<br>' +
                    '<b>County: %{text}</b><br>' +
                    '<b>State: %{customdata}</b>',
                hoverlabel: { bgcolor: "#ddd", opacity:1 },
                x: lightX,
                y: lightY,
                hoverinfo:"none",
                ids: lightIds,
                customdata: lightStates,
                xaxis: "x2",
                yaxis: "y2",
                opacity: 0.3,
                marker: {
                    color: colorSelectedLightArray, size: 10,
                    line: {
                        color: '#ffffff',
                        width: 1
                    }
                },
            },
            {
                name: "",
                type: "scatter",
                mode: "markers",
                text: text,
                hovertemplate: '<br><b>Population in poverty threshold</b>: %{x} %' +
                    '<br><b>CKD Prevalence </b>: %{y} %<br>' +
                    '<b>County: %{text}</b><br>' +
                    '<b>State: %{customdata}</b>',
                hoverlabel: { bgcolor: "#ddd", opacity: 1 },
                x: x,
                y: y,
                ids: ids,
                customdata: states,
                xaxis: "x2",
                yaxis: "y2",
                marker: {
                    color: colorSelectedDarkArray, size: 10,
                    line: {
                        color: '#ffffff',
                        width: 1
                    }
                },
            }
        ],
        {
            hovermode: "closest",
            xaxis2: { title: "Population in poverty by county %" },
            yaxis2: { title: "CKD Prevalence %" },
            showlegend: false,
            font: {
                family: "Nunito",
                size: 12,
            },
            titlefont: {
                size: 16,
            }
        },
        {
            displayModeBar: false,
            scrollZoom: true
        }
    );

    graphDiv.on("plotly_click", function (eventData) {
        var sx = [];
        var sy = [];

        eventData.points.forEach(function (pt) {
            sx.push(pt.x);
            sy.push(pt.y);
            selectedFips = pt.id;
        })
        minX = sx[0];
        maxX = sx[0];

        minY = sy[0];
        maxY = sy[0];

        changeColor();

        processData(allstateData);
        processData(allcountyData);
    });      

    graphDiv.on("plotly_doubleclick", function () {
        $(".btnzoomout").click();
    });
}
function processData(allRows) {
    (x = []),
        (lightX = []),
        (y = []),
        (lightY = []),
        (text = []),
        (lightText = []),
        (ids = []),
        (lightIds = []),
        (states = []),
        (lightStates = []),
        (standard_deviation = []),
        (colorPOVDarkArray = []),
        (colorPOVLightArray = []),
        (colorCKDDarkArray = []),
        (colorCKDLightArray = []),
        (dataToProcess = []);

    if (allRows.length > 100) {
        dataToProcess = allcountyData;
    }
    else {
        dataToProcess = allstateData;
    }
    if (colorSelected == colorCKDDark) {
        for (var i = 0; i < allRows.length; i++) {
            row = dataToProcess[i];
            if (
                Number(minX) <= Number(row["Below_poverty_threshold"]) &&
                Number(maxX) >= Number(row["Below_poverty_threshold"]) &&
                Number(minY) <= Number(row["AnyCKD_rate"]) &&
                Number(maxY) >= Number(row["AnyCKD_rate"]) &&
                ($("#ddstate").val() == "select" || row["FIPSState"] == $("#ddstate").val()) &&
                    ((selectedFips != '' && row["fipscounty"] == selectedFips) || selectedFips == '') 
            ) {
                x.push(row["Below_poverty_threshold"]);
                y.push(row["AnyCKD_rate"]);
                text.push(row["COUNTY"]);
                states.push(row["STATE"]);
                ids.push(row["fipscounty"]);
                colorCKDDarkArray.push(setColorVal(row["AnyCKD_rate"], "ckd"));
            } else {
                lightX.push(row["Below_poverty_threshold"]);
                lightY.push(row["AnyCKD_rate"]);
                lightText.push(row["COUNTY"]);
                lightStates.push(row["STATE"]);
                lightIds.push(row["fipscounty"]);
                colorCKDLightArray.push(setColorVal(row["AnyCKD_rate"], "ckd"));
            }
        }

        colorSelectedDarkArray = colorCKDDarkArray;
        colorSelectedLightArray = colorCKDLightArray;
    } else {
        for (var i = 0; i < allRows.length; i++) {
            row = dataToProcess[i];
            if (
                Number(minX) <= Number(row["Below_poverty_threshold"]) &&
                Number(maxX) >= Number(row["Below_poverty_threshold"]) &&
                Number(minY) <= Number(row["AnyCKD_rate"]) &&
                Number(maxY) >= Number(row["AnyCKD_rate"]) &&
                ($("#ddstate").val() == "select" || row["FIPSState"] == $("#ddstate").val()) &&
                ((selectedFips != '' && row["fipscounty"] == selectedFips) || selectedFips == '') 
            ) {
                x.push(row["Below_poverty_threshold"]);
                y.push(row["AnyCKD_rate"]);
                text.push(row["COUNTY"]);
                states.push(row["STATE"]);
                ids.push(row["fipscounty"]);
                colorPOVDarkArray.push(setColorVal(row["Below_poverty_threshold"], "pov"));
            } else {
                lightX.push(row["Below_poverty_threshold"]);
                lightY.push(row["AnyCKD_rate"]);
                lightText.push(row["COUNTY"]);
                lightStates.push(row["STATE"]);
                lightIds.push(row["fipscounty"]);
                colorPOVLightArray.push(setColorVal(row["Below_poverty_threshold"], "pov"));
            }
        }

        colorSelectedDarkArray = colorPOVDarkArray;
        colorSelectedLightArray = colorPOVLightArray;
    }

    if (allRows.length < 100) {
        drawPlot("tab_linkedstatemapscatter");
    }
    else {
        drawPlot("tab_linkedcountymapscatter");
    }
}

var minGap = 0;

function pov_slideOne() {

    var pov_sliderOne = document.getElementById("pov_slider-1");
    var pov_sliderTwo = document.getElementById("pov_slider-2");
    var pov_displayValOne = document.getElementById("pov_range1");
    var pov_displayValTwo = document.getElementById("pov_range2");

    if (
        parseInt(pov_sliderTwo.value) - parseInt(pov_sliderOne.value) <=
        minGap
    ) {
        pov_sliderOne.value = parseInt(pov_sliderTwo.value) - minGap;
    }
    pov_displayValOne.textContent = pov_sliderOne.value + " %";
    
    //if (colorSelected == colorPovDark) {
        minX = pov_sliderOne.value;
    //}

    minVal = minX;

    fillColor();

    changeColor();

    processData(allstateData);
    processData(allcountyData);
}

function pov_slideTwo() {

    var pov_sliderOne = document.getElementById("pov_slider-1");
    var pov_sliderTwo = document.getElementById("pov_slider-2");
    var pov_displayValOne = document.getElementById("pov_range1");
    var pov_displayValTwo = document.getElementById("pov_range2");

    if (
        parseInt(pov_sliderTwo.value) - parseInt(pov_sliderOne.value) <=
        minGap
    ) {
        pov_sliderTwo.value = parseInt(pov_sliderOne.value) + minGap;
    }
    pov_displayValTwo.textContent = pov_sliderTwo.value + " %";
    //if (colorSelected == colorPovDark) {
        maxX = pov_sliderTwo.value;
    //}

    maxVal = maxX;
    
    fillColor();

    changeColor();

    processData(allstateData);
    processData(allcountyData);
}

function ckd_slideOne() {

    var ckd_sliderOne = document.getElementById("ckd_slider-1");
    var ckd_sliderTwo = document.getElementById("ckd_slider-2");
    var ckd_displayValOne = document.getElementById("ckd_range1");
    var ckd_displayValTwo = document.getElementById("ckd_range2");

    if (
        parseInt(ckd_sliderTwo.value) - parseInt(ckd_sliderOne.value) <=
        minGap
    ) {
        ckd_sliderOne.value = parseInt(ckd_sliderTwo.value) - minGap;
    }
    ckd_displayValOne.textContent = ckd_sliderOne.value + " %";
    
    //if (colorSelected == colorCKDDark) {
        minY = ckd_sliderOne.value;
    //}

    minVal = minY;

    fillColor();

    changeColor();

    processData(allstateData);
    processData(allcountyData);
}

function ckd_slideTwo() {

    var ckd_sliderOne = document.getElementById("ckd_slider-1");
    var ckd_sliderTwo = document.getElementById("ckd_slider-2");
    var ckd_displayValOne = document.getElementById("ckd_range1");
    var ckd_displayValTwo = document.getElementById("ckd_range2");

    if (
        parseInt(ckd_sliderTwo.value) - parseInt(ckd_sliderOne.value) <=
        minGap
    ) {
        ckd_sliderTwo.value = parseInt(ckd_sliderOne.value) + minGap;
    }
    ckd_displayValTwo.textContent = ckd_sliderTwo.value + " %";
    
    //if (colorSelected == colorCKDDark) {
        maxY = ckd_sliderTwo.value;
    //}

    maxVal = maxY;  

    fillColor();

    changeColor();

    processData(allstateData);
    processData(allcountyData);
}

function fillColor() {
    var pov_sliderOne = document.getElementById("pov_slider-1");
    var pov_sliderTwo = document.getElementById("pov_slider-2");
    var ckd_sliderOne = document.getElementById("ckd_slider-1");
    var ckd_sliderTwo = document.getElementById("ckd_slider-2");
    var pov_sliderTrack = document.getElementById("pov_slider");
    var ckd_sliderTrack = document.getElementById("ckd_slider");
    var pov_sliderMaxValue = document.getElementById("pov_slider-1").max;
    var ckd_sliderMaxValue = document.getElementById("ckd_slider-1").max;

    percent1 = (pov_sliderOne.value / pov_sliderMaxValue) * 100;
    percent2 = (pov_sliderTwo.value / pov_sliderMaxValue) * 100;
    //pov_sliderTrack.style.background = `linear-gradient(to right, #dadae5 ${percent1}% , #3264fe ${percent1}% , #3264fe ${percent2}%, #dadae5 ${percent2}%)`;
    pov_sliderTrack.style.background = `linear-gradient(to right, #eb8430 ${percent1}% , #eb8430 ${percent1}% , #eb8430 ${percent2}%, #eb8430 ${percent2}%)`;

    percent1 = (ckd_sliderOne.value / ckd_sliderMaxValue) * 100;
    percent2 = (ckd_sliderTwo.value / ckd_sliderMaxValue) * 100;
    ckd_sliderTrack.style.background = `linear-gradient(to right, #226491 ${percent1}% , #226491 ${percent1}% , #226491 ${percent2}%, #226491 ${percent2}%)`;
}

function setColorVal(dataval, axis) {
    var colorval = "#ddd";
    var interval = 1.9;

    if (dataval === "NA")
        colorval = "#ddd"; //was white at one point
    else if (dataval === "MIA")
        colorval = "#ddd";
    else if (axis == "pov") {
        if (parseFloat(dataval) >= parseFloat(minX) && parseFloat(dataval) <= parseFloat(maxX)) {
            for (var i = 1; i < 30; i++) {
                if (parseFloat(dataval) < mindataval) {
                    colorval = pov_colorarray_tabs[0];
                    break;
                }
                else if (parseFloat(dataval) >= (mindataval + interval * (i - 1)) && parseFloat(dataval) < (mindataval + interval * i)) {
                    colorval = pov_colorarray_tabs[i];
                    break;
                }
            }
        }
    }
    else if (axis == "ckd") {
        if (parseFloat(dataval) >= parseFloat(minY) && parseFloat(dataval) <= parseFloat(maxY)) {
            for (var i = 1; i < 30; i++) {
                if (parseFloat(dataval) < mindataval) {
                    colorval = ckd_colorarray_tabs[0];
                    break;
                }
                else if (parseFloat(dataval) >= (mindataval + interval * (i - 1)) && parseFloat(dataval) < (mindataval + interval * i)) {
                    colorval = ckd_colorarray_tabs[i];
                    break;
                }
            }
        }
    }
    else {
        if (parseFloat(dataval) >= parseFloat(minVal) && parseFloat(dataval) <= parseFloat(maxVal)) {
            for (var i = 1; i < 30; i++) {
                if (parseFloat(dataval) < mindataval) {
                    if (colorSelected == colorPovDark) {
                        colorval = pov_colorarray_tabs[0];
                        break;
                    }
                    else {
                        colorval = ckd_colorarray_tabs[0];
                        break;
                    }
                }
                else if (parseFloat(dataval) >= (mindataval + interval * (i - 1)) && parseFloat(dataval) < (mindataval + interval * i)) {
                    if (colorSelected == colorPovDark) {
                        colorval = pov_colorarray_tabs[i];
                        break;
                    }
                    else {
                        colorval = ckd_colorarray_tabs[i];
                        break;
                    }
                }
            }
        }
    }

    return colorval;
}
