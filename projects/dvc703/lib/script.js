if (Modernizr.inlinesvg) {

var pymChild = new pym.Child();

  d3.queue()
          .defer(d3.csv, "intheeu.csv")
          .defer(d3.csv, "intheuk.csv")
          .defer(d3.json, "geo/worldjson8.json")
          .await(ready);

//remove fallback image
d3.select("#fallback").remove();


function ready (error, dataexports, dataimports, geog){

  colour_palette =["#766FAF","#0F8243"]
  legendLabels=["UK investments overseas","Foreign Investments in the UK"]

  var margin = {top: 40, right: 15, bottom: 40, left: 40};
              //width = 960 - margin.left - margin.right,
              //height = 500 - margin.top - margin.bottom;

  width=parseInt(d3.select("body").style("width"))*0.75;
  height=width*0.58

  mobileBreak = 599;

  var path = d3.geoPath();

  var svg = d3.select("#mapDiv")
              .append("svg")
			  .attr("id","svgMap")
              .attr("width", width-20)
              .attr("height", height)
              .append('g')
              .attr('class', 'map');


//Gradient definition
	var defs = svg.append("defs");

	var gradient = defs.append("linearGradient")
	   .attr("id", "svgGradient")
	   .attr("x1", "0%")
	   .attr("x2", "100%")
	   .attr("y1", "0%")
	   .attr("y2", "100%");

	gradient.append("stop")
	   .attr('class', 'start')
	   .attr("offset", "0%")
	   .attr("stop-color", colour_palette[0])
	   .attr("stop-opacity", 1);

	gradient.append("stop")
	   .attr('class', 'end')
	   .attr("offset", "100%")
	   .attr("stop-color", colour_palette[1])
	   .attr("stop-opacity", 1);

  var projection = d3.geoNaturalEarth1()
                     .scale(width*0.19)
                     .translate( [(width/2)-20, height/2+(height/2)*0.25]);

  var path = d3.geoPath().projection(projection);

  svg.append("g")
      .attr("class", "allcountry")
    .selectAll("path")
      .data(topojson.feature(geog, geog.objects.worldjson8).features)
    .enter().append("path")
	  .attr("class","countries")
    //.attr("fill","url(#diagonalHatch)")
	  .attr("id", function(d){return "shape" + d.properties.fips})
      .attr("d", path)
      .on("mouseover",function(d){
		highlightcountry(d.properties.fips);
        filterdata(d.properties.fips);
      })
	  .on("mouseout",function(d){
		unhighlightcountry(d.properties.fips);
        filterdata("W1");
      })

    dataexports.forEach(function(d,i){
      //  d3.select("#shape" + d.CountryId).style("fill","#EAEAEA");
        d3.select("#shape" + d.CountryId).attr("class","countries countries-selectable");
    })

    d3.select("#shapeUK").style("fill","#EAEAEA").style("stroke","#5F7682");

	  var m = svgPanZoom("#svgMap", {
        viewportSelector: '.svg-pan-zoom_viewport',
        panEnabled: true,
        controlIconsEnabled: false,
        zoomEnabled: true,
        dblClickZoomEnabled: true,
        mouseWheelZoomEnabled: true,
        zoomScaleSensitivity: 0.3,
        minZoom: 0.4,
        maxZoom: 5,
        fit: false,
        contain: false,
        center: false,
        refreshRate: 'auto'
    });

//
//
// d3.select(".svg-pan-zoom_viewport")
//   .transition()
//   .ease(d3.easeCubic)
//   .delay(2000)
//   .duration(1500)
//   .style("transform","matrix(3.58,0,0,3.58,-801,-221)")
  //.attr("transform","matrix(3.5857277753417804,0,0,3.5857277753417804,-801.6419748264167,-221.47848836049974)");

  // $(".svg-pan-zoom_viewport").css({
  //     transform:"matrix(3.5857277753417804,0,0,3.5857277753417804,-801.6419748264167,-221.47848836049974)"
  // }).attr("transform","matrix(3.5857277753417804,0,0,3.5857277753417804,-801.6419748264167,-221.47848836049974)");


// setTimeout(function(){m.zoom(3.58); m.pan({x:-801,y:-221});},4000);
//setTimeout(m.getZoom(),4000);
//getPan


getColumnNames();
getCentroids();
selectList();
enableZoom();
barchartstart();
checkUrl();

//encode country into the url
function checkUrl() {
    urlLocal = window.location.href;
    var urlcountry = urlLocal.split("#")[1];

      if (urlcountry == undefined||urlcountry=='') {
        //set the map to world view
        filterdata("W1")
      } else {
        areacode=urlcountry;
        filterdata(urlcountry)
        highlightcountry(urlcountry)
        disableHoverEvents();
      }
  }

  function changeURL(country){
     url = '#' + country;
     window.location.href = url;
     areacode=country;
  };


//gets the commodity codes
function getColumnNames(){
  //Get column names and number
        variables = [];
        for (var column in dataimports[0]) {
            if (column == "CountryName") continue;
            if (column == "CountryId") continue;
            variables.push(column);
        }

        //gets the last year in the dataset
        lastyear = variables[variables.length-1];
        createBarcode(lastyear)
}

function filterdata(code){
//get data for that country
countrydata_allI = dataimports.filter(function(d){return d.CountryId==code })
countrydata_allE = dataexports.filter(function(d){return d.CountryId==code })

// parse data into columns
var lines = {};

  lines["intheUK"] = [];
  lines["intheEU"] = [];

  for(i=0; i<variables.length; i++){
      lines["intheUK"].push({date:d3.timeParse("%Y")(variables[i].split("y")[1]),amt:+countrydata_allI[0][variables[i]]*1000000})
      lines["intheEU"].push({date:d3.timeParse("%Y")(variables[i].split("y")[1]),amt:+countrydata_allE[0][variables[i]]*1000000})
  }

  //find the min and max for the domain
  yMaxI=d3.max(lines["intheUK"],function(v){
    var n = v.amt;
    return Math.ceil(n)
  })

  yMaxE=d3.max(lines["intheEU"],function(v){
    var n = v.amt;
    return Math.ceil(n)
  })

  yMinI=d3.min(lines["intheUK"],function(v){
      var n = v.amt;
      return Math.floor(n)
    })

  yMinE=d3.min(lines["intheEU"],function(v){
      var n = v.amt;
      return Math.floor(n)
    })

  var yMax = d3.max([yMaxI,yMaxE])
  var yMin = d3.min([yMinI,yMinE])

  yLine.domain([+yMin,+yMax])

  // illions=[1000000,1000000000,1000000000000,1000000000000000]
  // illionNames=["£m","£m","£bn","£tn"]
  //
  // bandlimit=illions.find(function(e){return e>yMax})
  // bandindex=illions.indexOf(bandlimit)
  //
  // d3.select("#yaxislabel").text(illionNames[bandindex])

  //fmt=d3.format(".2s");
  fmt=d3.formatPrefix(",.1",1e9)
  fmt2=d3.formatPrefix(",.0",1e9)

  yAxisLine = d3.axisLeft(yLine)
                .tickFormat(function(d){if (d<1e10){
                                          return fmt(d).replace('M','').replace('T','').replace('G','')
                                        } else {
                                          return fmt2(d).replace('M','').replace('T','').replace('G','')
                                        }
                                      })
                .ticks(7)

  svgline.select(".y")
    .transition()
    .call(yAxisLine);

  svgline.select(".ygrid")
  .transition()
  .call(y_axis_grid()
      .tickSize(-chartWidth, 0, 0)
      .tickFormat('')
    );

  d3.select("#linechartsvg")
  .select('.importline')
  .data([lines["intheUK"]])
  .transition()
  .attr('d', function(d) {
      return line_gen(d);
  });

  d3.select("#linechartsvg")
  .select('.exportline')
  .data([lines["intheEU"]])
  .transition()
  .attr('d', function(d) {
      return line_gen(d);
  });



}//end filterdata

function getCentroids() {

			//centroid select cases where the centroid doesn't work
			centr = []

			centr['UK'] = ['[-1.41,52.7]'];
			centr['CL'] = ['[-72.94,-45.39]'];//Chile
			centr['CA'] = ['[-107.57,52.0]'];//Canada
			centr['US'] = ['[-101,39.23]'];//US
			centr['TH'] = ['[-1.41,52.7]'];//Thailand
			centr['NZ'] = ['[176,-39.27]'];//NZ
			centr['NO'] = ['[8.47,60.47]'];//Norway
			centr['GR'] = ['[22.06,39.19]'];//Greece
			centr['HR'] = ['[15.13,44.59]'];//Croatia
			centr['MY'] = ['[102.21,3.64]'];//Malaysia
      centr['PP'] = ['[143.32,-5.78]'];//Papua New Guinea
			centr['NL'] = ['[6.3,53.1]'];//Netherlands
			centr['FR'] = ['[2.21,46.22]'];//France
			centr['PO'] = ['[-9.14,38.7]'];//Portugal
			centr['AS'] = ['[-170.7, -14.3 ]'];//American Samoa
      centr['CI'] = ['[-5.5, 7.8]'];//Ivory Coast
      centr['CR'] = ['[-83.8, 9.9 ]'];//Nigeria

			d3.selectAll(".countries").attr("data-cd", function(d,i) {if(
        d.properties.fips == 'UK' ||
        d.properties.fips == 'CI' ||
        d.properties.fips== 'CA' ||
        d.properties.fips== 'US' ||
        d.properties.fips== 'TH' ||
        d.properties.fips== 'NZ' ||
        d.properties.fips== 'NO' ||
        d.properties.fips== 'GR' ||
        d.properties.fips== 'HR' ||
        d.properties.fips== 'MY' ||
        d.properties.fips== 'PP' ||
        d.properties.fips== 'FR' ||
        d.properties.fips== 'PO' ||
        d.properties.fips== 'AS' ||
        d.properties.fips== 'CR'

      )

					{return centr[d.properties.fips]} else
					{return "[" + d3.geoCentroid(d) + "]"}
			});

} //end Get Centriods



function highlightcountry(countrycode) {

    //Update dropdown
    $("#areaselect").val(countrycode).trigger('change.select2');

    //Draw barcode highlight rects on top of all bars
    if(mobile == false) {

      d3.selectAll("." + countrycode).each(fadeToFront);
      //Give map area a highlight class
      d3.select("#shape" + countrycode).classed("countries_highlights",true);

      //Draw arc from UK to destination
      var coordsfrom = d3.select("#shapeUK").attr("data-cd");
      var coordsto = d3.select("#shape" + countrycode).attr("data-cd");

      var lines = [];

      lines.push({
        type: "LineString",
        coordinates: JSON.parse("[" + coordsto + "," + coordsfrom + "]")
      });

      d3.select(".allcountry").selectAll(".mapArcsLow")
        .data(lines)
        .enter()
        .append("path")
        .attr("class", "mapArcsLow")
        .attr("d",path)
        .attr("stroke", "url(#svgGradient)")
        .attr("stroke-width", "2px")
        .style("stroke-linecap", 'round')
        .style("stroke-linejoin", 'round')
        .attr("fill","none")
        .attr("pointer-events", "none");

      //don't highlight countries with null as their code e.g. Western Sahara, West Bank
      if(countrycode==null){
        unhighlightcountry(null)
      }


    } else {
      d3.selectAll("." + countrycode).each(fadeToFront1);
    }

    //Get total values for imports/exports
    var importval = d3.select("#" + countrycode + "_I").attr("data-nm");
    var exportval = d3.select("#" + countrycode + "_E").attr("data-nm");

    //Get country name
    a = areacodes.indexOf(countrycode);
    countryname = areanames[a]

    //barcode labels
    d3.select("#importlabel").html("<p>into " + countryname +"</p><p class='labelbold'>£"+ d3.format(",.1f")(importval/1000) +"bn</p>")
    d3.select("#exportlabel").html("<p>from " + countryname +"</p><p class='labelbold'>£"+ d3.format(",.1f")(exportval/1000) +"bn</p>")

    //Update labels
    d3.select("#tradewith").html("Investments into/from " + countryname)

} //end highlightcountry



function unhighlightcountry(countrycode) {

  //update dropdown
	$("#areaselect").val("").trigger('change.select2');


	d3.select("#shape" + countrycode).classed("countries_highlights",false);
	d3.select(".mapArcsLow").remove();
	d3.selectAll(".highlights").remove();

  //Update labels
  d3.select("#tradewith").html("UK IIP, assets & liabilities <span style='font-weight:300'>2018</span>")

	d3.select("#shape" + countrycode).classed("countries_highlights",false);

	//reset barcode labels
	d3.select("#importlabel").html("<p>into</p>")
	d3.select("#exportlabel").html("<p>from</p>")

} //end unhighlightcountry


function createBarcode(lastyear){


  //Get data
	barcodeexports = dataimports.filter(function(d){return d.CountryId!="W1" });
	barcodeimports = dataexports.filter(function(d){return d.CountryId!="W1" });



	var barcodeWidth=parseInt(d3.select("#barcode").style("width"));

	var barcodemarginDT = [40,0, 10, 40];
	var barcodemarginMB = [80,10, 30, 90];


	var importsTotals = barcodeimports.map(function(d,i) {
        return {
  		CountryName: d.CountryName,
  		CountryId: d.CountryId,
  		total: d[lastyear]
  	  };
	});

	var exportsTotals = barcodeexports.map(function(d,i) {
	  return {
		CountryName: d.CountryName,
		CountryId: d.CountryId,
		total: d[lastyear]
	  };
	});

	//find max values of entire arrays (so that scale is kept constant)(first value is max)
	maxValue = d3.max([d3.max(barcodeimports, function(d) { return +d[lastyear];}), d3.max(barcodeexports, function(d) { return +d[lastyear];})])/1000;
  minValue = d3.min([d3.min(barcodeimports, function(d) { return +d[lastyear];}), d3.min(barcodeexports, function(d) { return +d[lastyear];})])/1000;

	chartWidth=parseInt(d3.select("#chartsnsparks").style("width"));

	if(chartWidth > mobileBreak-16) {

	mobile = false;

    //add labels

    barcodeLabels = d3.select("#barcode")
        .append("div")
		.attr("id","barcodelabels")
		.attr("class","hidden-xs")
		.html("<span style='font-weight:bold'>Investments</span> in 2018")
		.append("div")
        .style("padding-left",barcodemarginDT[3] + "px")
        .style("padding-right",barcodemarginDT[1] + "px")
        .style("width","calc(100%-" + barcodemarginDT[3]+ " - " + barcodemarginDT[1] + ")" )
        .style("height","10px")


    barcodeLabels.append("div").attr("id","importlabel").attr("class","col-sm-6").html("<p>into</p>");
    barcodeLabels.append("div").attr("id","exportlabel").attr("class","col-sm-6").html("<p>from</p>");

	var gap = 10;

	var barWidth = (barcodeWidth - barcodemarginDT[3] - gap) / 2;

	barcodeHeight=parseInt(d3.select("#mapDiv").style("height"))-25;
	barcodeWidth=parseInt(d3.select("#barcode").style("width"));

	//create y axis scale
	barcodeyScale=d3.scaleLinear()
    .domain([0,maxValue])
    //.domain([minValue,maxValue]) //if negative values
		.range([barcodeHeight-barcodemarginDT[0]-barcodemarginDT[2],0]);

	barcodePlot = d3.select("#barcode").append("svg")
		.attr("id","barcodeplot")
		.attr("width",barcodeWidth)
		.attr("height",barcodeHeight)
    .style("padding-top","10px");

	//create main axis
	yAxisChar=d3.axisLeft()
		.scale(barcodeyScale)
    .tickSize(barcodeWidth)
		.ticks(5);

// y axis label
    barcodePlot.append("text").attr("font-size","14px").attr("y",13).text("£bn")

	barcodeArea = barcodePlot.append("g")
		.attr("class","axis")
		.attr("transform","translate(" + (barcodemarginDT[3]+barcodeWidth) + "," + barcodemarginDT[0]+ ")")
		.call(yAxisChar);

	barcodeArea.append("g")
		.selectAll(".barcodeBarI")
		.data(importsTotals)
		.enter()
		.append("rect")
		.attr("id", function(d){return d.CountryId + "_I"})
		.attr("data-nm", function(d) {return d.total})
		.attr("fill",colour_palette[0])
		.attr("fill-opacity",0.2)
		.attr("stroke","#fff")
		.attr("stroke-opacity","0")
		.attr("stroke-width","2px")
		.attr("class", function(d){return "barcodeBarI " + d.CountryId})
		.attr("transform", "translate(" + eval(-barcodeWidth) + ",0)")
		.attr("y", function(d) {
				return barcodeyScale(d.total/1000);
		})
		.attr("height","2px")
		.attr("width",barWidth)
		.on("mouseover", function(){
			highlightcountry(this.id.slice(0, 2))
			filterdata(this.id.slice(0, 2));
		})
		.on("mouseout", function(){unhighlightcountry(this.id.slice(0, 2)),filterdata("W1")});

	barcodeArea.append("g")
		.selectAll(".barcodeBarE")
		.data(exportsTotals)
		.enter()
		.append("rect")
		.attr("id", function(d){return d.CountryId + "_E"})
		.attr("data-nm", function(d) {return d.total})
		.attr("fill",colour_palette[1])
		.attr("fill-opacity",0.2)
		.attr("stroke","#fff")
		.attr("stroke-opacity","0")
		.attr("stroke-width","2px")
		.attr("class", function(d){return "barcodeBare " + d.CountryId})
		.attr("transform", "translate(" + eval(barWidth + gap - barcodeWidth) + ",0)")
		.attr("y", function(d) {
				return barcodeyScale(d.total/1000);
		})
		.attr("height","2px")
		.attr("width",barWidth)
		.on("mouseover", function(){
			highlightcountry(this.id.slice(0, 2))
			filterdata(this.id.slice(0, 2));
		})
		.on("mouseout", function(){unhighlightcountry(this.id.slice(0, 2)),filterdata("W1")});
	} else {

		mobile = true;

		 barcodeLabels = d3.select("#barcode")
			.append("div")
			.attr("id","barcodelabels")
			.attr("class","hidden-sm")
			.html("<span style='font-weight:bold'>Investments</span> in 2017")
			.append("div")

		barcodeLabels.append("div").attr("id","importlabel").attr("class","col-sm-6").html("<p>into</p>");
		barcodeLabels.append("div").attr("id","exportlabel").attr("class","col-sm-6").html("<p>from</p>");


		var gap = 6;

		barcodeHeight=200;
		barcodeWidth=chartWidth;

		var barHeight = (barcodeHeight - barcodemarginMB[0] - barcodemarginMB[2] - gap) / 2;



		//create y axis scale
		barcodeyScale=d3.scaleLinear()
			.domain([0,maxValue])
			.range([0,barcodeWidth-barcodemarginMB[1]-barcodemarginMB[3]]);

		barcodePlot = d3.select("#barcode").append("svg")
			.attr("id","barcodeplot")
			.attr("width",barcodeWidth)
			.attr("height",barcodeHeight);

		//create main axis
		xAxisChar=d3.axisBottom()
			.scale(barcodeyScale)
			.tickSize(barcodeHeight-barcodemarginMB[0] - barcodemarginMB[2])
			.ticks(5);

		barcodeArea = barcodePlot.append("g")
			.attr("class","axis")
			.attr("transform","translate(" + barcodemarginMB[3] +"," + barcodemarginMB[0] + ")")
			.call(xAxisChar);

		barcodeArea.append("g")
			.selectAll(".barcodeBarI")
			.data(importsTotals)
			.enter()
			.append("rect")
			.attr("id", function(d){return d.CountryId + "_I"})
			.attr("data-nm", function(d) {return d.total})
			.attr("fill",colour_palette[0])
			.attr("fill-opacity",0.2)
			.attr("stroke","#fff")
			.attr("stroke-opacity","0")
			.attr("stroke-width","2px")
			.attr("class", function(d){return "barcodeBarI " + d.CountryId})
			.attr("transform", "translate(0,0)")
			.attr("x", function(d) {
					return barcodeyScale(d.total/1000);
			})
			.attr("width","2px")
			.attr("height",barHeight)
			.on("mouseover", function(){
				highlightcountry(this.id.slice(0, 2))
				filterdata(this.id.slice(0, 2));
			})
			.on("mouseout", function(){unhighlightcountry(this.id.slice(0, 2)),filterdata("W1")});

		barcodeArea.append("g")
			.selectAll(".barcodeBarE")
			.data(exportsTotals)
			.enter()
			.append("rect")
			.attr("id", function(d){return d.CountryId + "_E"})
			.attr("data-nm", function(d) {return d.total})
			.attr("fill",colour_palette[1])
			.attr("fill-opacity",0.2)
			.attr("stroke","#fff")
			.attr("stroke-opacity","0")
			.attr("stroke-width","2px")
			.attr("class", function(d){return "barcodeBarE " + d.CountryId})
			.attr("transform", "translate(0," + (barHeight + gap) + ")")
			.attr("x", function(d) {
					return barcodeyScale(d.total/1000);
			})
			.attr("width","2px")
			.attr("height",barHeight)
			.on("mouseover", function(){
				highlightcountry(this.id.slice(0, 2))
				filterdata(this.id.slice(0, 2));
			})
			.on("mouseout", function(){unhighlightcountry(this.id.slice(0, 2)),filterdata("W1")});

      //axis label
     barcodeArea.append("text").attr("font-size","14px").attr("x",chartWidth-100).attr("y",barcodeHeight/2+10).text("£bn")
	}

} // end createBarcode

//Moves SVG elements to the end of their container, so they appear "on top".
//Achieves a nice, smooth fade by duplicating the clicked element, moving the
//dupe to the front, then fading it in, while fading out the original element
//at the same time.
function fadeToFront() {

	//Select this element, that we want to move to front
	var orig = d3.select(this);
	var origNode = orig.node();

	//Clone it, and append the copy on "top" (meaning, at the end of
	var dupe = d3.select(origNode.parentNode.appendChild(origNode.cloneNode(true), origNode.nextSibling));

	//Make the new element transparent immediately, then fade it in over time
	dupe.style("fill-opacity", 0.3)
		.style("pointer-events","none")
		.attr("fill", "black")
		.attr("height","3px")
		.classed("highlights",true)
		.transition()
		.duration(200)
		.style("fill-opacity", 1.0)
		.on("end", function() {

		})


} //end fadeToFront

function fadeToFront1() {

	//Select this element, that we want to move to front
	var orig = d3.select(this);
	var origNode = orig.node();

	//Clone it, and append the copy on "top" (meaning, at the end of
	var dupe = d3.select(origNode.parentNode.appendChild(origNode.cloneNode(true), origNode.nextSibling));

	//Make the new element transparent immediately, then fade it in over time
	dupe.style("fill-opacity", 0.3)
		.style("pointer-events","none")
		.attr("fill", "black")
		.attr("width","3px")
		.classed("highlights",true)
		.transition()
		.duration(200)
		.style("fill-opacity", 1.0)
		.on("end", function() {

		})
} //end fadeToFront

function fadeToFront2() {

	//Select this element, that we want to move to front
	var orig = d3.select(this);
	var origNode = orig.node();

	//Clone it, and append the copy on "top" (meaning, at the end of
	var dupe = d3.select(origNode.parentNode.appendChild(origNode.cloneNode(true), origNode.nextSibling));

	//Make the new element transparent immediately, then fade it in over time
	dupe.attr("stroke", "none")
		.attr("paint-order",null)
		.attr("stroke-width",null);
} //end fadeToFront


function selectList() {
  //build the dropdown
	latestcountrydataI = dataimports;

	areacodes =  latestcountrydataI.map(function(d) { return d.CountryId; });
	areanames =  latestcountrydataI.map(function(d) { return d.CountryName; });
	var menuarea = d3.zip(areanames,areacodes).sort(function(a, b){ return d3.ascending(a[0], b[0]); });

	// Build option menu for occupations
	var optns = d3.select("#selectNav").append("div").attr("id","sel").append("select")
		.attr("id","areaselect")
		.attr("style","width:67%")
		.attr("class","chosen-select");


	optns.append("option")


	optns.selectAll("p").data(menuarea).enter().append("option")
		.attr("value", function(d){ return d[1]})
		.text(function(d){ return d[0]});

	myId=null;

 	$('#areaselect').select2({placeholder:"Choose a country",allowClear:true,dropdownParent:$('#sel')})

	$('#areaselect').on('change',function(){

			if($('#areaselect').val() != "") {

					d3.selectAll(".countries_highlights").classed("countries_highlights",false);
					d3.select(".mapArcsLow").remove();
					d3.selectAll(".highlights").remove();

					areacode = $('#areaselect').val();

					highlightcountry(areacode);
        	filterdata(areacode);
          changeURL(areacode)
					disableHoverEvents();

          //GTM stuff here
          dataLayer.push({
            'event':'worldtrademap',
            'countryselected':areacode
          })

			}

	});

	$("#areaselect").on("select2:unselect", function (e) {
          unhighlightcountry(areacode);
					enableHoverEvents();
          changeURL("")
	});

}; // end selectlist


function disableHoverEvents() {
  d3.select("#svgMap").selectAll("path").on("mouseover","").on("mouseout","")
	d3.select("#barcode").style("pointer-events","none");

}; //disableHoverEvents


function enableHoverEvents() {
	// d3.select("#svgMap").style("pointer-events","auto");

  d3.select("#svgMap").selectAll("path")
  .on("mouseover",function(d){
    highlightcountry(d.properties.fips);
    filterdata(d.properties.fips);
  })
  .on("mouseout",function(d){
      unhighlightcountry(d.properties.fips);
      filterdata("W1");
    })
	d3.select("#barcode").style("pointer-events","auto");

}; //enableHoverEvents


function enableZoom() {
	    d3.select('.zoom-control-zoom-in').on('click', function(){m.zoomIn()});
		d3.select('.zoom-control-zoom-out').on('click', function(){m.zoomOut()});

}; //enableHoverEvents

function barchartstart(){

    chartWidth=parseInt(d3.select("#chartsnsparks").style("width"))-margin.left-margin.right;
    height=chartWidth*0.25

    xLine = d3.scaleTime()
             .range([ 0, chartWidth]);

    yLine = d3.scaleLinear()
          .range([height,0])

    yAxisLine = d3.axisLeft(yLine)
                  .tickFormat(d3.formatPrefix(".1", "1e6"))
                  .ticks(7)

    if (parseInt(d3.select("#chartsnsparks").style("width")) < 600) {
      tickvalues=[new Date(2000, 0, 1),
                  new Date(2003, 0, 1),
                  new Date(2006, 0, 1),
                  new Date(2009, 0, 1),
                  new Date(2012, 0, 1),
                  new Date(2015, 0, 1),
                  new Date(2018, 0, 1)]
    }else{
      tickvalues=[new Date(2000, 0, 1), new Date(2002, 0, 1),
                  new Date(2004, 0, 1), new Date(2006, 0, 1),
                  new Date(2008, 0, 1), new Date(2010, 0, 1),
                  new Date(2012, 0, 1), new Date(2014, 0, 1),
                  new Date(2016, 0, 1), new Date(2018, 0, 1)]
    }

    xAxisLine= d3.axisBottom(xLine)
                  .tickValues(tickvalues)


    //gridlines
		y_axis_grid = function() { return yAxisLine; }

    line_gen = d3.line()
    .x(function(d) { return xLine(d.date); })
    .y(function(d) { return yLine(+d.amt); });

    xMin=d3.timeParse("%Y")(+variables[0].split("y")[1])
    xMax=d3.timeParse("%Y")(+variables[variables.length-1].split("y")[1])
    xLine.domain([xMin,xMax])


    svgline = d3.select("#linechart").append('svg')
          .attr("id","linechartsvg")
          .attr("width", chartWidth+margin.left+margin.right)
          .attr("height", height+margin.top + margin.bottom)
          .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


      svgline.append('g')
           .attr('class', 'x axis')
           .attr("transform", "translate(0," +height+")")
           .call(xAxisLine)
           .append("text")
           .attr("y", 25)
           .attr("x",7*chartWidth/8)
           .attr("dy", ".71em")
           .style("text-anchor", "end")
           .attr("font-size","12px")
           .attr("fill","#fff")
           // .text("£m");

       svgline.append('g')
             .attr('class', 'y axis')
             .attr("transform", "translate("+ -margin.left/2+",0)")
             .call(yAxisLine);

      svgline.append('g')
              .append("text")
              .attr("id","yaxislabel")
             .attr('transform','translate(' + -2*margin.left/3 + ',-5)')
             .attr("font-size","12px")
             .attr("fill","#666")
             .text("£bn");

       svgline.append('g')
           .attr('class', 'ygrid')
           .call(y_axis_grid()
               .tickSize(-chartWidth, 0, 0)
               .tickFormat('')
           );

        svgline.append('g').selectAll('path')
 			        .data([[{date:d3.timeParse("%Y")(1999),amt:0},{date:d3.timeParse("%Y")(2017),amt:4000000}]])
              // .data([linesexports["AL"]])
              .enter()
 			        .append('path')
              .attr("class",'importline')
   						.style("stroke", colour_palette[1] )
   						.style("fill", 'none')
   						.style("stroke-width", 3)
   						.style("stroke-linecap", 'round')
   						.style("stroke-linejoin", 'round')
	            .attr('d', function(d) {
	                return line_gen(d);
	            });


        svgline.append('g').selectAll('path')
               .data([[{date:d3.timeParse("%Y")(1999),amt:0},{date:d3.timeParse("%Y")(2017),amt:2000000}]])
               .enter()
               .append('path')
               .attr("class",'exportline')
               .style("stroke", colour_palette[0] )
               .style("fill", 'none')
               .style("stroke-width", 3)
               .style("stroke-linecap", 'round')
               .style("stroke-linejoin", 'round')
               .attr('d', function(d) {
                   return line_gen(d);
               });

      // draw a legend
      var legend = d3.select('#linechartsvg')
                  .append("g")
                  .attr("id", "legend");

      colour_palette.forEach(function(d,i){
        legend.append('rect')
              .attr("class","rect"+i)
              .attr("fill", colour_palette[(colour_palette.length+i)%2])
              .attr("x", 10+200*i)
							.attr("y", 10)
              .attr("width",20)
              .attr("height",3)

        legend.append("text")
								.text(legendLabels[i])
								.attr("class","legend" + i)
								.attr("text-anchor", "start")
								.style("font-size", "12px")
								.style("fill", "#666")
								.attr('y',15)
								.attr('x',32+200*i);
      })


}//end of barchartstart


//some code to stop select2 opening when clearing
$('#areaselect').on('select2:unselecting', function(ev) {
    if (ev.params.args.originalEvent) {
        // When unselecting (in multiple mode)
        ev.params.args.originalEvent.stopPropagation();
    } else {
        // When clearing (in single mode)
        $(this).one('select2:opening', function(ev) { ev.preventDefault(); });
        filterdata("W1")//set the it back to world view
    }
});


}//end ready
}//end modernizr
else {
  var pymChild = new pym.Child();
  setInterval(function(){pymChild.sendHeight();},1000)
}
