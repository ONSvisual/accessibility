
//test if browser supports webGL

if(Modernizr.webgl) {

	//setup pymjs
	var pymChild = new pym.Child();

	//Load data and config file
	d3.queue()
		.defer(d3.csv, "data/lamatrix.csv")
		.defer(d3.json, "data/config.json")
		.defer(d3.json, "data/geogEngEWLA2017.json")
		.await(ready);


	function ready (error, data, config, geog){
				
		areaselected = false;

		//Set up global variables
		dvc = config.ons;
		oldAREACD = "";
		firsthover = true;

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



		//add fullscreen option
		// map.addControl(new mapboxgl.FullscreenControl());

		// Add zoom and rotation controls to the map.
		//map.addControl(new mapboxgl.NavigationControl());

		mapRight.addControl(new mapboxgl.NavigationControl());

		// Disable map rotation using right click + drag
		map.dragRotate.disable();
		mapRight.dragRotate.disable();

		// Disable map rotation using touch rotation gesture
		map.touchZoomRotate.disableRotation();
		mapRight.touchZoomRotate.disableRotation();


		// Add geolocation controls to the map.
//		map.addControl(new mapboxgl.GeolocateControl({
//			positionOptions: {
//				enableHighAccuracy: true
//			}
//		}));

		mapRight.addControl(new mapboxgl.GeolocateControl({
			positionOptions: {
				enableHighAccuracy: true
			}
		}));

		//add compact attribution
//		map.addControl(new mapboxgl.AttributionControl({
//			compact: true
//		}));

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

		dataById = {};
		valuescol = []

		data.forEach(function(d) {
			if(d.AREACD == "E06000013") {
				for (i=0; i<columnNames.length; i++) {
						dataById[columnNames[i]] = +d[columnNames[i]]
						valuescol.push( +d[columnNames[i]]);
				}
			}
		})

		values = [];
		rateById = {};
		areaById = {};

		data.forEach(function(d) {
				 rateById[d.AREACD] = +eval("d." + "E06000013"); areaById[d.AREACD] = d.AREANM
				 values.push( +d["E06000013"]);
		});
		
		//Join flat arrays, remove null values, and sort
		allvalues = values.concat(valuescol).filter(function (value) {
			if(isNaN(value)==false) {return value};
		}).sort(d3.ascending);



		
		if(config.ons.breaks =="jenks") {
			breaks = [];

			ss.ckmeans(allvalues, (dvc.numberBreaks)).map(function(cluster,i) {
				if(i==0) {
				breaks.push(0);
			} else if(i<dvc.numberBreaks-2) {
				breaks.push(cluster[0]);
			} else if(i<dvc.numberBreaks-1){
				breaks.push(cluster[0])
				//if the last cluster take the last max value
				breaks.push(cluster[cluster.length-1]);
			} else {
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




		//and add properties to the geojson based on the csv file we've read in
		areas.features.map(function(d,i) {
			d.properties.fill = "#fff"
		    d.properties.fill2 = "#fff"//colours for second map
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
					  'fill-outline-color': '#AEAEAE'
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
				"id": "state-fills-click",
				"type": "line",
				"source": "area",
				"layout": {},
				"paint": {
					"line-color": "#FF9933",
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
						'fill-outline-color': '#AEAEAE'
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
				"id": "state-fills-click-Right",
				"type": "line",
				"source": "area",
				"layout": {},
				"paint": {
					"line-color": "#FF9933",
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
		  new mapboxgl.Compare(map, mapRight);
			d3.select("#map").style("top","0px")
			d3.select("#mapRight").style("top","0px")
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
			
	d3.select("#mapRight").style("top","0px")
	
	}



		//set map to total extent
		setTimeout(function(){
			map.fitBounds([[bounds[0],bounds[1]], [bounds[2], bounds[3]]])
		},1000);
		setTimeout(function(){
			mapRight.fitBounds([[bounds[0],bounds[1]], [bounds[2], bounds[3]]])
		},1000);




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
			
				map.getCanvasContainer().style.cursor = 'pointer';
				mapRight.getCanvasContainer().style.cursor = 'pointer';
				newAREACD = e.features[0].properties.AREACD;
				newAREANM = e.features[0].properties.AREANM;

				if(firsthover) {
					dataLayer.push({
						'event': 'mapHoverSelect',
						'selected': newAREACD
					})

					firsthover = false;
				}

				if(newAREACD != oldAREACD) {
					oldAREACD = e.features[0].properties.AREACD;
					map.setFilter("state-fills-hover", ["==", "AREACD", e.features[0].properties.AREACD]);
					mapRight.setFilter("state-fills-hover-Right", ["==", "AREACD", e.features[0].properties.AREACD]);

					//selectArea(e.features[0].properties.AREACD);
					setAxisVal(e.features[0].properties.AREACD, newAREANM);
					//setInteractionArea(newAREANM);
				}
		};


		function onLeave() {
				map.getCanvasContainer().style.cursor = null;
				mapRight.getCanvasContainer().style.cursor = null;
				
				map.setFilter("state-fills-hover", ["==", "AREACD", ""]);
				mapRight.setFilter("state-fills-hover-Right", ["==", "AREACD", ""]);
				oldAREACD = "";
				//$("#areaselect").val(null).trigger("change.select2");
				hideaxisVal();
				//resetInteractionArea();
		};

		function onClick(e) {
				//disableMouseEvents();
				areaselected = true;
				
				newAREACD = e.features[0].properties.AREACD;
				
					map.setFilter("state-fills-click", ["==", "AREACD", e.features[0].properties.AREACD]);
					map.setFilter("state-fills-hover", ["==", "AREACD", e.features[0].properties.AREACD]);
					mapRight.setFilter("state-fills-hover-Right", ["==", "AREACD", e.features[0].properties.AREACD]);
					mapRight.setFilter("state-fills-click-Right", ["==", "AREACD", e.features[0].properties.AREACD]);
					selectArea(e.features[0].properties.AREACD);
					//setAxisVal(e.features[0].properties.AREACD);
					
					updateLayers(newAREACD);
					
				dataLayer.push({
					'event':'mapClickSelect',
					'selected': newAREACD
				})

				
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
  				padding: {top: 180, bottom:180, left: 200, right: 200}
			});

		}

		function resetZoom() {

			map.fitBounds([[bounds[0], bounds[1]], [bounds[2], bounds[3]]]);

		}


		function setAxisVal(code, areaname) {

		if(areaselected ==true) {

			d3.select("#currVal")
				.text(function(){if(!isNaN(rateById[code]))  {return displayformat(Math.round(dataById[code]/10)*10) + " people coming from " + areaname} else {return "No flow"}})
				.style("opacity",1)
				.transition()
				.duration(0)
				//.attr("x", function(){if(!isNaN(rateById[code])) {return x(rateById[code])} else{return x(midpoint)}});
				
			d3.select("#currRect")
				.transition()
				.duration(700)
				.attr("width", function(){if(!isNaN(rateById[code])) {return x(Math.round(dataById[code]/10)*10) + "px"} else{return 0}})
				.style("fill", color(dataById[code]));


			d3.select("#currValRight")
				.text(function(){if(!isNaN(rateById[code]))  {return displayformat(Math.round(rateById[code]/10)*10) + " people going to " + areaname} else {return "No flow"}})
				.style("opacity",1)
				.transition()
				.duration(0)
				//.attr("x", function(){if(!isNaN(dataById[code])) {return x(dataById[code])} else{return x(midpoint)}});
				
			d3.select("#currRectRight")
				.transition()
				.duration(700)
				.attr("width", function(){if(!isNaN(rateById[code])) {return x(Math.round(rateById[code]/10)*10) + "px"} else{return 0}})
				.style("fill", color(rateById[code]));
				
		}

		}
		
//		function setInteractionArea(areaname) {
//			//d3.select("#keyunit")();
//			d3.select("#keyunit").html("to/from <span style='font-weight:bold'>" + areaname + "</span>");
//			
//		}
		
		function resetInteractionArea(areaname) {
			
			d3.select("#keyunit").html("&nbsp;");
			
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



		function updateLayers(areacode) {
	
			
			dataById = {};
			valuescol = []
	
			data.forEach(function(d) {
				if(d.AREACD == areacode) {
					for (i=0; i<columnNames.length; i++) {
							dataById[columnNames[i]] = +d[columnNames[i]]
							valuescol.push( +d[columnNames[i]]);
					}
				}
			})
	
			values = [];
			rateById = {};
			areaById = {};
	
			data.forEach(function(d) {
					 rateById[d.AREACD] = +eval("d." + areacode); areaById[d.AREACD] = d.AREANM
					 values.push( +d[areacode]);
			});

			
			//Join flat arrays, remove null values, and sort
			allvalues = values.concat(valuescol).filter(function (value) {
				if(isNaN(value)==false) {return value};
			}).sort(d3.ascending);
	
			if(config.ons.breaks =="jenks") {
				breaks = [];
				
				//console.log(ss.ckmeans(allvalues, (dvc.numberBreaks)))
	
				ss.ckmeans(allvalues, (dvc.numberBreaks)).map(function(cluster,i) {
					//console.log(cluster);
					
					if(i==0) {
						breaks.push(0);
					} else if(i<dvc.numberBreaks-2) {
						breaks.push(cluster[0]);
					} else if(i<dvc.numberBreaks-1){
						breaks.push(cluster[0])
						//if the last cluster take the last max value
						breaks.push(cluster[cluster.length-1]);
					} else {
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
			
			
			

			//update properties to the geojson based on the csv file we've read in
			areas.features.map(function(d,i) {
			   if(!isNaN(rateById[d.properties.AREACD])) {
				   d.properties.fill = color(rateById[d.properties.AREACD])
				   d.properties.fill2 = color(dataById[d.properties.AREACD])
				}
			   else {d.properties.fill = '#fff'
			   d.properties.fill2 = '#fff'};

			});

			//Reattach geojson data to area layer
			map.getSource('area').setData(areas);

			//set up style object
			styleObject = {
									type: 'identity',
									property: 'fill'
						}
						
			styleObject2 = {
									type: 'identity',
									property: 'fill2'
						}
			//repaint area layer map usign the styles above
			map.setPaintProperty('area', 'fill-color', styleObject);
			
			//Reattach geojson data to area layer
			mapRight.getSource('area').setData(areas);

			
			//repaint area layer map usign the styles above
			mapRight.setPaintProperty('areaRight', 'fill-color', styleObject2);

		}



	function createKey(config){

			d3.select("#key").remove();

			keywidth = d3.select("#keydiv").node().getBoundingClientRect().width;

			var svgkey = d3.select("#keydiv")
				.append("svg")
				.attr("id", "key")
				.attr("width", keywidth)
				.attr("height",100);


			var color = d3.scaleThreshold()
			   .domain(breaks)
			   .range(colour);

			// Set up scales for legend
			x = d3.scaleLinear()
				.domain([breaks[0], breaks[dvc.numberBreaks]]) /*range for data*/
				.range([0,keywidth-30]); /*range for pixels*/


			var xAxis = d3.axisBottom(x)
				.tickSize(15)
				.tickValues(color.domain())
				.tickFormat(legendformat);

			var g2 = svgkey.append("g").attr("id","horiz")
				.attr("transform", "translate(15,50)");


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


//			g2.append("line")
//				.attr("id", "currLine")
//				.attr("x1", x(10))
//				.attr("x2", x(10))
//				.attr("y1", -25)
//				.attr("y2", 8)
//				.attr("stroke-width","2px")
//				.attr("stroke","#000")
//				.attr("opacity",0);
			
			//bars rather than lines
			g2.append("rect")
				.attr("id", "currRect")
				.attr("height", 20)
				.attr("x", x(breaks[0]))
				.attr("y", -43)
				.attr("width", "0px")
				.style("opacity",0.8)
				.style("fill", color(breaks[0]));
				
			g2.append("rect")
				.attr("id", "currRectRight")
				.attr("height", 20)
				.attr("x", x(breaks[0]))
				.attr("y", -20)
				.attr("width", "0px")
				.style("opacity",0.8)
				.style("fill", color(breaks[0]));
			
			g2.append("text")
				.attr("id", "currVal")
				.attr("x", 3)
				.attr("y", -27)
				.attr("fill","#000")
				.text("");

	//		g2.append("line")
//				.attr("id", "currLineRight")
//				.attr("x1", x(10))
//				.attr("x2", x(10))
//				.attr("y1", -25)
//				.attr("y2", 8)
//				.attr("stroke-width","2px")
//				.attr("stroke","#000")
//				.attr("opacity",0);

			g2.append("text")
				.attr("id", "currValRight")
				.attr("x", 3)
				.attr("y", -15)
				.attr("fill","#000")
				.text("");




			
			//
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
			//Temporary	hardcode unit text
			dvc.unittext = "change in life expectancy";

			

	} // Ends create key

	
//
//
//
//
//	function addFullscreen() {
//
//		currentBody = d3.select("#map").style("height");
//		d3.select(".mapboxgl-ctrl-fullscreen").on("click", setbodyheight)
//
//	}
//
//	function setbodyheight() {
//		d3.select("#map").style("height","100%");
//
//		document.addEventListener('webkitfullscreenchange', exitHandler, false);
//		document.addEventListener('mozfullscreenchange', exitHandler, false);
//		document.addEventListener('fullscreenchange', exitHandler, false);
//		document.addEventListener('MSFullscreenChange', exitHandler, false);
//
//	}
//
//
//	function exitHandler() {
//
//		console.log("shrink");
//			if (document.webkitIsFullScreen === false)
//			{
//				shrinkbody();
//			}
//			else if (document.mozFullScreen === false)
//			{
//				shrinkbody();
//			}
//			else if (document.msFullscreenElement === false)
//			{
//				shrinkbody();
//			}
//		}
//
//	function shrinkbody() {
//		d3.select("#map").style("height",currentBody);
//		pymChild.sendHeight();
//	}
//
	function geolocate() {

		var options = {
		  enableHighAccuracy: true,
		  timeout: 5000,
		  maximumAge: 0
		};

		navigator.geolocation.getCurrentPosition(success, error, options);
	}
//
//	function success(pos) {
//	  crd = pos.coords;
//
//	  //go on to filter
//	  //Translate lng lat coords to point on screen
//	  point = map.project([crd.longitude,crd.latitude]);
//
//	  //then check what features are underneath
//	  var features = map.queryRenderedFeatures(point);
//
//	  //then select area
//	  disableMouseEvents();
//
//	  map.setFilter("state-fills-hover", ["==", "AREACD", features[0].properties.AREACD]);
//
//	  selectArea(features[0].properties.AREACD);
//	  setAxisVal(features[0].properties.AREACD);
//
//
//	};
//
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

			$('#areaselect').select2({placeholder:"Click on or choose an area",allowClear:true,dropdownParent:$('#sel')}).on('change',function(){

					if($('#areaselect').val() !="") {
							//disableMouseEvents();
							
							areaselected = true;

							map.setFilter("state-fills-hover", ["==", "AREACD", $('#areaselect').val()]);
							mapRight.setFilter("state-fills-hover-Right", ["==", "AREACD", $('#areaselect').val()]);
							map.setFilter("state-fills-click", ["==", "AREACD", $('#areaselect').val()]);
							mapRight.setFilter("state-fills-click-Right", ["==", "AREACD", $('#areaselect').val()]);
							selectArea($('#areaselect').val());
							//setAxisVal($('#areaselect').val());

							zoomToArea($('#areaselect').val());
							
							updateLayers($('#areaselect').val())
							
							dataLayer.push({
								'event': 'mapDropSelect',
								'selected': $('#areaselect').val()
							})
					}
					else {
							//enableMouseEvents();
							hideaxisVal();
							onLeave();
							resetZoom();
							
							dataLayer.push({
								'event': 'deselectCross',
								'selected': 'deselect'
							})
					}

			});

	};//end of selectlist


	}

} else {

	//provide fallback for browsers that don't support webGL
	d3.select('#map').remove();
	d3.select('body').append('p').html("Unfortunately your browser does not support WebGL. <a href='https://www.gov.uk/help/browsers' target='_blank>'>If you're able to please upgrade to a modern browser</a>")

}
