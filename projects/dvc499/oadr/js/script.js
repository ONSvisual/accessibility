
//test if browser supports webGL

if(Modernizr.webgl) {

	//setup pymjs
	var pymChild = new pym.Child();

	//Load data and config file
	d3.queue()
		.defer(d3.csv, "data/chnglem.csv")
		.defer(d3.json, "data/config.json")
		.defer(d3.json, "data/geogEngLA2017.json")
		.defer(d3.csv, "data/dummypop.csv")
		.await(ready);


	function ready (error, data, config, geog, popdata){

		//Set up global variables
		dvc = config.ons;
		oldAREACD = "";


		//get column name
		for (var column in data[0]) {
			if (column == 'AREACD') continue;
			if (column == 'AREANM') continue;
		}

		//set title of page
		//Need to test that this shows up in GA
		document.title = dvc.maptitle;

		//Fire design functions
		selectlist(data);

		//Set up number formats
		displayformat = d3.format("." + dvc.displaydecimals + "f");
		legendformat = d3.format("." + dvc.legenddecimals + "f");

		//set up basemap
		if(parseInt(d3.select('body').style("width"))<600){//if mobile use different divs
				map = new mapboxgl.Map({
				  container: 'mapMobile', // container id
				  style: 'data/style.json', //stylesheet location
				  center: [-2.5, 54], // starting position
				  zoom: 4.5, // starting zoom
				  maxZoom: 13, //
				  attributionControl: false
				});

				mapRight = new mapboxgl.Map({
				  container: 'mapRightMobile', // container id
				  style: 'data/style.json', //stylesheet location
				  center: [-2.5, 54], // starting position
				  zoom: 4.5, // starting zoom
				  maxZoom: 13, //
				  attributionControl: false
				});
		}else{//if larger use other divs
				map = new mapboxgl.Map({
				  container: 'map', // container id
				  style: 'data/style.json', //stylesheet location
				  center: [-2.5, 54], // starting position
				  zoom: 4.5, // starting zoom
				  maxZoom: 13, //
				  attributionControl: false
				});

				mapRight = new mapboxgl.Map({
				  container: 'mapRight', // container id
				  style: 'data/style.json', //stylesheet location
				  center: [-2.5, 54], // starting position
				  zoom: 4.5, // starting zoom
				  maxZoom: 13, //
				  attributionControl: false
				});
		}

		//add fullscreen option
		// map.addControl(new mapboxgl.FullscreenControl());

		// Add zoom and rotation controls to the map.
		map.addControl(new mapboxgl.NavigationControl());

		mapRight.addControl(new mapboxgl.NavigationControl());

		// Disable map rotation using right click + drag
		map.dragRotate.disable();
		mapRight.dragRotate.disable();

		// Disable map rotation using touch rotation gesture
		map.touchZoomRotate.disableRotation();
		mapRight.touchZoomRotate.disableRotation();


		// Add geolocation controls to the map.
		map.addControl(new mapboxgl.GeolocateControl({
			positionOptions: {
				enableHighAccuracy: true
			}
		}));

		mapRight.addControl(new mapboxgl.GeolocateControl({
			positionOptions: {
				enableHighAccuracy: true
			}
		}));

		//add compact attribution
		map.addControl(new mapboxgl.AttributionControl({
			compact: true
		}));

		mapRight.addControl(new mapboxgl.AttributionControl({
			compact: true
		}));


		//get column names and store them in an array
		var columnNames = [];

		for (var column in data[0]) {
			if (column == 'AREACD') continue;
			if (column == 'AREANM') continue;
			columnNames.push(column);
		}
//make a data object based on columnNames
		var dataById = {};

		data.forEach(function(d) {
			var dataByColumn = {};
			dataById[d.AREACD] = dataByColumn;
			for (i=0; i<columnNames.length; i++) {
				dataByColumn[columnNames[i]] = +d[columnNames[i]]
			}
		})

//make the stacked bar charts
		d3.select("#stacked").append("p").attr("id","keyunit").style("margin-top","0px").style("margin-left","10px").style("margin-bottom","0px").text("Population composition");

		margin = {top:10,
							right:30,
							left:40,
							bottom:40
							}

		if(parseInt(d3.select("body").style("width"))<600){
			aspectratio = 0.8
			margin = {top:10,
								right:0,
								left:35,
								bottom:40
								}
		}else{
			aspectratio = 1.2
			margin = {top:20,
								right:30,
								left:40,
								bottom:40
								}
		}

		stackedwidth = parseInt(d3.select("#stacked").style("width"))-margin.left-margin.right
		stackedheight = stackedwidth*aspectratio-margin.top-margin.bottom

		var x = d3.scaleBand()
							.rangeRound([0,stackedwidth])
							.paddingInner(0.1)


		var y = d3.scaleLinear()
						.rangeRound([stackedheight,0])

		var stackedcolour = d3.scaleOrdinal()
									.domain(["0 to 15","16 to 64","65 and over"])
									.range(["#0075A3","#266D4A","#E2BC22"])

		x.domain(d3.extent(columnNames))

		var xAxis = d3.axisBottom(x)
		 .tickPadding(5)
		 .tickFormat(function(d){return "mid-"+d.slice(1,5)});

		var yAxis = d3.axisLeft(y).ticks(5)
		var y_axis_grid = function() { return yAxis; }


		// draw the legend
		var legend = d3.select('#stacked').append('ul')
						.attr('class', 'key')
						.selectAll('g')
						.data(["0 to 15","16 to 64","65 and over"])
						.enter().append('li')
						.attr("class",function(d,i){return "key-" + i})

		legend.append('b')
		legend.append('label')
			.html(function(d,i) { return ["0 to 15","16 to 64","65 and over"][i]; });

		//make the svg
		var svg = d3.select('#stacked').append('svg')
		.attr("width", stackedwidth+ margin.left + margin.right)
		.attr("height", stackedwidth + margin.top + margin.bottom)
		.append("g")
		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		y.domain([0,100])

		svg.append('g')
		.attr('class', 'x axis')
		.attr('transform', 'translate(0,' + stackedheight + ')')
		.call(xAxis);

		svg.append('g')
			.attr('class', 'y axis')
			.call(yAxis)
			.append('g').append("text")
			.attr("fill","#000")
		  .attr("x", 4)
			.attr("y", -8)
			// .attr("dy", ".71em")
			// .style("text-anchor", "end")
			.text("%");



//code to calculate y0, y1 for each rectangle
popdata.forEach(function(d){
	d.cat = "y"+d.year

	cat=d.cat
	area=d.AREACD

	if(d.agegroup=="0 to 15"){d.y0 = +0}
	else if(d.agegroup=="16 to 64"){d.y0 = +popdata
		.filter(function(d){return d.AREACD==area})
		.filter(function(d){return d.cat===cat})
		.filter(function(d){return d.agegroup=="0 to 15"})[0].proportion}
	else if(d.agegroup=="65 and over"){d.y0 = +popdata
		.filter(function(d){return d.AREACD==area})
		.filter(function(d){return d.cat===cat})
		.filter(function(d){return d.agegroup=="0 to 15"})[0].proportion +
		+popdata
			.filter(function(d){return d.AREACD==area})
			.filter(function(d){return d.cat===cat})
			.filter(function(d){return d.agegroup=="16 to 64"})[0].proportion}

	if(d.agegroup=="0 to 15"){d.y1 = +d.proportion}
	else if(d.agegroup=="16 to 64"){d.y1 = +popdata
		.filter(function(d){return d.AREACD==area})
		.filter(function(d){return d.cat===cat})
		.filter(function(d){return d.agegroup=="0 to 15"})[0].proportion + +d.proportion}
	else if(d.agegroup=="65 and over"){d.y1 = +popdata
		.filter(function(d){return d.AREACD==area})
		.filter(function(d){return d.cat===cat})
		.filter(function(d){return d.agegroup=="0 to 15"})[0].proportion +
		+popdata
			.filter(function(d){return d.AREACD==area})
			.filter(function(d){return d.cat===cat})
			.filter(function(d){return d.agegroup=="16 to 64"})[0].proportion + +d.proportion}

})


		stackedbarwidth=x.bandwidth()
		//make some bars but set them to zero
		svg.append("g").attr("class", "g bars").selectAll("rect")
		.data(popdata.filter(function(d){return d.AREACD=="E06000001"}))
		.enter().append("rect")
		.attr("class",function(d,i){return "bar-" + i})
		.attr("x",function(d){return x(d.cat)})
		.attr("width", x.bandwidth())
		.attr("y", y(0))
		.attr("height", 0)
		.style("opacity", 0.85)
		.style("fill",function(d){return stackedcolour(d.agegroup)});




		rateById = {};
		areaById = {};

		data.forEach(function(d) { rateById[d.AREACD] = +eval("d." + dvc.varname1); areaById[d.AREACD] = d.AREANM});

		//Flatten data values and work out breaks
		// var values =  data.map(function(d) { return +eval("d." + dvc.varname); }).filter(function(d) {return !isNaN(d)}).sort(d3.ascending);

		var values = data.map(function(d) { return +eval("d." + columnNames[0]); }).filter(function(d) {return !isNaN(d)}).sort(d3.ascending);
		allvalues = [];

					for (var column in data[0]) {
						if (column != 'AREANM' && column != 'AREACD') {
						values[column] =  data.map(function(d) { return +eval("d." + column); }).filter(function(d) {return !isNaN(d)}).sort(d3.ascending);
						allvalues = allvalues.concat(values[column]);
						}
					}

		allvalues.sort(d3.ascending);

		if(config.ons.breaks =="jenks") {
			breaks = [];

			ss.ckmeans(allvalues, (dvc.numberBreaks)).map(function(cluster,i) {
				if(i<dvc.numberBreaks-1) {
					breaks.push(cluster[0]);
				} else {
					breaks.push(cluster[0])
					//if the last cluster take the last max value
					breaks.push(cluster[cluster.length-1]);
				}
			});
		}
		else if (config.ons.breaks == "equal") {
			breaks = ss.equalIntervalBreaks(values, dvc.numberBreaks);
		}
		else {breaks = config.ons.breaks;};


		//round breaks to specified decimal places
		breaks = breaks.map(function(each_element){
			return Number(each_element.toFixed(dvc.legenddecimals));
		});

		//work out halfway point (for no data position)
		midpoint = breaks[0] + ((breaks[dvc.numberBreaks] - breaks[0])/2)

		//Load colours
		if(typeof dvc.varcolour === 'string') {
			colour = colorbrewer[dvc.varcolour][dvc.numberBreaks];
		} else {
			colour = dvc.varcolour;
		}

		//set up d3 color scales
		color = d3.scaleThreshold()
				.domain(breaks.slice(1))
				.range(colour);

		//now ranges are set we can call draw the key
		createKey(config);

		//convert topojson to geojson
		for(key in geog.objects){
			var areas = topojson.feature(geog, geog.objects[key])
		}

		//Work out extend of loaded geography file so we can set map to fit total extent
		bounds = turf.extent(areas);

		//set map to total extent
		setTimeout(function(){
			map.fitBounds([[bounds[0],bounds[1]], [bounds[2], bounds[3]]])
		},1000);
		setTimeout(function(){
			mapRight.fitBounds([[bounds[0],bounds[1]], [bounds[2], bounds[3]]])
		},1000);


		//and add properties to the geojson based on the csv file we've read in
		areas.features.map(function(d,i) {//if(d.properties.AREACD!="E09000001"){
			d.properties.fill = color(rateById[d.properties.AREACD])
		  d.properties.fill2 = color(dataById[d.properties.AREACD]["y2026"])//colours for second map
		});

		map.on('load', function() {

			map.addSource('area', { 'type': 'geojson', 'data': areas });

			  map.addLayer({
				  'id': 'area',
				  'type': 'fill',
				  'source': 'area',
				  'layout': {},
				  'paint': {
					  'fill-color': {
							type: 'identity',
							property: 'fill',
					   },
					  'fill-opacity': 0.7,
					  'fill-outline-color': '#fff'
				  }
			  });

			//Get current year for copyright
			today = new Date();
			copyYear = today.getFullYear();
			map.style.sourceCaches['area']._source.attribution = "Contains OS data &copy; Crown copyright and database right " + copyYear;

			map.addLayer({
				"id": "state-fills-hover",
				"type": "line",
				"source": "area",
				"layout": {},
				"paint": {
					"line-color": "#000",
					"line-width": 2
				},
				"filter": ["==", "AREACD", ""]
			});

			  map.addLayer({
				  'id': 'area_labels',
				  'type': 'symbol',
				  'source': 'area',
				  'minzoom': 10,
				  'layout': {
					  "text-field": '{AREANM}',
					  "text-font": ["Open Sans","Arial Unicode MS Regular"],
					  "text-size": 14
				  },
				  'paint': {
					  "text-color": "#666",
					  "text-halo-color": "#fff",
					  "text-halo-width": 1,
					  "text-halo-blur": 1
				  }
			  });

			if(detectIE()){
				onMove = onMove.debounce(100);
				onLeave = onLeave.debounce(100);
			};

			//Highlight stroke on mouseover (and show area information)
			map.on("mousemove", "area", onMove);

			// Reset the state-fills-hover layer's filter when the mouse leaves the layer.
			map.on("mouseleave", "area", onLeave);

			//Add click event
			map.on("click", "area", onClick);

			//get location on click
			d3.select(".mapboxgl-ctrl-geolocate").on("click",geolocate);

		});//end on map load

		mapRight.on('load', function() {

			mapRight.addSource('area', { 'type': 'geojson', 'data': areas });

				mapRight.addLayer({
					'id': 'areaRight',
					'type': 'fill',
					'source': 'area',
					'layout': {},
					'paint': {
						'fill-color': {
							type: 'identity',
							property: 'fill2',
						 },
						'fill-opacity': 0.7,
						'fill-outline-color': '#fff'
					}
				});

			//Get current year for copyright
			today = new Date();
			copyYear = today.getFullYear();
			mapRight.style.sourceCaches['area']._source.attribution = "Contains OS data &copy; Crown copyright and database right " + copyYear;

			mapRight.addLayer({
				"id": "state-fills-hover-Right",
				"type": "line",
				"source": "area",
				"layout": {},
				"paint": {
					"line-color": "#000",
					"line-width": 2
				},
				"filter": ["==", "AREACD", ""]
			});

				mapRight.addLayer({
					'id': 'area_labels-Right',
					'type': 'symbol',
					'source': 'area',
					'minzoom': 10,
					'layout': {
						"text-field": '{AREANM}',
						"text-font": ["Open Sans","Arial Unicode MS Regular"],
						"text-size": 14
					},
					'paint': {
						"text-color": "#666",
						"text-halo-color": "#fff",
						"text-halo-width": 1,
						"text-halo-blur": 1
					}
				});

				if(detectIE()){
					onMove = onMove.debounce(100);
					onLeave = onLeave.debounce(100);
				};

				//Highlight stroke on mouseover (and show area information)
				mapRight.on("mousemove", "areaRight", onMove);

				// Reset the state-fills-hover layer's filter when the mouse leaves the layer.
				mapRight.on("mouseleave", "areaRight", onLeave);

				//Add click event
				mapRight.on("click", "areaRight", onClick);
		})//end mapright load


		if(parseInt(d3.select('body').style("width"))<600){
		d3.select

		new mapboxgl.Compare(map, mapRight);
		}else{

			//from http://bl.ocks.org/boeric/f6ddea14600dc5093506
			// coordination between the two maps
			  var disable = false;
			  map.on("move", function() {
			    if (!disable) {
			      var center = map.getCenter();
			      var zoom = map.getZoom();
			      var pitch = map.getPitch();
			      var bearing = map.getBearing();

			      disable = true;
			      mapRight.setCenter(center);
			      mapRight.setZoom(zoom);
			      mapRight.setPitch(pitch);
			      mapRight.setBearing(bearing);
			      disable = false;
			    }
			  })

			  mapRight.on("move", function() {
			    if (!disable) {
			      var center = mapRight.getCenter();
			      var zoom = mapRight.getZoom();
			      var pitch = mapRight.getPitch();
			      var bearing = mapRight.getBearing();

			      disable = true;
			      map.setCenter(center);
			      map.setZoom(zoom);
			      map.setPitch(pitch);
			      map.setBearing(bearing);
			      disable = false;
			    }
			  })

		}

		//test whether ie or not
		function detectIE() {
		  var ua = window.navigator.userAgent;

		  var msie = ua.indexOf('MSIE ');
		  if (msie > 0) {
			// IE 10 or older => return version number
			return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
		  }

		  var trident = ua.indexOf('Trident/');
		  if (trident > 0) {
			// IE 11 => return version number
			var rv = ua.indexOf('rv:');
			return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
		  }

		  var edge = ua.indexOf('Edge/');
		  if (edge > 0) {
			// Edge (IE 12+) => return version number
			return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
		  }

		  // other browser
		  return false;
		}

		function onMove(e) {
				newAREACD = e.features[0].properties.AREACD;

				if(newAREACD != oldAREACD) {
					oldAREACD = e.features[0].properties.AREACD;
					map.setFilter("state-fills-hover", ["==", "AREACD", e.features[0].properties.AREACD]);
					mapRight.setFilter("state-fills-hover-Right", ["==", "AREACD", e.features[0].properties.AREACD]);

					selectArea(e.features[0].properties.AREACD);
					setAxisVal(e.features[0].properties.AREACD);
					setStackedBars(e.features[0].properties.AREACD)
				}
		};


		function onLeave() {
				map.setFilter("state-fills-hover", ["==", "AREACD", ""]);
				mapRight.setFilter("state-fills-hover-Right", ["==", "AREACD", ""]);
				oldAREACD = "";
				$("#areaselect").val(null).trigger("change.select2");
				hideaxisVal();
				hideStackedBars();
		};

		function onClick(e) {
				disableMouseEvents();
				newAREACD = e.features[0].properties.AREACD;

				if(newAREACD != oldAREACD) {
					oldAREACD = e.features[0].properties.AREACD;
					map.setFilter("state-fills-hover", ["==", "AREACD", e.features[0].properties.AREACD]);
					mapRight.setFilter("state-fills-hover-Right", ["==", "AREACD", e.features[0].properties.AREACD]);
					selectArea(e.features[0].properties.AREACD);
					setAxisVal(e.features[0].properties.AREACD);
					setStackedBars(e.features[0].properties.AREACD)
				}
		};

		function disableMouseEvents() {
				map.off("mousemove", "area", onMove);
				map.off("mouseleave", "area", onLeave);

				mapRight.off("mousemove", "areaRight", onMove);
				mapRight.off("mouseleave", "areaRight", onLeave);
		}

		function enableMouseEvents() {
				map.on("mousemove", "area", onMove);
				map.on("click", "area", onClick);
				map.on("mouseleave", "area", onLeave);

				mapRight.on("mousemove", "areaRight", onMove);
				mapRight.on("click", "areaRight", onClick);
				mapRight.on("mouseleave", "areaRight", onLeave);
		}

		function selectArea(code) {
			$("#areaselect").val(code).trigger("change.select2");
		}

		function zoomToArea(code) {

			specificpolygon = areas.features.filter(function(d) {return d.properties.AREACD == code})

			specific = turf.extent(specificpolygon[0].geometry);

			map.fitBounds([[specific[0],specific[1]], [specific[2], specific[3]]], {
  				padding: {top: 150, bottom:150, left: 100, right: 100}
			});

		}

		function resetZoom() {

			map.fitBounds([[bounds[0], bounds[1]], [bounds[2], bounds[3]]]);

		}

		function setStackedBars(code){
			d3.select("#charts").select("#stacked").select("svg").select(".bars").selectAll("rect")
			.data(popdata.filter(function(d){return d.AREACD==code}))
			.transition()
			.duration(400)
			// .attr("width", stackedbarwidth)
			.attr("y", function(d){return y(d.y1)})
			.attr("height", function(d){return y(d.y0)-y(d.y1)})
		}

		function hideStackedBars(){
			d3.select("#charts").select("#stacked").select("svg").select(".bars").selectAll("rect")
			.transition()
			.duration(400)
			.attr("y", y(0))
			.attr("height", 0)
		}


		function setAxisVal(code) {
			d3.select("#currLine")
				.style("opacity", function(){if(!isNaN(rateById[code])) {return 0.3} else{return 0}})
				.transition()
				.duration(400)
				.attr("x1", function(){if(!isNaN(rateById[code])) {return x(rateById[code])} else{return x(midpoint)}})
				.attr("x2", function(){if(!isNaN(rateById[code])) {return x(rateById[code])} else{return x(midpoint)}});


			d3.select("#currVal")
				.text(function(){if(!isNaN(rateById[code]))  {return "mid-2016: "+displayformat(rateById[code])} else {return "Data unavailable"}})
				.style("opacity",1)
				.transition()
				.duration(400)
				.attr("x", function(){if(!isNaN(rateById[code])) {return x(rateById[code])} else{return x(midpoint)}});

			d3.select("#currLineRight")
				.style("opacity", function(){if(!isNaN(dataById[code]["y2026"])) {return 0.3} else{return 0}})
				.transition()
				.duration(400)
				.attr("x1", function(){if(!isNaN(dataById[code]["y2026"])) {return x(dataById[code]["y2026"])} else{return x(midpoint)}})
				.attr("x2", function(){if(!isNaN(dataById[code]["y2026"])) {return x(dataById[code]["y2026"])} else{return x(midpoint)}});


			d3.select("#currValRight")
				.text(function(){if(!isNaN(rateById[code]))  {return "mid-2026: "+displayformat(dataById[code]["y2026"])} else {return "Data unavailable"}})
				.style("opacity",1)
				.transition()
				.duration(400)
				.attr("x", function(){if(!isNaN(dataById[code]["y2026"])) {return x(dataById[code]["y2026"])} else{return x(midpoint)}});

		}

		function hideaxisVal() {
			d3.select("#currLine")
				.style("opacity",0)

			d3.select("#currVal").text("")
				.style("opacity",0)

			d3.select("#currLineRight")
				.style("opacity",0)

			d3.select("#currValRight").text("")
				.style("opacity",0)
		}

		function createKey(config){

			keywidth = d3.select("#keydiv").node().getBoundingClientRect().width;

			d3.select("#keydiv").append("p").attr("id","keyunit").style("margin-top","0px").style("margin-left","10px").style("margin-bottom","0px").text(dvc.varunit);

			var svgkey = d3.select("#keydiv")
				.append("svg")
				.attr("id", "key")
				.attr("width", "100%")
				.attr("height",90);


			var color = d3.scaleThreshold()
			   .domain(breaks)
			   .range(colour);

			// Set up scales for legend
			x = d3.scaleLinear()
				.domain([breaks[0], breaks[dvc.numberBreaks]]) /*range for data*/
				.range([0,keywidth-120]); /*range for pixels*/


			var xAxis = d3.axisBottom(x)
				.tickSize(15)
				.tickValues(color.domain())
				.tickFormat(legendformat);

			var g2 = svgkey.append("g").attr("id","horiz")
				.attr("transform", "translate(60,50)");


			keyhor = d3.select("#horiz");

			g2.selectAll("rect")
				.data(color.range().map(function(d,i) {

				  return {
					x0: i ? x(color.domain()[i+1]) : x.range()[0],
					x1: i < color.domain().length ? x(color.domain()[i+1]) : x.range()[1],
					z: d
				  };
				}))
			  .enter().append("rect")
				.attr("class", "blocks")
				.attr("height", 8)
				.attr("x", function(d) {
					 return d.x0; })
				.attr("width", function(d) {return d.x1 - d.x0; })
				.style("opacity",0.8)
				.style("fill", function(d) { return d.z; });


			g2.append("line")
				.attr("id", "currLine")
				.attr("x1", x(10))
				.attr("x2", x(10))
				.attr("y1", -10)
				.attr("y2", 8)
				.attr("stroke-width","2px")
				.attr("stroke","#000")
				.attr("opacity",0);

			g2.append("text")
				.attr("id", "currVal")
				.attr("x", x(10))
				.attr("y", -15)
				.attr("fill","#000")
				.text("");

			g2.append("line")
				.attr("id", "currLineRight")
				.attr("x1", x(10))
				.attr("x2", x(10))
				.attr("y1", -25)
				.attr("y2", 8)
				.attr("stroke-width","2px")
				.attr("stroke","#000")
				.attr("opacity",0);

			g2.append("text")
				.attr("id", "currValRight")
				.attr("x", x(10))
				.attr("y", -30)
				.attr("fill","#000")
				.text("");




			keyhor.selectAll("rect")
				.data(color.range().map(function(d, i) {
				  return {
					x0: i ? x(color.domain()[i]) : x.range()[0],
					x1: i < color.domain().length ? x(color.domain()[i+1]) : x.range()[1],
					z: d
				  };
				}))
				.attr("x", function(d) { return d.x0; })
				.attr("width", function(d) { return d.x1 - d.x0; })
				.style("fill", function(d) { return d.z; });

			keyhor.call(xAxis).append("text")
				.attr("id", "caption")
				.attr("x", -63)
				.attr("y", -20)
				.text("");

			keyhor.append("rect")
				.attr("id","keybar")
				.attr("width",8)
				.attr("height",0)
				.attr("transform","translate(15,0)")
				.style("fill", "#ccc")
				.attr("x",x(0));


			if(dvc.dropticks) {
				d3.select("#horiz").selectAll("text").attr("transform",function(d,i){
						// if there are more that 4 breaks, so > 5 ticks, then drop every other.
						if(i % 2){return "translate(0,10)"} }
				);
			}


	} // Ends create key

	function addFullscreen() {

		currentBody = d3.select("#map").style("height");
		d3.select(".mapboxgl-ctrl-fullscreen").on("click", setbodyheight)

	}

	function setbodyheight() {
		d3.select("#map").style("height","100%");

		document.addEventListener('webkitfullscreenchange', exitHandler, false);
		document.addEventListener('mozfullscreenchange', exitHandler, false);
		document.addEventListener('fullscreenchange', exitHandler, false);
		document.addEventListener('MSFullscreenChange', exitHandler, false);

	}


	function exitHandler() {

			if (document.webkitIsFullScreen === false)
			{
				shrinkbody();
			}
			else if (document.mozFullScreen === false)
			{
				shrinkbody();
			}
			else if (document.msFullscreenElement === false)
			{
				shrinkbody();
			}
		}

	function shrinkbody() {
		d3.select("#map").style("height",currentBody);
		pymChild.sendHeight();
	}

	function geolocate() {

		var options = {
		  enableHighAccuracy: true,
		  timeout: 5000,
		  maximumAge: 0
		};

		navigator.geolocation.getCurrentPosition(success, error, options);
	}

	function success(pos) {
	  crd = pos.coords;

	  //go on to filter
	  //Translate lng lat coords to point on screen
	  point = map.project([crd.longitude,crd.latitude]);

	  //then check what features are underneath
	  var features = map.queryRenderedFeatures(point);

	  //then select area
	  disableMouseEvents();

	  map.setFilter("state-fills-hover", ["==", "AREACD", features[0].properties.AREACD]);

	  selectArea(features[0].properties.AREACD);
	  setAxisVal(features[0].properties.AREACD);


	};

		function selectlist(datacsv) {

			var areacodes =  datacsv.map(function(d) { return d.AREACD; });
			var areanames =  datacsv.map(function(d) { return d.AREANM; });
			var menuarea = d3.zip(areanames,areacodes).sort(function(a, b){ return d3.ascending(a[0], b[0]); });

			// Build option menu for occupations
			var optns = d3.select("#selectNav").append("div").attr("id","sel").attr("style","padding-left:2%")
				.append("select")
				.attr("id","areaselect")
			 	.attr("style","width:98%")
				// .attr("class","chosen-select");


			optns.append("option")
				.attr("value",null)
				.text("");

			optns.selectAll("p").data(menuarea).enter().append("option")
				.attr("value", function(d){ return d[1]})
				.text(function(d){ return d[0]});

			// myId=null;

			$('#areaselect').select2({placeholder:"Choose an area",allowClear:true,dropdownParent:$('#sel')}).on('change',function(){

					if($('#areaselect').val() !="") {
							disableMouseEvents();

							map.setFilter("state-fills-hover", ["==", "AREACD", $('#areaselect').val()]);
							mapRight.setFilter("state-fills-hover-Right", ["==", "AREACD", $('#areaselect').val()]);
							selectArea($('#areaselect').val());
							setAxisVal($('#areaselect').val());

							zoomToArea($('#areaselect').val());
							setStackedBars($('#areaselect').val())

					}
					else {
							enableMouseEvents();
							hideaxisVal();
							onLeave();
							resetZoom();
							hideStackedBars();
					}

			});

	};//end of selectlist

	//some code to stop select2 opening when clearing
	$('#areaselect').on('select2:unselecting', function(ev) {
	    if (ev.params.args.originalEvent) {
	        // When unselecting (in multiple mode)
	        ev.params.args.originalEvent.stopPropagation();
	    } else {
	        // When clearing (in single mode)
	        $(this).one('select2:opening', function(ev) { ev.preventDefault(); });
	    }
	});

	}

} else {

	//provide fallback for browsers that don't support webGL
	d3.select('#map').remove();
	d3.select('body').append('p').html("Unfortunately your browser does not support WebGL. <a href='https://www.gov.uk/help/browsers' target='_blank>'>If you're able to please upgrade to a modern browser</a>")

}
