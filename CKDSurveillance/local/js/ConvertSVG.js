// resource http://www.phpied.com/rgb-color-parser-in-javascript/
// resource http://code.google.com/p/canvg/
// resource http://www.nihilogic.dk/labs/canvas2image/
 
String.prototype.FixForRaphael = function() {
    // based on http://goo.gl/KZDII strip off all spaces between tags
    var svgXmlNoSpace = this.replace(/>\s+/g, ">").replace(/\s+</g, "<"); 
 
    // based on gabelerner added xmlns:xlink="http://www.w3.org/1999/xlink" into svg xlmns
    var svgXmlFixNamespace = svgXmlNoSpace.replace('xmlns="http://www.w3.org/2000/svg"', 'xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"');
 
    // based on http://goo.gl/KZDII image's href changed as xlink:href
    var svgXmlFixImage = svgXmlFixNamespace.replace(' href="', ' xlink:href="');
 
    // based on gabelerner image must be under the same domain - no crossside
 
    return svgXmlFixImage;
};​
 
function SVGtoPNG() {
 
    //serialize svg
    var svgElement = document.body.getElementsByTagName("svg")[0];
    var svgXml = (new XMLSerializer()).serializeToString(svgElement);
    //x svg_Element.style.display="none";
    var finalSvg = svgXml.FixForRaphael();
 
    //add canvas into body        
    var canvasId = "myCanvas";
    var canvas = document.createElement('canvas');
    canvas.id = canvasId;
    document.body.appendChild(canvas);
 
    //convert svg to canvas
    canvg(document.getElementById(canvasId), finalSvg, {
        ignoreMouse: true,
        ignoreAnimation: true,
        renderCallback: function() {
 
            //save canvas as image
            Canvas2Image.saveAsPNG(document.getElementById(canvasId));
            document.body.removeChild(document.getElementById(canvasId));
        }
    });
 
}