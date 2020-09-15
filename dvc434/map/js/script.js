	
	pymChild = new pym.Child();

	if(Modernizr.inlinesvg) {
	$(document).ready(function(){
	d3.select("img").remove();
	
    width = $("#map").width();
	
	height = 350;
	
	dvc = {};
	dvc.scale = 1;
	dvc.translate = [0,0];
	center = [width / 2, height / 2];
	
	zoom = d3.behavior.zoom()
		.scaleExtent([0.5, 12])
		.on("zoom", zoomed);
	// Load your topojson file & CSV file
	
	
	queue()
		.defer(d3.json, "assets/geog.json")
		.defer(d3.json, "assets/config.json")
		.defer(d3.csv, "assets/data.csv")
		.await(ready);
		
	});
		
	function ready(error, geog, config, data) {
			
		geog2 = geog;
		data2 = data;
		config2 = config;
		
		dvc.curr = config.ons.varload;
		dvc.colour = config.ons.varcolour;
		
		
		var IE = (!! window.ActiveXObject && +(/msie\s(\d+)/i.exec(navigator.userAgent)[1])) || NaN;
		if (IE != 9) {
			zoomcontrols();
		}
		//if more than one variable build some navigation
		if(config.ons.varlabel.length > 1){navigation(config2,data2);}
	
		makeMap(geog2,data2,config2);
		
		
		$(window).resize(function(){
				d3.select("#map").select("svg").remove();
				makeMap(geog2,data2,config2)
		});
		
	};
	
	
	
	function makeMap (geog, data, config){
			
	width = $("#map").width();
	
	// You can choose from a load of different projection types 
	// Have a look here for options - https://github.com/mbostock/d3/wiki/Geo-Projections

	var projection = d3.geo.albers()
		.center([1.4, 53.8])
		.rotate([3.2, 1])
		.parallels([50, 60])
		.scale(3300)
		.translate([width / 2, height / 2]);

	// Set up a scaling variable effectively tells D3 how to interpret your lat - long coordinates into pixel positions.	
		
	var path = d3.geo.path()
		.projection(projection);
	
	//Create a flat array of all the values of earnings / filter out any non-numbers / sort in ascending order ready to pass to jenks algorithm 
		
	var values =  data.map(function(d) { return +eval("d." + dvc.curr); }).filter(function(d) {return !isNaN(d)}).sort(d3.ascending);
	
	// Generate some breaks based on the Jenks algorithm - http://en.wikipedia.org/wiki/Jenks_natural_breaks_optimization
	
	breaks = ss.jenks(values, 5);

// Set up a colour scaling variable
// This time using the jenks breaks we've defined		
	color = d3.scale.threshold()
		.domain(breaks.slice(1,5))
		.range(dvc.colour);


	d3.select("#map").select("svg").remove();
	d3.select("#key").select("svg").remove();
	
	createKey(config);


// Create an object to give yourself a pair of values for the parlicon code and data value

	rateById = {};
	data.forEach(function(d) { rateById[d.la_code] = +eval("d." + dvc.curr); });

//Let's create an SVG element and give it a height and width

	var svg = d3.select("#map").selectAll("svg")
		.data([data])
		.enter()
		.append("svg")
		.attr("width", width)
		.attr("height", height)
		.attr("viewbox","0 0 " + width + " " + height);	

// Use the normal d3 pattern - select all path elements (even though they haven't yet been created)
// Then append a path element for every bit of data you've just binded.
	
	g = svg.append("g");
	
	zoomed();

		  g.attr("class", "geogg")
		  .selectAll("path")
		  .data(topojson.feature(geog, geog.objects.LAD15merc).features)
		  .enter()
		  .append("path")
		  .attr("id",function(d){return "reg" + d.properties.AREACD})
		  .attr("data-nm", function(d){return d.properties.AREANM})
		  .attr("data-dt", function(d) {return rateById[d.properties.AREACD];})
		  .attr("d", path)
		  .style("stroke", function (d) { return "#fff"})
		  .style("fill", function(d) {if (typeof(color(rateById[d.properties.AREACD])) != "undefined") { return color(rateById[d.properties.AREACD]); }else {return "#e0e0e0"}})
		  .on("mouseout",unhighlight)
		  .on("mouseover",function(d){highlight(d.properties.AREACD)});


	svg.call(zoom)
		.call(zoom.event);
	
	if (pymChild) {
        pymChild.sendHeight();
  	}
	
	}
	
	function zoomed() {
		
	  dvc.scale = zoom.scale();
			
	  g.style("stroke-width",(0.5/zoom.scale()))
	  	.attr("transform", "translate(" + zoom.translate() + ")scale(" + zoom.scale() + ")");
	}
	
	function zoomcontrols(){
	
		zoomcontrols = d3.select("#mapPane").append('div').attr("class","zoom-container zoom-control-zoom zoom-bar zoom-control");
		
		zoomcontrols.append("a").attr("id","zoom_in").attr("class","zoom-control-zoom-in zoom-bar-part zoom-bar-part-top").attr("title","Zoom in").text("+")
		zoomcontrols.append("a").attr("id","zoom_out").attr("class","zoom-control-zoom-out zoom-bar-part zoom-bar-part-bottom").attr("title","Zoom out").text("-")
		
	var intervalID;

	d3.selectAll('.zoom-bar-part').on('mousedown', function(){
		d3.event.preventDefault();
		var factor = (this.id === 'zoom_in') ? 1.1 : 1/1.1;
		intervalID = setInterval(zoom_by, 40, factor);
	}).on('mouseup', function(){
		d3.event.preventDefault();
		clearInterval(intervalID);
		intervalID = undefined;
	})

	}


function zoom_by(factor){
    var scale = zoom.scale(),
        extent = zoom.scaleExtent(),
        translate = zoom.translate(),
        x = translate[0], y = translate[1],
        target_scale = scale * factor;

    // If we're already at an extent, done
    if (target_scale === extent[0] || target_scale === extent[1]) { return false; }
    // If the factor is too much, scale it down to reach the extent exactly
    var clamped_target_scale = Math.max(extent[0], Math.min(extent[1], target_scale));
    if (clamped_target_scale != target_scale){
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
        .translate([x,y]);
	
	zoomed();
   
}

	function updateMap(geog, data, config){
		
		var values =  data.map(function(d) { return +eval("d." + dvc.curr); }).filter(function(d) {return !isNaN(d)}).sort(d3.ascending);
	
		// Generate some breaks based on the Jenks algorithm - http://en.wikipedia.org/wiki/Jenks_natural_breaks_optimization
		
		breaks = ss.jenks(values, 5);

		// Set up a colour scaling variable
		// This time using the jenks breaks we've defined		
		color = d3.scale.threshold()
			.domain(breaks.slice(1,5))
			.range(dvc.colour);
		
	
		d3.select("#key").select("svg").remove();
		
		createKey(config);
	
	
		// Create an object to give yourself a pair of values for the parlicon code and data value
	
		rateById = {};
		data.forEach(function(d) { rateById[d.la_code] = +eval("d." + dvc.curr); });

		
		unhighlight();
		
		d3.select(".geogg").selectAll("path")
		 .transition()
		 .duration(1500)
	     .style("fill", function(d) {if (typeof(color(rateById[d.properties.AREACD])) != "undefined") { return color(rateById[d.properties.AREACD]); }else {return "#e0e0e0"}});
		 
		 if(typeof myId == 'string'){
		 highlight(myId);
		 }
	
	}	
	
	function highlight(area) {
					
		svg = d3.select('.geogg');
		
		var reg=document.getElementById("reg" + area);
					
		/* Display name of area*/
		var name = d3.select("#reg" + area).attr("data-nm");
		
		d3.select("#areanm").text(name);
		d3.select("#areainfo").html(function(d,i){if (!isNaN(rateById[area]))  {return "&#163;" + dvc.prefix + d3.format(',')(rateById[area]) + " per m²"} else {return "Data unavailable"}});

	
	/* Let's create another polygon based on the path information of the polygon we've just hovered over */
		
		svg.append("path")
			.attr("d", d3.select(reg).attr("d"))
			.attr("id","selected")
			.attr("class", "arcSelection")
			.attr("pointer-events", "none")
			.style("fill", "none")
			.style("stroke", "orange")
			.style("stroke-width", 2/dvc.scale);
			
		//d3.select("#areaname").html(d3.select(reg).attr("data-nm") + ":<br> " + d3.select(reg).attr("data-dt"));
			
	}	
	
	/* Remove the current selected polygon */
	function unhighlight() {
		d3.select('#selected').remove();
		d3.select("#areanm").html("");
		d3.select("#areainfo").html("");

	}	
	
	function createKey(config){

		var svgkey = d3.select("#key")
			.append("svg")
			.attr("id", "key")
		    .attr("height", 300)
		    .attr("width", 140);
		
		newbreaks = breaks;
	
		var color = d3.scale.threshold()
		   .domain(newbreaks)
		   .range(dvc.colour);

		y = d3.scale.linear()
		    .domain([newbreaks[0], breaks[5]]) /*range for data*/
		    .range([250, 0]); /*range for pixels*/

		keywidth = $("#key").width();	
		
		x = d3.scale.linear()
		    .domain([newbreaks[0], breaks[5]]) /*range for data*/
		    .range([0,keywidth-50]); /*range for pixels*/

		var xAxis = d3.svg.axis()
		    .scale(x)
		    .orient("bottom")
    		.tickSize(15)
		    .tickValues(color.domain())
			.tickFormat(d3.format(".2s"));

		
		var yAxis = d3.svg.axis()
		    .scale(y)
		    .orient("left")
    		.tickSize(15)
		    .tickValues(color.domain())
			.tickFormat(d3.format(".2s"));

		var g = svgkey.append("g").attr("id","vert").attr("class","hidden-xs")
			.attr("transform", "translate(60,40)");
		
		
		g.selectAll("rect")
			.data(color.range().map(function(d, i) {
			  return {
				y0: i ? y(color.domain()[i]) : y.range()[0],
				y1: i < color.domain().length ? y(color.domain()[i+1]) : y.range()[1],
				z: d
			  };
			}))
			.enter().append("rect")
			.attr("width", 8)
			.attr("y", function(d) {return d.y1; })
			.attr("height", function(d) {return d.y0 - d.y1; })
			.style("fill", function(d) {return d.z; });
		
		g.call(yAxis).append("text");
		
		g.append("line")
			.attr("x1","8")
			.attr("x2","65")
			.attr("y1",function(d,i){return y(config.ons.average[a])})
			.attr("y2",function(d,i){return y(config.ons.average[a])})
			.attr("stroke","blue")
			.attr("stoke-width",1);	
		
		g.append("text")
			.attr("x","10")
			.attr("y",function(d,i){return y(config.ons.average[a]) - 4})
			.attr("class","average")
			.text(config.ons.averagelabel);
			
		g.append("text")
			.attr("x","10")
			.attr("y",function(d,i){return y(config.ons.average[a]) + 11})
			.attr("class","average")
			.text(config.ons.average[a]);		
		
		//add units
		
		g.append("text").attr("id","keyunit").text(dvc.unittext).attr("transform","translate(-30,-20)");
		
		
		//horizontal key		
			
		var g2 = svgkey.append("g").attr("id","horiz").attr("class","visible-xs")
			.attr("transform", "translate(25,20)");
		
		keyhor = d3.select("#horiz");
		
		g2.selectAll("rect")
			.data(color.range().map(function(d, i) {
			  return {
				x0: i ? x(color.domain()[i]) : x.range()[0],
				x1: i < color.domain().length ? x(color.domain()[i+1]) : x.range()[1],
				z: d
			  };
			}))
		  .enter().append("rect")
			.attr("height", 8)
			.attr("x", function(d) { return d.x0; })
			.attr("width", function(d) { return d.x1 - d.x0; })
			.style("fill", function(d) { return d.z; });

			
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
			
			

		d3.select("#horiz").selectAll("text").attr("transform",function(d,i){if(i % 2){return "translate(0,10)"}});			
		
		g2.append("text").attr("id","keyunit").text(dvc.unittext).attr("transform","translate(0,-10)");
//		d3.select("#horiz").selectAll(".tick").selectAll("text").attr("transform",function(d,i){if(i % 2){return "translate(0,10)"}});
		
			
		}
		
		
		
		function navigation(data, datacsv){
			
			$("#navigation").show();

		//Build pills
		
			dvc.varname = data.ons.varname;
			dvc.varunit = data.ons.varunit;
			
			a = dvc.varname.indexOf(dvc.curr);
			dvc.unittext = dvc.varunit[a];
			dvc.label = data.ons.varlabel[a];
			dvc.prefix = data.ons.varprefix[a];
	
			var pills = d3.select("#pills")
					.append("ul")
					.attr("class","nav navbar nav-pills navbar-inverse nav-justified")
					
		
			pills.selectAll("li")
				.data(data.ons.varlabel)
				.enter()
				.append("li")
				.attr("id", function(d,i){return data.ons.varname[i]})
				.append("a")
				.attr("href","#")
				.attr("data-nm", function(d,i){return data.ons.varname[i]})
				.attr("data-toggle","pill")
				.text(function(d,i){return d;})
				.on("click", function(d,i){
					dvc.curr = d3.select(this).attr("data-nm");
					a = dvc.varname.indexOf(dvc.curr);
					updateMap(geog2,data2,config2);
					//updateHash(dvc.curr);
					dvc.unittext = dvc.varunit[a];
					dvc.label = data.ons.varlabel[a];
					d3.select("#keyunit").text(dvc.unittext);
				});
				
		
			d3.select("#" + dvc.curr).attr("class","active");
			
			 var highest = null;

			   $(".nav-pills a").each(function(){  //find the height of your highest link
				   var h = $(this).height();
				   if(h > highest){
					  highest = $(this).height();  
				   }    
				});
			
			   $(".nav-pills a").height(highest);  //set all your links to that height.
			
			d3.select("#varsel").html(dvc.label + " <span class='caret'></span>");
					
			dropnext = d3.select("#menu").append("ul")
					.attr("class","dropdown-menu")
					.attr("role","menu");
					
			dropnext.selectAll("li")
					.data(data.ons.varlabel)
					.enter()
					.append("li")
					.attr("id", function(d,i){return "drop" + data.ons.varname[i]})
					.append("a")
					.attr("href","#")
					.attr("data-nm", function(d,i){return data.ons.varname[i]})
					.text(function(d,i){return d;})
					.on("click", function(d,i){
						dvc.curr = d3.select(this).attr("data-nm");
						a = dvc.varname.indexOf(dvc.curr);
						updateMap(geog2,data2,config2);
						dvc.unittext = dvc.varunit[a];
						d3.select("#varsel").html(data.ons.varlabel[i] + " <span class='caret'></span>");
						dvc.label = data.ons.varlabel[a];
						d3.select("#keyunit").text(dvc.unittext);
						dropnext.selectAll("li").attr("class","")
						d3.select("#drop" + dvc.curr).attr("class","active");
					});
			
			d3.select("#drop" + dvc.curr).attr("class","active");
			
			var areacodes =  datacsv.map(function(d) { return d.la_code; });
			var areanames =  datacsv.map(function(d) { return d.AREANM; });
			var menuarea = d3.zip(areanames,areacodes).sort(function(a, b){ return d3.ascending(a[0], b[0]); });
			
			// Build option menu for occupations
			var optns = d3.select("#chosensel").append("div").attr("id","sel").append("select")
				.attr("id","occselect")
				.attr("style","width:98%")
				.attr("class","chosen-select");
			
			
			optns.append("option")
				.attr("value","first")
				.text("");
			
			optns.selectAll("p").data(menuarea).enter().append("option")
				.attr("value", function(d){ return d[1]}) 
				.text(function(d){ return d[0]});
			
			
			$('#occselect').chosen({width: "98%", allow_single_deselect:true}).on('change',function(evt,params){
		
								if(typeof params != 'undefined') {
									
										
										/* identify the data-nm attribute of the polygon you've hovered over */
										myId=params.selected;
										unhighlight();
										highlight(myId);
										
										
										d3.select(".geogg").selectAll("path").attr("pointer-events","none");

								}
								else {
										// Remove any selections
										myId=null;
										unhighlight();
										d3.select(".geogg").selectAll("path").attr("pointer-events","all");
										
								}
								
			});

				
	}
	} else {
		
		pymChild.sendHeight();
	}
