var pymChild = new pym.Child();

d3.queue()
	.defer(d3.csv, "data/data.csv")
	//.defer(d3.json, "data/countyuabound.json")
	.defer(d3.json, "data/msoacentroidshp.json")
	.await(ready);

function ready(error, featureService, /*geogbound,*/ geog) {


	if (error) {
		console.error(error);
		return;
	}

	var data = featureService.map(function(feature,i) {
		return {
			areacd: feature.areacd,
			areanm: feature.areanm,
			areanmhc: feature.areanmhc,
			cases: feature.covid
		};
	});

	//convert topojson to geojson
	for (key in geog.objects) {
		var areas = topojson.feature(geog, geog.objects[key]);
	}

	// for (key in geogbound.objects) {
	// 	var areabounds = topojson.feature(geogbound, geogbound.objects[key]);
	// }

	const areabyid = [];
	const cases = [];
	const cases2 = [];
	const areanmhc = [];

	data.forEach(function(d, i) {
		cases[d.areacd] = +d.cases;
		areanmhc[d.areacd] = d.areanmhc;
		cases2[i] = +d.cases;
		areabyid[d.areacd] = d.areanm;
	});

	var maxvalue = d3.max(cases2);

	areas.features.map(function(d, i) {
		if (cases[d.properties.areacd] >= 0) {
			d.properties.cases = cases[d.properties.areacd];
			d.properties.casesPI = Math.sqrt(cases[d.properties.areacd]/Math.PI);
			d.properties.areanmhc = areanmhc[d.properties.areacd];
		} else {
			d.properties.cases = 0;
		}
	});

	// areabounds.features.map(function(d, i) {
	// 	if (cases[d.properties.areacd] >= 0) {
	// 		d.properties.cases = cases[d.properties.areacd];
	// 	} else {
	// 		d.properties.cases = 0;
	// 	}
	// });


	const map = new mapboxgl.Map({
		container: "map",
		style: "data/style.json",
		center: [-3.5, 52.355],
		zoom: 6,
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

	//add compact attribution
	map.addControl(new mapboxgl.AttributionControl({
		compact: true
	}));


	map.on("load", function() {
		map.addSource("area", { type: "geojson", data: areas });



	//	map.addSource("areabound", { type: "geojson", data: areabounds });


		map.addLayer(
			{
				id: "coronaboundInvisible",
				type: "fill",
				"source": {
					"type": "vector",
					//"tiles": ["http://localhost:8000/boundaries/{z}/{x}/{y}.pbf"],
					"tiles": ["https://cdn.ons.gov.uk/maptiles/t30/boundaries/{z}/{x}/{y}.pbf"],
				},
				"source-layer": "boundaries",
				minzoom: 4,
				maxzoom: 20,
				layout: {},
				paint: {
					"fill-color": "rgba(255,255,255,0)"
					//"stroke-width": 1
				}
			},
			"place_suburb"
		);

		map.addLayer(
			{
				id: "coronabound",
				type: "line",
				"source": {
					"type": "vector",
					"tiles": ["https://cdn.ons.gov.uk/maptiles/t30/boundaries/{z}/{x}/{y}.pbf"],
					//"tiles": ["https://cdn.ons.gov.uk/maptiles/t23/boundaries/{z}/{x}/{y}.pbf"],
				},
				"source-layer": "boundaries",
				minzoom: 9,
				maxzoom: 20,
				layout: {},
				paint: {
					"line-color": "grey",
					"line-width": 1
				}
			},
			"place_suburb"
		);

		map.addLayer(
			{
				id: "corona",
				type: "circle",
				source: "area",
				paint: {
					"circle-radius": {
						property: "casesPI",
						stops: [
							[{ zoom: 8, value: 0 }, 0],
							[{ zoom: 8, value: maxvalue }, 50],
							[{ zoom: 9, value: 0 }, 0],
							[{ zoom: 9, value: maxvalue }, 100],
							[{ zoom: 11, value: 0 }, 0],
							[{ zoom: 11, value: maxvalue }, 250],
							[{ zoom: 16, value: 0 }, 0],
							[{ zoom: 16, value: maxvalue }, 300]
						]
					},
					"circle-opacity": 0.9,
					"circle-color": {
						property: "cases",
						stops: [
							[0, "#abc149"],
							[maxvalue, "#24a79b"]
						]
					}
				}
			},
			"place_suburb"
		);

		map.addLayer(
			{
				id: "coronahover",
				type: "circle",
				source: "area",
				// "source-layer": "boundaries",
				paint: {
					"circle-radius": {
						property: "casesPI",
						stops: [
							[{ zoom: 8, value: 0 }, 0],
							[{ zoom: 8, value: maxvalue }, 50],
							[{ zoom: 9, value: 0 }, 0],
							[{ zoom: 9, value: maxvalue }, 100],
							[{ zoom: 11, value: 0 }, 0],
							[{ zoom: 11, value: maxvalue }, 250],
							[{ zoom: 16, value: 0 }, 0],
							[{ zoom: 16, value: maxvalue }, 300]
						]
					},
					"circle-opacity": 0.9,
					"circle-stroke-color": "black",
					"circle-stroke-width": 3,
					"circle-color": "rgba(255,255,255,0)"
				},
				filter: ["==", "areacd", ""]
			},
			"place_suburb"
		);

		map.addLayer(
			 {
				id: "coronaboundhover",
				type: "line",
				"source": {
					"type": "vector",
					"tiles": ["https://cdn.ons.gov.uk/maptiles/t30/boundaries/{z}/{x}/{y}.pbf"],
					//"tiles": ["https://cdn.ons.gov.uk/maptiles/t23/boundaries/{z}/{x}/{y}.pbf"],
				},
				"source-layer": "boundaries",
				minzoom: 3,
				maxzoom: 20,
				layout: {},
				paint: {
					"line-color": "black",
					"line-width": 2
				},
			filter: ["==", "areacd", ""]
			},
			"place_suburb"
		);

		var bounds = new mapboxgl.LngLatBounds();

		areas.features.forEach(function(feature) {
			bounds.extend(feature.geometry.coordinates);
		});

		map.fitBounds(bounds);
	});

	map.on("mousemove", "coronaboundInvisible", onMove);
	map.on("mouseleave", "coronaboundInvisible", onLeave);
	map.on("click", "corona", onClick);

	function onMove(e) {
		var oldareacd = "ff";

		newareacd = e.features[0].properties.areacd;

		if (newareacd != oldareacd) {
			oldareacd = e.features[0].properties.areacd;

			map.setFilter("coronahover", [
				"==",
				"areacd",
				e.features[0].properties.areacd
			]);

			map.setFilter("coronaboundhover", [
				"==",
				"areacd",
				e.features[0].properties.areacd
			]);

			var features = map.queryRenderedFeatures(e.point, {
				layers: ["coronaboundInvisible"]
			});

			if (features.length != 0) {
				setAxisVal(features[0].properties.areanm, features[0].properties.areanmhc, features[0].properties.covid);
			}
		}
	}

	function onClick(e) {
		var oldareacd = "ff";
		newareacd = e.features[0].properties.areacd;

		if (newareacd != oldareacd) {
			oldareacd = e.features[0].properties.areacd;
			map.setFilter("coronahover", [
				"==",
				"areacd",
				e.features[0].properties.areacd
			]);

			map.setFilter("coronaboundhover", [
				"==",
				"areacd",
				e.features[0].properties.areacd
			]);

			setAxisVal(
				e.features[0].properties.areanm,
				e.features[0].properties.areanmhc,
				e.features[0].properties.cases
			);
		}
	}

	function onLeave() {
		map.setFilter("coronahover", ["==", "areacd", ""]);
		map.setFilter("coronaboundhover", ["==", "areacd", ""]);

		oldlsoa11cd = "";
		hideaxisVal();
	}

	function setAxisVal(areanm, areanmhc, areaval) {
		d3.select("#keyvalue")
			.style("font-weight", "bold")
			.html(function() {
				if (!isNaN(areaval)) {
					return areanmhc + " (MSOA " + areanm + ")<br>" + areaval + " confirmed deaths";
				} else {
					return areanmhc + " (MSOA " + areanm + ")<br>No data available";
				}
			});

		d3.select("#keyvaluehidden")
				.html("In "+areanmhc+" there have been " + areaval +  " confirmed deaths")
	}

	function hideaxisVal() {
		d3
			.select("#keyvalue")
			.style("font-weight", "bold")
			.text("");
	}


	$(".search-control").click(function() {
		$(".search-control").val('');
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
		hideaxisVal();
});

	$("#submitPost").click(function( event ) {

					event.preventDefault();
					event.stopPropagation();

					myValue=$(".search-control").val();


					getCodes(myValue);
					pymChild.sendHeight();
	});


	function getCodes(myPC)	{

		//first show the remove cross
		d3.select(".search-control").append("abbr").attr("class","postcode");

			// dataLayer.push({
			// 					 'event': 'geoLocate',
			// 					 'selected': 'postcode'
			// 				 })

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
		 	features = map.queryRenderedFeatures(point,{layers: ['coronaboundInvisible']});
		 	if(features.length != 0){
		 		 //onrender(),
		 		//map.setFilter("coronahover", ["==", "areacd", features[0].properties.areacd]);

				map.setFilter("coronahover", [
					"==",
					"areacd",
					features[0].properties.areacd
				]);

				map.setFilter("coronaboundhover", [
					"==",
					"areacd",
					features[0].properties.areacd
				]);
				//var features = map.queryRenderedFeatures(point);
				disableMouseEvents();
				setAxisVal(features[0].properties.areanm, features[0].properties.areanmhc, features[0].properties.covid);
				//updatePercent(features[0]);
		 		clearInterval(tilechecker);
		 	}
		 },500)
		},500);




	};

	function disableMouseEvents() {
			map.off("mousemove", "coronaboundInvisible", onMove);
			map.off("mouseleave", "coronaboundInvisible", onLeave);
	}

	function enableMouseEvents() {
			map.on("mousemove", "coronaboundInvisible", onMove);
			map.on("click", "coronabound", onClick);
			map.on("mouseleave", "coronaboundInvisible", onLeave);
	}



}
