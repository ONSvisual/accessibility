
//test if browser supports webGL

if(Modernizr.webgl) {

	//setup pymjs
	var pymChild = new pym.Child();

	//Load data and config file
	d3.queue()
		.defer(d3.csv, "data/data.csv")
		.defer(d3.json, "data/config.json")
		.defer(d3.json, "data/geog.json")
		.await(ready);


	function ready (error, data, config, geog){

		//Set up global variables
		var dvc = config.ons;
		var oldAREACD = "";
		var selected = false;
		var firsthover = true;
		var map = null;
		var areas = null;
		var bounds = null;

		//Get column names
		variables = [];
		for (var column in data[0]) {
			if (column == 'AREACD') continue;
			if (column == 'AREANM') continue;
			variables.push(column);
		}

		a = dvc.varload;


		//BuildNavigation
		if(dvc.varlabels.length > 1)	{
			// buildNav();
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
		drawMap()

		//get location on click
		d3.select(".mapboxgl-ctrl-geolocate").on("click",geolocate);

		//addFullscreen();

		defineBreaks();

		setupScales();

		//now ranges are set we can call draw the key
		createKey(config);

		// convert topojson to geojson
		for(key in geog.objects){
			areas = topojson.feature(geog, geog.objects[key])
		}
		



		//and add properties to the geojson based on the csv file we've read in
		areas.features.map(function(d,i) {
		  if(!isNaN(rateById[d.properties.AREACD]))
		  	{d.properties.fill = color(rateById[d.properties.AREACD])}
		  else {d.properties.fill = '#ccc'};
		});

		map.on('load', defineLayers);

		if ($('html').hasClass('touch')) {
			map.scrollZoom.disable();
			map.dragPan.disable();
		};

		function drawMapNew () {
			var threshold_md = 650;
			var threshold_sm = dvc.optional.mobileBreakpoint;

			var innerPadding_values = {
				"sm": [20, 20, 30, 25],
				"md": [40, 20, 30, 25],
				"lg": [40, 25, 45, 45]
				/* top , right , bottom , left */
			}

			//var mapScales = [ 10000 , 6500 , 9000 ];
			var mapScales = [10000, 7000, 11000];

			//set variables for chart dimensions dependent on width of #graphic
			if (graphic.width() < threshold_sm) {
				var margin = {
					top: dvc.optional.margin_sm[0],
					right: dvc.optional.margin_sm[1],
					bottom: dvc.optional.margin_sm[2],
					left: dvc.optional.margin_sm[3]
				};
				chart_width = graphic.width()/* - margin.left - margin.right*/;
				mults_width = $("#mults").width();
				height = (Math.ceil((chart_width * dvc.optional.aspectRatio_sm[1]) / dvc.optional.aspectRatio_sm[0]) - margin.top - margin.bottom);

				var innerPadding = {
					top: innerPadding_values.sm[0],
					right: innerPadding_values.sm[1],
					bottom: innerPadding_values.sm[2],
					left: innerPadding_values.sm[3]
				}

				numberRows = parseInt(dvc.essential.numRows_sm_md_lg[0]);
				numberColumns = parseInt(dvc.essential.numColumns_sm_md_lg[0]);
				mapScale = mapScales[0];

			} else if (graphic.width() < threshold_md) {
				var margin = {
					top: dvc.optional.margin_md[0],
					right: dvc.optional.margin_md[1],
					bottom: dvc.optional.margin_md[2],
					left: dvc.optional.margin_md[3]
				};
				chart_width = graphic.width()/* - margin.left - margin.right*/;
				mults_width = $("#mults").width();
				height = (Math.ceil((chart_width * dvc.optional.aspectRatio_md[1]) / dvc.optional.aspectRatio_md[0]) - margin.top - margin.bottom);

				var innerPadding = {
					top: innerPadding_values.md[0],
					right: innerPadding_values.md[1],
					bottom: innerPadding_values.md[2],
					left: innerPadding_values.md[3]
				}

				numberRows = parseInt(dvc.essential.numRows_sm_md_lg[1]);
				numberColumns = parseInt(dvc.essential.numColumns_sm_md_lg[1]);
				mapScale = mapScales[1];

			} else {
				var margin = { top: dvc.optional.margin_lg[0], right: dvc.optional.margin_lg[1], bottom: dvc.optional.margin_lg[2], left: dvc.optional.margin_lg[3] }
				chart_width = graphic.width()/* - margin.left - margin.right*/;
				mults_width = $("#mults").width();
				height = (Math.ceil((chart_width * dvc.optional.aspectRatio_lg[1]) / dvc.optional.aspectRatio_lg[0]) - margin.top - margin.bottom);

				var innerPadding = { top: innerPadding_values.lg[0], right: innerPadding_values.lg[1], bottom: innerPadding_values.lg[2], left: innerPadding_values.lg[3] }

				numberRows = parseInt(dvc.essential.numRows_sm_md_lg[2]);
				numberColumns = parseInt(dvc.essential.numColumns_sm_md_lg[2]);
				mapScale = mapScales[2];

			}

			dvc.scale = 1;
			dvc.translate = [0, 0];





			zoom = d3.behavior.zoom()
				.scaleExtent([0.5, 12])
				.on("zoom", zoomed);

			// clear out existing graphics
			graphic.empty();
			keypoints.empty();
			footer.empty();


			//				//create legend
			//				if(dvc.essential.legendLabels.length > 1){
			//				var legend = d3.select('#graphic').append('ul')
			//								.attr('class', 'key')
			//							.selectAll('g')
			//								.data(dvc.essential.legendLabels)
			//							.enter().append('li')
			//	
			//						legend.append('b')
			//							 .attr("class",function(d,i){return "border" + i})
			//						
			//						legend.append('label')
			//							 .html(function(d,i) { return dvc.essential.legendLabels[i]; });						
			//				}		


			// calcualte SM graph dimensions, and set up maegins for base SM SVG
			var graph_unitWidth = (mults_width) / numberColumns;
			var graph_unitHeight = graph_unitWidth;
			var graph_unitMargins = { top: 5, right: 5, bottom: 5, left: 5 };


			var projection = d3.geo.albers()
				.center([3, 52.75])
				.rotate([3.2, 1])
				.parallels([50, 60])
				.scale(mapScale)
				.translate([graph_unitWidth / 2, graph_unitHeight / 2]);


			// Set up a scaling variable effectively tells D3 how to interpret your lat - long coordinates into pixel positions.	
			var path = d3.geo.path().projection(projection);


			// initial SM graph count variable (k = SM number being created	)		
			var k = 0;
			var l = 0;
			var graphLines = {};
			var currentColoumn;




			// for each row ... 				
			for (var i = 1; i <= parseInt(numberRows); i++) {




				// for each column ... 				
				for (var j = 1; j <= parseInt(numberColumns); j++) {

					// if graph panel [to draw] is greater than for which data is provided in data files ... 
					if (headers[k] === undefined) { continue; }


					// create and append small SVG panel for each individual graph, k
					var svg = d3.select('#graphic')
						.append('svg')
						.attr("class", "graphUnitSVGs")
						.attr("id", "svg" + k)
						.attr("x", function (d, i) { return (i - 1) * graph_unitWidth + graph_unitMargins.left; })
						.attr("y", (j - 1) * graph_unitHeight + graph_unitMargins.top)
						.attr("width", graph_unitWidth - 10)
						.attr("height", graph_unitHeight * 0.75)
						.append("g")
						.attr("transform", "translate(" + (0) + "," + (0) + ")");




					rateById = {};
					dvc.data.forEach(function (d, i) { rateById[d.AREACD] = [d[headers[k]]]; });



					var values = dvc.data.map(function (d) { return +d[headers[k]]; }).filter(function (d) { return !isNaN(d) }).sort(d3.ascending);

					if (dvc.essential.breaks == "jenks") {
						breaks = ss.jenks(values, dvc.essential.breakDivisions);



					} else {
						breaks = dvc.essential.breaks[k];
					};



					color = d3.scale.threshold()
						.domain(breaks.slice(1, dvc.essential.breakDivisions))
						.range(dvc.essential.colour);

					createKey(k, graph_unitWidth, graph_unitHeight, margin, innerPadding);





					// Use the normal d3 pattern - select all path elements (even though they haven't yet been created)
					// Then append a path element for every bit of data you've just binded.				
					g = svg.append("g").attr("id", "group_" + k);

					zoomed();

					g.attr("class", "pcon")
						.selectAll("path")
						.data(topojson.feature(dvc.pcon, dvc.pcon.objects.LA2013EW).features)
						.enter()
						.append("path")
						.attr("id", function (d) { return "reg" + d.properties.AREACD })
						.attr("data-nm", function (d) { return d.properties.AREANM })
						.attr("data_val", function (d) { return rateById[d.properties.AREACD] })
						.attr("d", path)
						.style("fill", function (d) {
							if (rateById[d.properties.AREACD] == "null" || rateById[d.properties.AREACD] == undefined) {
								return "white"
							} else if (rateById[d.properties.AREACD] == "0") {
								return "#c6dbef"
							} else {

								return color(rateById[d.properties.AREACD]);
							}
						})
						.style("stroke", function (d) {
							if (rateById[d.properties.AREACD] == "null" || rateById[d.properties.AREACD] == undefined) {
								return "#bdbdbd"
							} else {

								return "none";
							}
						})
						.on("mouseout", unhighlight)
						.on("mouseover", function (d) {
							highlight(d.properties.AREACD);
							plot(d.properties.AREACD);
						});




					// draw text in upper right corner of each graph with the associated title from data.csv
					svg.append("rect")/*
							.data(headers)*/
						.attr("x", 0)
						.attr("y", 0)
						.attr("height", 18)
						.attr("width", graph_unitWidth)
						.style("fill", "#fff")
						.style("stroke", "none")
						.style("opacity", 0.8);

					svg.append("text")
						.attr("x", 0)
						.attr("y", 12)
						.attr("id", "varval_" + k)
						.attr("class", "areaname")
						//							.attr("font-weight","bold")
						.attr("fill", "#666")
						.text(function () {
							var fmt = d3.format(".2f")
							if (area == undefined) {
								return headers[k];
							} else {
								linevalues = dvc.data.map(function (d) { return d; }).filter(function (d) { return d.AREACD == area });





								vals = d3.keys(linevalues[0]).filter(function (key) {
									if (dvc.essential.fieldsToIgnore.indexOf(key) == -1) { return key; }
								});

								if (linevalues[0][vals[k]] == "0") {
									return "less than 0.01% " + headers[i];
								} else {

									return (headers[k]) + ": " + fmt(linevalues[0][vals[k]]) + "";
								}
							}
						})




					svg.append("text")
						.attr("x", graph_unitWidth - 55)
						.attr("y", 12)
						//.attr("id", "varval_"+k)
						.attr("class", "percent_label")
						//.attr("font-weight","bold")
						.attr("fill", "#666")
						.text(function (d, i) { return dvc.essential.yAxisLabel[k] })



					k++;




				}

			} // end for ...

			center = [$("#svg0").width() / 2, $("#svg0").height() / 2];

			//			//create link to source				
			d3.select("#footer").append("p")
				.text("Source: ")
				.append("a")
				.attr("href", "https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/bulletins/annualmidyearpopulationestimates/mid2017")
				.attr("target", "_blank")
				.html("Population estimates for UK, England and Wales, Scotland and Northern Ireland: mid-2017, Office for National Statistics");


			d3.selectAll(".graphUnitSVGs").call(zoom)
				.call(zoom.event);




			//use pym to calculate chart dimensions	
			setTimeout(function () {
				if (pymChild) {
					pymChild.sendHeight();
				}
			}, 1500)


			return;
		}

		function plot(area) {

			linevalues = dvc.data.map(function (d) { return d; }).filter(function (d) { return d.AREACD == area });



			vals = d3.keys(linevalues[0]).filter(function (key) {
				if (dvc.essential.fieldsToIgnore.indexOf(key) == -1) { return key; }
			});


			for (i = 0; i < headers.length; i++) {

				//				
				//				
				//				var values =  dvc.data.map(function(d) { return +d[headers[i]]; }).filter(function(d){ return !isNaN(d)}).sort(d3.ascending);
				//						
				//				if(dvc.essential.breaks =="jenks"){
				//							breaks = ss.jenks(values, dvc.essential.breakDivisions);
				//				} else {
				//					breaks = dvc.essential.breaks[i];
				//				};
				//					
				//				
				//				xScale = d3.scale.linear()
				//					.domain([breaks[0], breaks[dvc.essential.breakDivisions]]) /*range for data*/
				//					.range([0, key_svg-30 ]); /*range for pixels*/


				//				d3.select("#variable_"+i)
				//					.transition()
				//					.duration(400)
				//					.attr("x1", function(){
				//						if(linevalues[0][vals[i]]==".."||[vals[i]]=="undefined"){
				//							return -200;
				//						} else {
				//							return xScale(linevalues[0][vals[i]])
				//						}
				//						
				//					})
				//					.attr("x2", function(){
				//						if(linevalues[0][vals[i]]==".."||[vals[i]]=="undefined"){
				//							return -200;
				//						} else {
				//							return xScale(linevalues[0][vals[i]])
				//						}
				//						
				//					})
				//					.attr("y2", 25);





				//				d3.select("#box_"+i)
				//					.transition()
				//					.duration(400)
				//					.attr("x",function(){
				//						if(linevalues[0][vals[i]]==".."||[vals[i]]=="undefined"){
				//							return -200;
				//						} else {
				//							return xScale(linevalues[0][vals[i]])-3
				//						}
				//					})




				d3.select("#varval_" + i)
					//.transition()
					//.duration(400)
					//					.attr("x", function(){
					//						if(linevalues[0][vals[i]]==".."||[vals[i]]=="undefined"){
					//							return -200;
					//						} else {
					//							return xScale(linevalues[0][vals[i]])
					//						}
					//						
					//					})
					.text(function () {
						var fmt = d3.format(".2f")
						if (linevalues[0][vals[i]] == "null" || [vals[i]] == "undefined") {
							return headers[i];
						} else if (linevalues[0][vals[i]] == "0") {
							return "less than 0.01% " + headers[i];
						} else {
							return /*numFormat*/headers[i] + ": " + fmt(linevalues[0][vals[i]]) + dvc.essential.unitofmeasure[i]; //changethis
							//return /*numFormat*/fmt(linevalues[0][vals[i]])+" "+headers[i];;
						}
					})

			}

		}

		function highlight(area) {
			var reg = document.getElementById("reg" + area);

			var name = d3.select("#reg" + area).attr("data-nm")
			dataLayer.push({
				'event': 'mapHoverSelect',
				'selected': name
			})

			d3.selectAll('.pcon')
				.append("path")
				.attr("d", d3.select(reg).attr("d"))
				.attr("id", "selected")
				.attr("class", "arcSelection")
				.attr("pointer-events", "none")
				.style("fill", "none")
				.style("stroke", function (d) {
					if (area.substr(0, 1) == "E") {
						return "#990000"
					}
					else if (area.substr(0, 1) == "W") {
						return "#990000"
					}
					else if (area.substr(0, 1) == "S") {
						return "#990000"
					}
					else if (area.substr(0, 1) == "N") {
						return "#990000"
					}
				})
				.style("stroke-width", 2 / dvc.scale);

			details = d3.select("#details")

			if (area.substr(0, 1) == "E") {
				d3.select("#areanm").text(name);
			}

			else if (area.substr(0, 1) == "N") {
				d3.select("#areanm").text(name);
			}

			else if (area.substr(0, 1) == "W") {
				d3.select("#areanm").text(name);
			}

			else if (area.substr(0, 1) == "S") {
				d3.select("#areanm").text(name);
			}
		}

		/* Remove the current selected polygon */
		function unhighlight() {
			d3.selectAll('#selected').remove();
			d3.select("#areanm").text("");
			d3.selectAll(".areaname").text(function (d, i) { return headers[i]; })
		}

		function zoomed() {

			dvc.scale = zoom.scale();

			d3.selectAll(".pcon").style("stroke-width", (0.5 / zoom.scale()))
				.attr("transform", "translate(" + zoom.translate() + ")scale(" + zoom.scale() + ")");


		}


		function zoom_by(factor) {

			var scale = zoom.scale(),
				extent = zoom.scaleExtent(),
				translate = zoom.translate(),
				x = translate[0], y = translate[1],
				target_scale = scale * factor;

			// If we're already at an extent, done
			if (target_scale === extent[0] || target_scale === extent[1]) { return false; }
			// If the factor is too much, scale it down to reach the extent exactly
			var clamped_target_scale = Math.max(extent[0], Math.min(extent[1], target_scale));
			if (clamped_target_scale != target_scale) {
				target_scale = clamped_target_scale;
				factor = target_scale / scale;
			}

			// Center each vector, stretch, then put back
			x = (x - center[0]) * factor + center[0];
			y = (y - center[1]) * factor + center[1];

			dvc.scale = zoom.scale();
			dvc.translate = zoom.translate();


			// Enact the zoom immediately
			zoom.scale(target_scale)
				.translate([x, y]);

			zoomed();


		}

		function zoomcontrols() {

			zoomcontrols = d3.select("#graphic").append('div').attr("class", "zoom-container zoom-control-zoom zoom-bar zoom-control");

			zoomcontrols.append("a").attr("id", "zoom_in").attr("class", "zoom-control-zoom-in zoom-bar-part zoom-bar-part-top").attr("title", "Zoom in").text("+")
			zoomcontrols.append("a").attr("id", "zoom_out").attr("class", "zoom-control-zoom-out zoom-bar-part zoom-bar-part-bottom").attr("title", "Zoom out").text(" -")

			var intervalID;

			d3.selectAll('.zoom-bar-part').on('mousedown', function () {

				d3.event.preventDefault();
				var factor = (this.id === 'zoom_in') ? 1.1 : 1 / 1.1;
				intervalID = setInterval(zoom_by, 40, factor);

			}).on('mouseup', function () {
				d3.event.preventDefault();
				clearInterval(intervalID);
				intervalID = undefined;
			})

		}


		function updateHash() {


			window.location.hash = encodeURI(area);


		}


		function drawMap () {
			map = new mapboxgl.Map({
				container: 'map', // container id
				style: 'data/style.json', //stylesheet location //includes key for API
				center: [-2.5, 54], // starting position
				minZoom: 3.5,//
				zoom: 4.5, // starting zoom
				maxZoom: 13, //
				attributionControl: false //
			});
			//add fullscreen option
			//map.addControl(new mapboxgl.FullscreenControl());

			// Add zoom and rotation controls to the map.
			map.addControl(new mapboxgl.NavigationControl());

			// Disable map rotation using right click + drag
			map.dragRotate.disable();

			// Disable map rotation using touch rotation gesture
			map.touchZoomRotate.disableRotation();

			// Add geolocation controls to the map.
			map.addControl(new mapboxgl.GeolocateControl({
				positionOptions: {
					enableHighAccuracy: true
				}
			}));

			//add compact attribution
			map.addControl(new mapboxgl.AttributionControl({
				compact: true
			}));

			//Work out extend of loaded geography file so we can set map to fit total extent
			console.log('areas', areas)
			console.log('bounds', bounds)
			// bounds = turf.extent(areas);

			//set map to total extent
			// setTimeout(function () {
			// 	map.fitBounds([[bounds[0], bounds[1]], [bounds[2], bounds[3]]])
			// }, 1000);
		}
		function buildNav() {

			fieldset=d3.select('#nav').append('fieldset');

			fieldset
			.append('legend')
			.attr('class','visuallyhidden')
			.html('Choose a variable');

			fieldset
			.append("div")
			.attr('class','visuallyhidden')
			.attr('aria-live','polite')
			.append('span')
			.attr('id','selected');

			grid=fieldset.append('div')
			.attr('class','grid grid--full large-grid--fit');

			cell=grid.selectAll('div')
			.data(dvc.varlabels)
			.enter()
			.append('div')
			.attr('class','grid-cell');

			cell.append('input')
			.attr('type','radio')
			.attr('class','visuallyhidden')
			.attr('id',function(d,i){return 'button'+i;})
			.attr('value',function(d,i){return i;})
			.attr('name','button');

			cell.append('label')
			.attr('for',function(d,i){return 'button'+i;})
			.html(function(d){return d;});

			d3.selectAll('input[type="radio"]').on('change', function(d) {
				onchange(document.querySelector('input[name="button"]:checked').value);
				d3.select('#selected').text(dvc.varlabels[document.querySelector('input[name="button"]:checked').value] + " is selected");
			});

			d3.select('#button'+dvc.varload).property('checked',true);
			d3.select('#selected').text(dvc.varlabels[document.querySelector('input[name="button"]:checked').value] + " is selected");

		// formgroup = d3.select('#nav')
		// 			.append('form')
		// 			.attr('class','btn-form-fullwidth')
		// 			.attr('role','radiogroup')
		// 			.selectAll('div')
		// 			.data(dvc.varlabels)
		// 			.enter()
		// 			.append('div')
		// 			.attr("class",'form-group-fullwidth')
		// 			.attr("role","radio")
		// 			.attr("tabindex", function(d,i){return 0})
		//
		// formgroup.append('input')
		// 	.attr("id",function(d,i){return "button" + i})
		// 	.attr('class','radio-primary-fullwidth')
		// 	.attr("type","radio")
		// 	.attr("name","button")
		// 	.attr("value",function(d,i){return i})
		// 	.attr("aria-checked", function(d,i){if(i == dvc.varload){return "true"}})
		// 	.property("checked", function(d, i) {return i===dvc.varload;})
		//
		// formgroup.append('label')
		// 	.attr('class','label-primary-fullwidth')
		// 	.attr("for",function(d,i){return "button" + i})
		// 	.text(function(d,i){return dvc.varlabels[i]})
		// 	.on('click',function(d,i){onchange(i)})


			var container = d3.select('#selectnav')

			container.append('label')
				.attr('for', 'selectlistMobile')
				.attr('class', 'visuallyhidden')
				.text('Choose from selection');

			selectgroup = container
				.append('select')
				.attr('class', 'dropdown')
				.attr('id', 'selectlistMobile')
				.on('change', onselect)
				.selectAll("option")
				.data(dvc.varlabels)
				.enter()
				.append('option')
				.attr("value", function (d, i) { return i })
				.property("selected", function (d, i) { return i === dvc.varload; })
				.text(function (d, i) { return dvc.varlabels[i] });


		}

		function defineBreaks(){

			rateById = {};
			areaById = {};

			data.forEach(function(d) {rateById[d.AREACD] = +d[variables[a]]; areaById[d.AREACD] = d.AREANM}); //change to brackets


			//Flatten data values and work out breaks
			if(config.ons.breaks =="jenks" || config.ons.breaks =="equal") {
				var values =  data.map(function(d) { return +d[variables[a]]; }).filter(function(d) {return !isNaN(d)}).sort(d3.ascending);
			};

			if(config.ons.breaks =="jenks") {
				breaks = [];

				ss.ckmeans(values, (dvc.numberBreaks)).map(function(cluster,i) {
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
			else {breaks = config.ons.breaks[a];};


			//round breaks to specified decimal places
			breaks = breaks.map(function(each_element){
				return Number(each_element.toFixed(dvc.legenddecimals));
			});

			//work out halfway point (for no data position)
			midpoint = breaks[0] + ((breaks[dvc.numberBreaks] - breaks[0])/2)

		}

		function setupScales() {
			//set up d3 color scales
			//Load colours
			if(typeof dvc.varcolour === 'string') {
				color=chroma.scale(dvc.varcolour).colors(dvc.numberBreaks)
				colour=[]
				color.forEach(function(d){colour.push(chroma(d).darken(0.4).saturate(0.6).hex())})
				// colour = colorbrewer[dvc.varcolour][dvc.numberBreaks];
			} else {
				colour = dvc.varcolour;
			}

			//set up d3 color scales
			color = d3.scaleThreshold()
					.domain(breaks.slice(1))
					.range(colour);

		}

		function defineLayers() {

			map.addSource('area', { 'type': 'geojson', 'data': areas });

			  map.addLayer({
				  'id': 'area',
				  'type': 'fill',
				  'source': 'area',
				  'touchAction':'none',
				  'layout': {},
				  'paint': {
					  'fill-color': {
							type: 'identity',
							property: 'fill'
					   },
					  'fill-opacity': 0.7,
					  'fill-outline-color': '#fff'
				  }
			  }, 'place_city');

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
			}, 'place_city');

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


			if(detectIE()){
				onMove = onMove.debounce(200);
				onLeave = onLeave.debounce(200);
			};

			//Highlight stroke on mouseover (and show area information)
			map.on("mousemove", "area", onMove);

			// Reset the state-fills-hover layer's filter when the mouse leaves the layer.
			map.on("mouseleave", "area", onLeave);

			//Add click event
			map.on("click", "area", onClick);




		}


		function updateLayers() {

			//update properties to the geojson based on the csv file we've read in
			areas.features.map(function(d,i) {
			   if(!isNaN(rateById[d.properties.AREACD]))
			    {d.properties.fill = color(rateById[d.properties.AREACD])}
			   else {d.properties.fill = '#ccc'};

			});

			//Reattach geojson data to area layer
			map.getSource('area').setData(areas);

			//set up style object
			styleObject = {
									type: 'identity',
									property: 'fill'
						}
			//repaint area layer map usign the styles above
			map.setPaintProperty('area', 'fill-color', styleObject);

		}


		function onchange(i) {

			a = i;

			defineBreaks();
			setupScales();
			createKey(config);

			if(selected) {
				setAxisVal($("#areaselect").val());
			}
			updateLayers();

			dataLayer.push({
          'event': 'navSelect',
          'selected': i
      })
		}

		function onselect() {
			a = $(".dropdown").val();
			onchange(a);
		}


		function onMove(e) {
			// console.log(e)

				map.getCanvasContainer().style.cursor = 'pointer';

				newAREACD = e.features[0].properties.AREACD;



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

					selectArea(e.features[0].properties.AREACD);
					setAxisVal(e.features[0].properties.AREACD);

				}
		};


		function onLeave() {
				map.getCanvasContainer().style.cursor = null;
				map.setFilter("state-fills-hover", ["==", "AREACD", ""]);
				oldAREACD = "";
				$("#areaselect").val(null).trigger('chosen:updated');
				hideaxisVal();
		};

		function onClick(e) {
				disableMouseEvents();
				newAREACD = e.features[0].properties.AREACD;

				if(newAREACD != oldAREACD) {
					oldAREACD = e.features[0].properties.AREACD;
					map.setFilter("state-fills-hover", ["==", "AREACD", e.features[0].properties.AREACD]);

					selectArea(e.features[0].properties.AREACD);
					setAxisVal(e.features[0].properties.AREACD);
				}

				dataLayer.push({
            'event':'mapClickSelect',
            'selected': newAREACD
        })
		};

		function disableMouseEvents() {
				map.off("mousemove", "area", onMove);
				map.off("mouseleave", "area", onLeave);

				selected = true;
		}

		function enableMouseEvents() {
				map.on("mousemove", "area", onMove);
				map.on("click", "area", onClick);
				map.on("mouseleave", "area", onLeave);

				selected = false;
		}

		function selectArea(code) {
			$("#areaselect").val(code).trigger('chosen:updated');
			d3.select('abbr').on('keypress',function(evt){
				if(d3.event.keyCode==13 || d3.event.keyCode==32){
					d3.event.preventDefault();
					onLeave();
					resetZoom();
				}
			})
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


		function setAxisVal(code) {
			d3.select('#accessibilityInfo').select('p.visuallyhidden')
			.text(function(){
				if (!isNaN(rateById[code])) {
					return areaById[code]+": "+ displayformat(rateById[code]) +" "+ dvc.varunit[a];
				} else {
					return "Data unavailable";
				}
			});


			d3.select("#currLine")
				.style("opacity", function(){if(!isNaN(rateById[code])) {return 1} else{return 0}})
				.transition()
				.duration(400)
				.attr("x1", function(){if(!isNaN(rateById[code])) {return x(rateById[code])} else{return x(midpoint)}})
				.attr("x2", function(){if(!isNaN(rateById[code])) {return x(rateById[code])} else{return x(midpoint)}});


			d3.select("#currVal")
				.text(function(){if(!isNaN(rateById[code]))  {return displayformat(rateById[code])} else {return "Data unavailable"}})
				.style("opacity",1)
				.transition()
				.duration(400)
				.attr("x", function(){if(!isNaN(rateById[code])) {return x(rateById[code])} else{return x(midpoint)}});

		}

		function hideaxisVal() {
			d3.select("#currLine")
				.style("opacity",0)

			d3.select("#currVal").text("")
				.style("opacity",0)
		}

		function createKey(config){

			d3.select("#keydiv").selectAll("*").remove();

			keywidth = d3.select("#keydiv").node().getBoundingClientRect().width;

			var svgkey = d3.select("#keydiv")
				.append("svg")
				.attr("id", "key")
				.attr('aria-hidden','true')
				.attr("width", keywidth)
				.attr("height",75);


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
				.attr("transform", "translate(15,35)");


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

			//label the units
			d3.select("#keydiv").append("p").attr("id","keyunit").attr('aria-hidden',true).style("margin-top","-10px").style("margin-left","10px").style('font-size','14px').text(dvc.varunit[a]);

	} // Ends create key

	pymChild.sendHeight();

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
		dataLayer.push({
								'event': 'geoLocate',
								'selected': 'geolocate'
		})

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
			var optns = d3.select("#selectNav").append("div").attr("id", "sel")
				.append("select")
				.attr("id", "areaselect")
				.attr("style", "width:calc(100% - 6px)")
				.attr("class", "chosen-select");

			optns.append("option")
				// .attr("value","first")
				// .text("");

			optns.selectAll("p").data(menuarea).enter().append("option")
				.attr("value", function(d){ return d[1]})
				.attr("id",function(d){return d[1]})
				.text(function(d){ return d[0]});

			myId=null;

			 $('#areaselect').chosen({placeholder_text_single:"Select an area",allow_single_deselect:true})

			 d3.select('input.chosen-search-input').attr('id','chosensearchinput')
	     d3.select('div.chosen-search').insert('label','input.chosen-search-input').attr('class','visuallyhidden').attr('for','chosensearchinput').html("Type to select an area")

			$('#areaselect').on('change',function(){

					if($('#areaselect').val() != "") {
							areacode = $('#areaselect').val()

							disableMouseEvents();

							map.setFilter("state-fills-hover", ["==", "AREACD", areacode]);

							selectArea(areacode);
							setAxisVal(areacode);
							// zoomToArea(areacode);

							dataLayer.push({
                  'event': 'mapDropSelect',
                  'selected': areacode
              })
					}
					else {
							dataLayer.push({
									'event': 'deselectCross',
									'selected': 'deselect'
							})

							enableMouseEvents();
							hideaxisVal();
							onLeave();
							resetZoom();
					}
			});
	};//end selectlist
}//end ready

} else {

	//provide fallback for browsers that don't support webGL
	d3.select('#map').remove();
	d3.select('body').append('p').html("Unfortunately your browser does not support WebGL. <a href='https://www.gov.uk/help/browsers' target='_blank>'>If you're able to please upgrade to a modern browser</a>")

}
