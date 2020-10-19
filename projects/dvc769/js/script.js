
//test if browser supports webGL

if(Modernizr.webgl) {

	//setup pymjs
	var pymChild = new pym.Child();

	//Load data and config file
	d3.queue()
		.defer(d3.json, "data/config.json")
		.await(ready);

	function ready (error, config){

	// function ready (error, data, config, geog){

		//Set up global variables
		dvc = config.ons;
		oldlsoa11cd = "";
		firsthover = true;



		//set title of page
		//Need to test that this shows up in GA
		document.title = dvc.maptitle;


		//Set up number formats
		// displayformat = GB.format("$,." + dvc.displaydecimals + "%");
		displayformat = d3.format(",." + dvc.displaydecimals + "f");
		legendformat = d3.format(",");

		//set up basemap
		map = new mapboxgl.Map({
		  container: 'map', // container id
		  style: 'data/style.json', //stylesheet location
			//style: 'https://s3-eu-west-1.amazonaws.com/tiles.os.uk/v2/styles/open-zoomstack-night/style.json',
		  center: [-0.12, 51.5], // starting position51.5074° N, 0.1278
		  zoom:12, // starting zoom
		  minZoom:4,
			maxZoom: 17, //
		  attributionControl: false
		});
		//add fullscreen option
		map.addControl(new mapboxgl.FullscreenControl());

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

		addFullscreen();

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


		map.on('load', function() {

			map.addLayer({
				"id": "lsoa-outlines2",
				"type": "fill",
				"source": {
					"type": "vector",
					"tiles": ["https://cdn.ons.gov.uk/maptiles/t24/boundaries3/{z}/{x}/{y}.pbf"]
					//"tiles": ["http://localhost:8000/boundaries/{z}/{x}/{y}.pbf"]
				},
				"minzoom": 4,
				"maxzoom": 9,
				"source-layer": "boundaries",
				"layout": {},
				'paint': {
						'fill-opacity':0.5,
						'fill-outline-color':'rgba(0,0,0,0)',
						'fill-color': {
									// Refers to the data of that specific property of the polygon
								'property': "houseprice",
								'default': '#666666',
								// Prevents interpolation of colors between stops
								'base': 0,
								'stops':[
									[dvc.breaks[0], dvc.varcolour[0]],
									[dvc.breaks[1], dvc.varcolour[1]],
									[dvc.breaks[2], dvc.varcolour[2]],
									[dvc.breaks[3], dvc.varcolour[3]],
									[dvc.breaks[4], dvc.varcolour[4]],
									[dvc.breaks[5], dvc.varcolour[5]]
								]
							}
					}
			}, 'place_suburb');


			map.addLayer({
				"id": "lsoa-outlines",
				"type": "fill",
				"source": {
					"type": "vector",
					"tiles": ["https://cdn.ons.gov.uk/maptiles/t24/boundaries3/{z}/{x}/{y}.pbf"],

					//"tiles": ["http://localhost:8000/boundaries/{z}/{x}/{y}.pbf"],

				},
				"minzoom": 9,
				"maxzoom": 20,
				"source-layer": "boundaries",
				"layout": {},
				'paint': {
						'fill-opacity':0.2,
						'fill-outline-color':'rgba(0,0,0,0)',
						'fill-color': {
									// Refers to the data of that specific property of the polygon
								'property': "houseprice",
								'default': '#666666',
								// Prevents interpolation of colors between stops
								'base': 0,
								'stops':[
									[dvc.breaks[0], dvc.varcolour[0]],
									[dvc.breaks[1], dvc.varcolour[1]],
									[dvc.breaks[2], dvc.varcolour[2]],
									[dvc.breaks[3], dvc.varcolour[3]],
									[dvc.breaks[4], dvc.varcolour[4]],
									[dvc.breaks[5], dvc.varcolour[5]]
								]
							}
					}
			}, 'place_suburb');


				map.addLayer({
					"id": "income",
					'type': 'fill',
					"source": {
						"type": "vector",
						"tiles": ["https://cdn.ons.gov.uk/maptiles/t24/tiles/{z}/{x}/{y}.pbf"]
						//"tiles": ["http://localhost:8000/tiles/{z}/{x}/{y}.pbf"]

					},
					"source-layer": "houseprices",
					"background-color": "#ccc",
					'paint': {
							'fill-opacity':1,
							'fill-outline-color':'rgba(0,0,0,0)',
							'fill-color': {
									// Refers to the data of that specific property of the polygon
								'property': 'houseprice',
								'default': '#666666',
								// Prevents interpolation of colors between stops
								'base': 0,
								'stops': [
									[dvc.breaks[0], dvc.varcolour[0]],
									[dvc.breaks[1], dvc.varcolour[1]],
									[dvc.breaks[2], dvc.varcolour[2]],
									[dvc.breaks[3], dvc.varcolour[3]],
									[dvc.breaks[4], dvc.varcolour[4]],
									[dvc.breaks[5], dvc.varcolour[5]]

								]
							}

						}
				}, 'place_suburb');



				map.addLayer({
					"id": "lsoa-outlines-hover",
					"type": "line",
					"source": {
						"type": "vector",
						"tiles": ["https://cdn.ons.gov.uk/maptiles/t24/boundaries3/{z}/{x}/{y}.pbf"]
            //"tiles": ["http://localhost:8000/boundaries/{z}/{x}/{y}.pbf"]

					},
					"minzoom": 9,
					"maxzoom":20,
					"source-layer": "boundaries",
					"background-color": "#ccc",
					'paint': {
							'line-color': 'orange',
							"line-width": 3
						},
					"filter": ["==", "lsoa11cd", ""]
				}, 'place_suburb');

				map.addLayer({
					"id": "lsoa-outlines2-hover",
					"type": "line",
					"source": {
						"type": "vector",
						"tiles": ["https://cdn.ons.gov.uk/maptiles/t24/boundaries3/{z}/{x}/{y}.pbf"]
            //"tiles": ["http://localhost:8000/boundaries/{z}/{x}/{y}.pbf"]

					},
					"minzoom": 4,
					"maxzoom": 9,
					"source-layer": "boundaries",
					"background-color": "#ccc",
					'paint': {
							'line-color': 'orange',
							"line-width": 3
						},
					"filter": ["==", "lsoa11cd", ""]
				}, 'place_suburb');

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

			//
			// if(detectIE()){
			// 	onMove = onMove.debounce(100);
			// 	onLeave = onLeave.debounce(100);
			// };

			//Highlight stroke on mouseover (and show area information)
			map.on("mousemove", "lsoa-outlines", onMove);
			map.on("mousemove", "lsoa-outlines2", onMove);

			// Reset the lsoa-fills-hover layer's filter when the mouse leaves the layer.
			map.on("mouseleave", "lsoa-outlines", onLeave);
			map.on("mouseleave", "lsoa-outlines2", onLeave);

			map.getCanvasContainer().style.cursor = 'pointer';

			//Add click event
			map.on('click', 'lsoa-outlines', onClick);
			map.on('click', 'lsoa-outlines2', onClick);
			//get location on click
			d3.select(".mapboxgl-ctrl-geolocate").on("click", geolocate);


})

		$(".search-control").click(function() {
			$(".search-control").val('')
		})

		d3.select(".search-control").on("keydown", function() {
    if(d3.event.keyCode === 13){
			event.preventDefault();
			event.stopPropagation();

			myValue=$(".search-control").val();


			getCodes(myValue);
			pymChild.sendHeight();

    }
  })

		$("#submitPost").click(function( event ) {

						event.preventDefault();
						event.stopPropagation();

						myValue=$(".search-control").val();


						getCodes(myValue);
						pymChild.sendHeight();
		});

		function onMove(e) {
				newlsoa11cd = e.features[0].properties.lsoa11cd;
				if(firsthover) {
            dataLayer.push({
                'event': 'mapHoverSelect',
                'selected': newlsoa11cd
            })

            firsthover = false;
        }


				if(newlsoa11cd != oldlsoa11cd) {
					oldlsoa11cd = e.features[0].properties.lsoa11cd;

					if(map.getZoom() <= 9 ){
						map.setFilter("lsoa-outlines2-hover", ["==", "lsoa11cd", e.features[0].properties.lsoa11cd]);
						var features = map.queryRenderedFeatures(e.point,{layers: ['lsoa-outlines2']});
					} else {
							map.setFilter("lsoa-outlines-hover", ["==", "lsoa11cd", e.features[0].properties.lsoa11cd]);
							var features = map.queryRenderedFeatures(e.point,{layers: ['lsoa-outlines']});
					}

					// selectArea(e.features[0].properties.lsoa11cd);



				 	if(features.length != 0){

						setAxisVal(features[0].properties.lsoa11nm, features[0].properties["houseprice"]);
					}
					//setAxisVal(e.features[0].properties.lsoa11nm, e.features[0].properties["houseprice"]);
				}
		};


		function tog(v){return v?'addClass':'removeClass';}
		$(document).on('input', '.clearable', function(){
				$(this)[tog(this.value)]('x');
		}).on('mousemove', '.x', function( e ){
				$(this)[tog(this.offsetWidth-28 < e.clientX-this.getBoundingClientRect().left)]('onX');
		}).on('touchstart click', '.onX', function( ev ){
				ev.preventDefault();
				$(this).removeClass('x onX').val('').change();
				enableMouseEvents();
				onLeave();
		});



		function onLeave() {
				map.setFilter("lsoa-outlines-hover", ["==", "lsoa11cd", ""]);
				oldlsoa11cd = "";
				// $("#areaselect").val("").trigger("chosen:updated");
				hideaxisVal();
		};



		 function onClick(e) {
		 		disableMouseEvents();
		 		newlsoa11cd = e.features[0].properties.lsoa11cd;

		 		if(newlsoa11cd != oldlsoa11cd) {
		 			oldlsoa11cd = e.features[0].properties.lsoa11cd;
		 			map.setFilter("lsoa-outlines-hover", ["==", "lsoa11cd", e.features[0].properties.lsoa11cd]);

		 			 //selectArea(e.features[0].properties.lsoa11cd);
		 			setAxisVal(e.features[0].properties.lsoa11nm, e.features[0].properties["houseprice"]);
		 		}

		 		dataLayer.push({
             'event':'mapClickSelect',
             'selected': newlsoa11cd
         })
		 };

		function disableMouseEvents() {
				map.off("mousemove", "lsoa-outlines", onMove);
				map.off("mouseleave", "lsoa-outlines", onLeave);
		}

		function enableMouseEvents() {
				map.on("mousemove", "lsoa-outlines", onMove);
				map.on("click", "lsoa-outlines", onClick);
				map.on("mouseleave", "lsoa-outlines", onLeave);
		}


		function setAxisVal(areanm,areaval) {

			d3.select("#keyvalue").style("font-weight","bold").html(function(){
				if(!isNaN(areaval)) {
					return areanm + "<br>" +"£"+ displayformat(areaval)
				} else {
					return areanm + "<br>No data available";
				}
			});


		}

		function hideaxisVal() {
			d3.select("#keyvalue").style("font-weight","bold").text("");

		}

		function createKey(config){

			keywidth = d3.select("#keydiv").node().getBoundingClientRect().width;

			var svgkey = d3.select("#keydiv")
				.attr("width", keywidth);

			d3.select("#keydiv")
				.style("font-family","Open Sans")
				.style("font-size","14px")
				.append("p")
				.attr("id","keyvalue")
				.style("font-size","18px")
				.style("margin-top","10px")
				.style("margin-bottom","5px")
				.style("margin-left","10px")
				.text("");

			d3.select("#keydiv")
				.append("p")
				.attr("id","keyunit")
				.style("margin-top","5px")
				.style("margin-bottom","5px")
				.style("margin-left","10px")
				.text(dvc.varunit);

			stops = [
				[dvc.breaks[0], dvc.varcolour[0]],
				[dvc.breaks[1], dvc.varcolour[1]],
				[dvc.breaks[2], dvc.varcolour[2]],
				[dvc.breaks[3], dvc.varcolour[3]],
				[dvc.breaks[4], dvc.varcolour[4]],
				[dvc.breaks[5], dvc.varcolour[5]]
			]

			divs = svgkey.selectAll("div")
				.data(breaks)
				.enter()
				.append("div");

			divs.append("div")
				.style("height","20px")
				.style("width","10px")
				.attr("float","left")
				.style("display","inline-block")
				.style("background-color", function(d,i) {if(i != breaks.length-1) {return stops[i+1][1]} else {return "#666666"}});

			divs.append("p")
				.attr("float","left")
				.style("padding-left", "5px")
				.style("margin", "0px")
				.style("display","inline-block")
				.style("position","relative")
				.style("top","-5px")
				.text(function(d,i){if(i != breaks.length-1) {return "£" + displayformat(stops[i][0]) + " - £" + displayformat(stops[i+1][0]-1)} else {return "No Data"}});

			// //Temporary	hardcode unit text
			dvc.unittext = "change in life expectancy";


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

	function getCodes(myPC)	{

		//first show the remove cross
		d3.select(".search-control").append("abbr").attr("class","postcode");

			dataLayer.push({
								 'event': 'geoLocate',
								 'selected': 'postcode'
							 })

			var myURIstring=encodeURI("https://api.postcodes.io/postcodes/"+myPC);
			$.support.cors = true;
			$.ajax({
				type: "GET",
				crossDomain: true,
				dataType: "jsonp",
				url: myURIstring,
				error: function (xhr, ajaxOptions, thrownError) {
					},
				success: function(data1){
					if(data1.status == 200 ){
						//$("#pcError").hide();
						lat =data1.result.latitude;
						lng = data1.result.longitude;
						successpc(lat,lng)
					} else {
						$(".search-control").val("Sorry, invalid postcode.");
					}
				}

			});

		}


	function successpc(lat,lng) {

		map.jumpTo({center:[lng,lat], zoom:12})
		point = map.project([lng,lat]);


		setTimeout(function(){

		var tilechecker = setInterval(function(){
			 features=null
		 	var features = map.queryRenderedFeatures(point,{layers: ['lsoa-outlines']});
		 	if(features.length != 0){
		 		 //onrender(),
		 		map.setFilter("lsoa-outlines-hover", ["==", "lsoa11cd", features[0].properties.lsoa11cd]);
				//var features = map.queryRenderedFeatures(point);
				disableMouseEvents();
				setAxisVal(features[0].properties.lsoa11nm, features[0].properties["houseprice"]);

		 		clearInterval(tilechecker);
		 	}
		 },500)
		},500);




	};

		function selectlist(datacsv) {

			var areacodes =  datacsv.map(function(d) { return d.lsoa11cd; });
			var areanames =  datacsv.map(function(d) { return d.lsoa11nm; });
			var menuarea = d3.zip(areanames,areacodes).sort(function(a, b){ return d3.ascending(a[0], b[0]); });

			// Build option menu for occupations
			var optns = d3.select("#selectNav").append("div").attr("id","sel").append("select")
				.attr("id","areaselect")
				.attr("style","width:98%")
				.attr("class","chosen-select");


			optns.append("option")
				.attr("value","first")
				.text("");

			optns.selectAll("p").data(menuarea).enter().append("option")
				.attr("value", function(d){ return d[1]})
				.text(function(d){ return d[0]});

			myId=null;

			$('#areaselect').chosen({width: "98%", allow_single_deselect:true}).on('change',function(evt,params){

					if(typeof params != 'undefined') {

							disableMouseEvents();

							map.setFilter("lsoa-outlines-hover", ["==", "lsoa11cd", params.selected]);

							selectArea(params.selected);
							setAxisVal(params.selected);

							zoomToArea(params.selected);

							dataLayer.push({
									'event': 'mapDropSelect',
									'selected': params.selected
							})
					}
					else {
							enableMouseEvents();
							hideaxisVal();
							onLeave();
							resetZoom();
					}

			});

	};

	}

} else {

	//provide fallback for browsers that don't support webGL
	d3.select('#map').remove();
	d3.select('body').append('p').html("Unfortunately your browser does not support WebGL. <a href='https://www.gov.uk/help/browsers' target='_blank>'>If you're able to please upgrade to a modern browser</a>")

}
