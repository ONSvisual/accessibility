var dvc = {};


if (Modernizr.inlinesvg) {
$(document).ready(function(){	

	d3.select("#graphic").remove();

	pymChild = new pym.Child();
	
	  
	var dvc ={};//global namespace
	dvc.chartWidth=270;
	dvc.chartHeight=220;
	dvc.xPadding=20;
	dvc.yPadding=60;
	dvc.timeIndex=-1;
	dvc.gapRatio=0.3;//gap ratio beteen bars
	dvc.index;
	dvc.bMark=false;
	dvc.bAnimate=false;
	
	/*login details for bit.ly account*/
	
//	$.shortenUrl.settings.login = 'onsdatavis';
//	$.shortenUrl.settings.apiKey = 'R_1edff3706d696ed7435ba5f60f6d0d40';
	
	getParams();
	
	//$('#embedbox').hide();

	
	/* Load both the starting SVGs */	
	/* Load SVG for the right */  	

	/* Load SVG for the left */ 
	
	d3.select("#left")
		.append("svg")
		.attr("id","svgElement")
		.attr("width","100%")
		.attr("height","100%")
		.attr("viewBox","0 0 450 600")
		.attr("preserveAspectRatio","xMinYMin meet");

	d3.select("#right")
		.append("svg")
		.attr("id","svgElement2")
		.attr("width","100%")
		.attr("height","100%")
		.attr("viewBox","0 0 450 600")
		.attr("preserveAspectRatio","xMaxYMinmeet");
	
	
	d3.xml("./svg/reg2.svg", 'image/svg+xml', function(xml) {
		
		//when this line is read - you can guarantee first file has loaded
		
		
		try{
			var importedNode = document.importNode(xml.documentElement, true);
			d3.select('#svgElement').node().appendChild(importedNode);
			$("#loadingl").fadeOut();
		}catch(e){
		// IE case
			var importedNode = importNode(xml.documentElement, document);
			d3.select('#svgElement').node().appendChild(importedNode);
			$("#loadingl").fadeOut();
		}
		
		
		d3.xml("./svg/reg2.svg", 'image/svg+xml', function(xml) {
		try{
			var importedNode = document.importNode(xml.documentElement, true);
			d3.select('#svgElement2').node().appendChild(importedNode);
		}catch(e){
		// IE case
			var importedNode = importNode(xml.documentElement, document);
			d3.select('#svgElement2').node().appendChild(importedNode);
		}
		
		
		d3.xml("./svg/" + dvc.first + ".svg", 'image/svg+xml', function(xml) {
		try{
			var importedNode = document.importNode(xml.documentElement, true);
			d3.select('#svgElement').node().appendChild(importedNode);
			$("#loadingr").fadeOut();
		}catch(e){
		// IE case
			var importedNode = importNode(xml.documentElement, document);
			d3.select('#svgElement').node().appendChild(importedNode);
			$("#loadingr").fadeOut();
		}
		
		setTimeout(addcol,500);
	});
	
		
	
	});
		
	
	});
	 


	/*d3.xml("./svg/reg2.svg", 'image/svg+xml', function(xml) {
		try{
			var importedNode = document.importNode(xml.documentElement, true);
			d3.select('#svgElement2').node().appendChild(importedNode);
		}catch(e){
		// IE case
			var importedNode = importNode(xml.documentElement, document);
			d3.select('#svgElement2').node().appendChild(importedNode);
		}
		
	});*/

	 
		 
	/*d3.xml("./svg/" + dvc.first + ".svg", 'image/svg+xml', function(xml) {
		try{
			var importedNode = document.importNode(xml.documentElement, true);
			d3.select('#svgElement').node().appendChild(importedNode);
			$("#loadingr").fadeOut();
		}catch(e){
		// IE case
			var importedNode = importNode(xml.documentElement, document);
			d3.select('#svgElement').node().appendChild(importedNode);
			$("#loadingr").fadeOut();
		}*/
		
	//	setTimeout(addcol,500);
	
	//});
		updateHash();
		
		var vartit = d3.select("#vartitle")
		vartit.text(dvc.lab + " earnings");
		
		var labeltit = d3.select("#labelr")
		labeltit.html("Scaled by number of <br> jobs (" + dvc.lab + ")");

	
function  addcol() {
	
	var mapoff = d3.select('#states2');
	
	
	d3.select('#states').attr('id', 'states1');
	
	var mapL1 = d3.select('#states');
	var mapR1 = d3.select('#states1');
	
	
	var ids=[]; 
	var fill = [];
	var pathlines = [];

	var diss = mapoff.selectAll("path");
		
	diss.each(function(d,i) {
			var codes = d3.select(this).attr("id"); 
			ids.push(codes);
			var ech = d3.select(this).attr("d"); 
			pathlines.push(ech);
			var fillf = d3.select(this).attr("fill"); 
			fill.push(fillf);
	});
 
 
  mapL1.selectAll("path").on("mouseout",out).on("mouseover",tellMe).transition()
	.duration(1500)
	.attr("fill", function(d,i)	{
	return fill[i];		   
  });	
  
  setTimeout(function(){
  mapR1.selectAll("path").on("mouseout",out).on("mouseover",tellMe).transition()
	.duration(1500)
	.attr("id", function(d,i)	{
		return ids[i];		   
	})
	.attr("d", function(d,i)	{
		return pathlines[i];		   
	})
	.attr("fill", function(d,i)	{
	return fill[i];		   
  	});
  },1500);
 
}


	//IE9 workaround
	
	
    function importNode(node, allChildren) {
        // summary:
        // Manually imports node to the provided document
        switch (node.nodeType) {
        case document.ELEMENT_NODE:
            var newNode = document.createElementNS(node.namespaceURI, node.nodeName);
            if(node.attributes && node.attributes.length > 0){
                for(var i = 0, il = node.attributes.length; i < il; i++){
                    newNode.setAttribute(node.attributes[i].nodeName, node.getAttribute(node.attributes[i].nodeName));
                }
            }
            if(allChildren && node.childNodes && node.childNodes.length > 0){
                for(var i = 0, il = node.childNodes.length; i < il; i++){
                    newNode.appendChild(importNode(node.childNodes[i], allChildren));
                }
            }
            
            return newNode;
            break;
            
        case document.TEXT_NODE:
        case document.CDATA_SECTION_NODE:
        case document.COMMENT_NODE:
          return document.createTextNode(node.nodeValue);
          break;
        }
    }
	
	
	
	
	/*Function to swap map on click within menu */
	
	function swapMap() {
		$("#loadingl").fadeIn();
		$("#loadingr").fadeIn();
		
		var val = d3.select(this).text();
		var eth = d3.select(this).attr("data-nm");
		
		console.log(eth);
		
	/* select all paths in the currently selected map (rhs) in preparation for swapping over path information (polygon and styling) */
		var mapoff=d3.select('#states2').remove();
		var mapR = d3.select('#states1');

	/* select all paths in lhs map */
	
		var mapL = d3.select('#states');
		
	/* generate file path for new map*/	
		filepth= "./svg/" + eth + ".svg";
		
	/*Update title */
		
		
		var vartit = d3.select("#vartitle")
		vartit.text(val + " earnings");
		
		var labeltit = d3.select("#labelr")
		labeltit.html("Scaled by number of <br>jobs (" + val + ")");
	
		
	/* load new map (it's currently loaded outside of the view box as we only want to load it, take information from it then discard it)*/	
		d3.xml(filepth, 'image/svg+xml', function(xml) {
		    try{
        var importedNode = document.importNode(xml.documentElement, true);
		d3.select('#svgElement').node().appendChild(importedNode);
		$("#loadingl").fadeOut();
		$("#loadingr").fadeOut();
		    }catch(e){
    // IE case
        var importedNode = importNode(xml.documentElement, document);
		d3.select('#svgElement').node().appendChild(importedNode);
		$("#loadingl").fadeOut();
		$("#loadingr").fadeOut();
	    }
		
		
	
	/* select all paths in the new map you've just loaded in (out-of-site)*/
	  	var stt = d3.select("#states2");
		var stnd = d3.select("#states");
		var dis = stt.selectAll("path");
	
	/* set up empty arrays for the path and fill information you're about to capture */
		var pathlines = [];
		var fillm = [];
	
	/* each function loops through each of the svg path element you've just selected and select the attributes you want pushing it into the arrays you created above*/	
		dis.each(function(d,i) {
			var ech = d3.select(this).attr("d"); 
			pathlines.push(ech);
			var fillc = d3.select(this).attr("fill"); 
			fillm.push(fillc);
		});
		
		
		
	/* remove the map you loaded out of sight*/
		stt.remove();
		
	/* take the selection of the current map and overwrite it with the path and fill information from your previous selection */
	/* apply a transition (with duration) to animate the change */
				  mapL.selectAll("path").transition()
			  	 .duration(2500)
				 .attr("fill", function(d,i)	{
					return fillm[i];		   
					});
				
				
					
				  mapR.selectAll("path").transition()
			  	 .duration(2500)
			 	 .attr("d", function(d,i)	{
					return pathlines[i];		   
				})
				 .attr("fill", function(d,i)	{
					return fillm[i];		   
				});
		 
		});
		
		/*update range and legend*/
		
		dvc.varIndex= jQuery.inArray(eth, dvc.chartData.ons.range.label); 
		var keyArea = d3.selectAll("#key");	
		keyArea.remove();
		key();
		
		
		/*Select bar in chart*/
		d3.selectAll(".chartBarSel").attr("class", "chartBars");
		d3.select("#bar" + eth).attr("class", "chartBarSel");
		
		/*update url*/
		
		
		dvc.first=eth;
		dvc.lab=val;
		updateHash();
				
	}
		
	/* Function to hightlight the array you've hovered over */
	function tellMe(evt) {
		
		
		var area_l=d3.select(this).attr("LAname");
		console.log(area_l);	
	/* identify the data-nm attribute of the polygon you've hovered over */
		var myId=d3.select(this).attr("data-nm");
		
		
	/* get the id of the the equivalent polygons for either side */
		var reg=document.getElementById(myId)
		
		var carto=document.getElementById("reg" + myId)	
			
	/* select the parent element for all paths for each map (left and right)*/
		svg = d3.select('#states1');
		svg1 = d3.select('#states');
		
	/* draw another polygon over the top for either side (no fill, only the stoke)*/
			//if (evt.type=="mouseover")
			//{	
				if(myId !='00RA' && myId !='00RD') {
			
				svg.append("path")
				  .attr("d", d3.select(reg).attr("d"))
				  .attr("id", "arcSelection")
				  .attr("pointer-events", "none")
				  .style("fill", "none")
				  .style("stroke", "orange")
				  .style("stroke-width", 2);
				  
				  
				 svg1.append("path")
				  .attr("d", d3.select(carto).attr("d"))
				  .attr("id", "arcSelection")
				  .attr("pointer-events", "none")
				  .style("fill", "none")
				  .style("stroke", "orange")
				  .style("stroke-width", 2); 
				  
				}
			 	else if (myId=="00RA"){
				 svg.append("path")
				  .attr("d", d3.select(reg).attr("d"))
				  .attr("id", "arcSelection")
				  .attr("pointer-events", "none")
				  .style("fill", "none")
				  .style("stroke", "orange")
				  .style("stroke-width", 2)
				  .attr("transform","translate(20,60)");
				  
				 svg1.append("path")
				  .attr("d", d3.select(carto).attr("d"))
				  .attr("id", "arcSelection")
				  .attr("pointer-events", "none")
				  .style("fill", "none")
				  .style("stroke", "orange")
				  .style("stroke-width", 2)
				  .attr("transform","translate(20,60)");
				
				}
				else if (myId=="00RD"){
				  svg.append("path")
				  .attr("d", d3.select(reg).attr("d"))
				  .attr("id", "arcSelection")
				  .attr("pointer-events", "none")
				  .style("fill", "none")
				  .style("stroke", "orange")
				  .style("stroke-width", 2)
				  .attr("transform", "translate(30,200)");
				  
				 svg1.append("path")
				  .attr("d", d3.select(carto).attr("d"))
				  .attr("id", "arcSelection")
				  .attr("pointer-events", "none")
				  .style("fill", "none")
				  .style("stroke", "orange")
				  .style("stroke-width", 2)
				  .attr("transform", "translate(30,200)");
				}
			
				
			//}
			
			
			
	/* remove polygon when moused out */
			//if (evt.type=="mouseout")
			//{
			//	svg.select("#arcSelection").remove();
			//	svg1.select("#arcSelection").remove();
			//}



/*Chart update */


dvc.timeIndex= jQuery.inArray(myId, dvc.chartData.ons.area.index); 
updateChart();

			
	}	


	function out() {
		
		svg.select("#arcSelection").remove();
		svg1.select("#arcSelection").remove();
		
		dvc.timeIndex = 400;
		updateChart();

	}




////CHART STUFF
	
	
	    $(document).ready(function(){
			//load some data - config file
			loadchartData();
		});
		
		
		// to load json data driving the chart	
		function loadchartData()
		{
		
		var filepth = './svg/income.json';
		
		d3.json(filepth, function(json)	{
				dvc.chartData=json;
				
				console.log(json);
				makeChart();

		
		
			var pills = d3.select("#pills")
					.append("ul")
					.attr("class","nav nav-pills nav-justified");
					
		
			pills.selectAll("li")
				.data(dvc.chartData.ons.dimension.label)
				.enter()
				.append("li")
				.attr("class", function(d,i){if(i==3){return "active"}})
				.append("a")
				.attr("href","#")
				.attr("data-nm", function(d,i){return dvc.chartData.ons.dimension.index[i]})
				.attr("data-toggle","pill")
				.text(function(d,i){return d;})
				.on("click", swapMap);
			

			
			
//			<ul class="nav navbar-nav navbar-right">
//                  <li class="dropdown">
//                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <span class="caret"></span></a>
//                      <ul class="dropdown-menu" role="menu">
//                        <li><a href="#">Action</a></li>
//                        <li><a href="#">Another action</a></li>
//                        <li><a href="#">Something else here</a></li>
//                        <li class="divider"></li>
//                        <li><a href="#">Separated link</a></li>
//                      </ul>
//                 </li>
//               </ul>
			   
			var drop = d3.select("#menu")
					.append("ul")
					.attr("class","nav navbar-nav navbar-right")
					.append("li")
					.attr("class","dropdown");
					
			drop.append("a")
					.attr("href","#")
					.attr("class","dropdown-toggle")
					.attr("data-toggle", "dropdown")
					.text("Select earnings type")
					.append("span")
					.attr("class","caret");
					
			dropnext = drop.append("ul")
					.attr("class","dropdown-menu")
					.attr("role","menu");
					
			dropnext.selectAll("li")
					.data(dvc.chartData.ons.dimension.label)
					.enter()
					.append("li")
					//.attr("class", function(d,i){if(i==0){return "active"}})
					.append("a")
					.attr("href","#")
					.attr("data-nm", function(d,i){return dvc.chartData.ons.dimension.index[i]})
					//.attr("data-toggle","pill")
					.text(function(d,i){return d;})
					.on("click", swapMap);
			
			});			
			
		
		
		} //end loadchartData
	
		
			
		//make a chart function
		
		function makeChart()
		{
			//LET'S FIND OUT MORE ABOUT THE DATA
			//find length of series
			dvc.recordLength=dvc.chartData.ons.value.length;//number of records/variable breakdown (bars that will be created)
			dvc.index=d3.range(dvc.recordLength);//the number of records as a d3.range object
			dvc.timeLength=dvc.chartData.ons.value[0].length;//the number of geographic elements held in each bar
				
			

			
			//find minValue
			dvc.minValue = d3.min(dvc.chartData.ons.value, function(array) {
  				return d3.min(array);
			});
			
			///find max values
			dvc.maxValue = d3.max(dvc.chartData.ons.value, function(array) {
  				return d3.max(array);
			});
			
			
			//create x axis scale
			dvc.xScale=d3.scale.linear()
				.domain([Math.min(0,dvc.minValue),dvc.maxValue])
				.range([0,dvc.chartWidth])
				.nice();
				
			//create ordinal scale for y axis
			dvc.yScale = d3.scale.ordinal()
				.domain(dvc.chartData.ons.value)
				.rangeRoundBands([0, dvc.chartHeight], dvc.gapRatio);
				
			//for some reason, yScale.rangeBand is not reurning the right cellHeight so we manually calc here...	
			dvc.cellHeight=(1-dvc.gapRatio)*dvc.chartHeight/dvc.chartData.ons.value.length;
			
			//set up svg and append containers for chart and axes
			d3.select("#container").append("svg")
				.attr("id","mainChart")
				//.attr("width","50%")
				.attr("height","350px")
				.attr("viewBox","0 0 300 350")
				.attr("preserveAspectRatio","xMidYMin meet")
				.append("g")
				.attr("id","myAxes");
			
			//create basic graph
			d3.select("#mainChart")
				.append("g")
				.attr("id","grpBars")
				.attr("transform", "translate(" + dvc.xPadding + "," +dvc.yPadding + ")");
				
			//create main axis
			dvc.xAxis=d3.svg.axis()
					.scale(dvc.xScale)
					.orient("bottom")
					.ticks(8);
			d3.select("#myAxes").append("g")
				.attr("class","axis")
				.attr("transform","translate("+dvc.xPadding+","+(dvc.yPadding+dvc.chartHeight+10)+")")
				.call(dvc.xAxis);
				
				//create secondary axis
			dvc.xGrid=d3.svg.axis()
					.scale(dvc.xScale)
					.orient("bottom")
					.ticks(8)
					.tickSize(-(dvc.chartHeight+10));
			d3.select("#myAxes").append("g")
				.attr("class","grid")
				.attr("transform","translate("+dvc.xPadding+","+(dvc.yPadding+dvc.chartHeight+10)+")")
				.call(dvc.xGrid);
				
				var bar = d3.select("#grpBars").selectAll(".bar")
					.data(dvc.chartData.ons.value)
					.enter().append("g")
					.attr("class", "bar")
					.attr("transform", function(d, i) { return "translate(0," + dvc.yScale(i) + ")"; });
					 
				bar.append("rect")
					.attr("class","chartBars")
					.attr("id",function(d, i) { 
					return "bar" + dvc.chartData.ons.dimension.index[i];
					})
					.attr("height", dvc.cellHeight)
					.attr("x", function(d) { 
						return dvc.xScale(Math.min(0, d[dvc.timeIndex]));
					})
					.attr("width", function(d)	{
						return Math.abs(dvc.xScale(d[dvc.timeIndex]) - dvc.xScale(0));	
					});
 
				 //append some text to bar
				bar.append("text")
					.attr("x", function(d) {
						return dvc.xScale(1100);
					})
					.attr("class","barText")
					.attr("y", dvc.yScale.rangeBand() / 2)
					.attr("dy", ".35em")
					.text(function(d, i) { 
					//what text do you want on the label?
					return dvc.chartData.ons.dimension.label[i]; //we'll have the names from catLabels please
					});
				
					
			
					
				//add interaction bars...
				bar.append("rect")
					.attr("class","intBar")
					.attr("data-nm", function(d,i)	{
						return dvc.chartData.ons.dimension.label[i];
					})
					.attr("height",dvc.chartHeight/dvc.chartData.ons.value.length)
					.attr("x",0)
					.attr("width",dvc.chartWidth)
					.on("mouseover",function(d)	{
						d3.select(this).attr("class","intBarActive");
						//var objName = d3.select(this).attr("data-nm");
					})
					.on("mouseout",function(d)	{
						d3.select(this).attr("class","intBar");
					})
					.on("click",function(d)	{
						var bar=$(this).siblings()[0];
						var txt=$(this).siblings()[1];
						var status=d3.select(bar).attr("class");
						if (status=="chartBars")
						{
							d3.select(bar).attr("class","chartBarSel");
							d3.select(txt).attr("class","selText");
						}	else
						{
							d3.select(bar).attr("class","chartBars");
							d3.select(txt).attr("class","barText");
						}	
					})
							
			//add the area to display
			d3.select("#mainChart").append("text")
				.text(dvc.chartData.ons.area.label[dvc.timeIndex])
				.attr("id","txtTime")
				.attr("x", dvc.chartWidth*0.6)
				.attr("y", 30)
				.attr("pointer-events","none");
			
			//having sized and position the x for the bars, we now need to sort them into the default starting year
			/*dvc.index.sort(function(b, a) {
				return dvc.chartData.ons.value[a][dvc.timeIndex] - dvc.chartData.ons.value[b][dvc.timeIndex];
			})*/		
			dvc.yScale.domain(dvc.index);
			bar.attr("transform", function(d, i) {
					return "translate(0," + dvc.yScale(i) + ")";
			});
			
			//create and set titles and footnotes
				
//			d3.select("#mainChart").append("text")
//				.attr("id","chartUnits")
//				.attr("x",dvc.chartWidth)
//				.attr("y",dvc.chartHeight + dvc.yPadding +41)
//				.text(dvc.chartData.ons.concept.units);
			
			
			d3.select("#mainChart").append("text")
				.attr("id","yLabel")
				.attr("x",50)
				.attr("y",55)
				.text(dvc.chartData.ons.concept.units);
			
			
			/*Select bar in chart*/
			d3.selectAll(".chartBarSel").attr("class", "chartBars");
			d3.select("#bar" + dvc.first).attr("class", "chartBarSel");	
				
			
			// create a key
						
			key();
					
		}//end of makeChart
		
		
		function key(){
		
		var svg = d3.select("#key1").append("svg")
			.attr("id", "key")
		    .attr("width", 450)
		    .attr("height",80);
			
		var color = d3.scale.threshold()
 		   .domain(dvc.chartData.ons.range.index[dvc.varIndex])
 		   .range(["#0571B0","#92C5DE","#F7F7F7","#F4A582","#CA0020"]);

		
		
		var x = d3.scale.linear()
		    .domain([d3.min(dvc.chartData.ons.range.index[dvc.varIndex]), d3.max(dvc.chartData.ons.range.index[dvc.varIndex])]) /*range for data*/
		    .range([0, 280]); /*range for pixels*/
		
		var xAxis = d3.svg.axis()
		    .scale(x)
		    .orient("bottom")
    		.tickSize(15)
		    .tickValues(color.domain());
			
		var g = svg.append("g")
			.attr("transform", "translate(85,40)");
		
		g.selectAll("rect")
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
		
		g.call(xAxis).append("text")
			.attr("id", "caption")
			.attr("x", 55)
			.attr("y", -6)
			.text("Earnings per week (£'s)");
			
		g.append("rect")
			.attr("height", 8)
			.attr("x", -53)
			.attr("width", 30)
			.style("fill", '#ccc');
			
		g.call(xAxis).append("text")
			.attr("id", "nodata")
			.attr("x", -70)
			.attr("y", 26)
			.text("* see note");
			
		}
		
		
		function markBars()
		{		
			//need to set some text to explain what the marks mean...
			if (dvc.bMark)
			{
				//reset
				d3.select("#grpBars").selectAll("rect.barMarker")
					.transition()
					.duration(500)
					.attr("height",function (d,i)	{
						return 0;;
					})
				d3.select("#grpBars").selectAll(".chartBars,.chartBarSel")
					.transition()
					.duration(500)
					.attr("height",function (d,i)	{
						return dvc.cellHeight;
					})
				$("#btnMark").button( "option", "label", "mark" );
				$("#btnMark").button( "option", "icons", {primary:'ui-icon-pin-s'} );
				dvc.bMark=false;
				d3.select("#markText").text("");
			}	else
			{
				//set marker
				d3.select("#grpBars").selectAll("rect.barMarker")
					.attr("width", function(d)	{
						return Math.abs(dvc.xScale(d[dvc.timeIndex]) - dvc.xScale(0));	
					})
					.attr("x", function(d) { 
						return dvc.xScale(Math.min(0, d[dvc.timeIndex]));
					})
					.transition()
					.duration(500)
					.attr("height",function (d,i)	{
						return dvc.cellHeight/2;
					});
					
					
					
				d3.select("#grpBars").selectAll(".chartBars,.chartBarSel")
					.transition()
					.duration(500)
					.attr("height",function (d,i)	{
						return dvc.cellHeight/2;
					})
					
					
					
					
				
				$("#btnMark").button( "option", "label", "clear" );
				$("#btnMark").button( "option", "icons", {primary:'ui-icon-close'} );
				dvc.bMark=true;
				d3.select("#markText").text("markers show "+dvc.chartData.ons.area.label[dvc.timeIndex]);
			}
		}
		
	
		function updateChart()
		{
			//select the bar groups
			
			var bar = d3.select("#grpBars").selectAll(".bar")

			//sort the data
			/*dvc.index.sort(function(b, a) {
				return dvc.chartData.ons.value[a][dvc.timeIndex] - dvc.chartData.ons.value[b][dvc.timeIndex];
			})*/		
			
			//then apply it to the yscale
			/*dvc.yScale.domain(dvc.index);*/
			
			//select bars and apply transitions to width and x
			bar.selectAll(".chartBars, .chartBarSel")
				.transition()
				.duration(300)
				.attr("width", function(d)	{
						return Math.abs(dvc.xScale(d[dvc.timeIndex]) - dvc.xScale(0));	
				})
				.attr("x", function(d) { 
						return dvc.xScale(Math.min(0, d[dvc.timeIndex]));
			});
			
			var char = d3.selectAll(".barText2") ;	
			char.remove();
			
			
			bar.append("text")
					.attr("x", function(d) {
						return dvc.xScale(0) + 2;
					})
					.attr("class","barText2")
					.attr("fill", function(d, i) {if(dvc.chartData.ons.value[i][dvc.timeIndex] !==0){
						return "#fff"
					} else {
						return "#666"
					}
					})
					.attr("y", dvc.yScale.rangeBand() / 2)
					.attr("dy", ".35em")
					.text(function(d, i) {if(dvc.chartData.ons.value[i][dvc.timeIndex] !==0){
					//what text do you want on the label?
					return  parseInt(dvc.chartData.ons.value[i][dvc.timeIndex]);
					} else{
					return  '*';
					}
						//we'll have the dataValue please
			});
			
			
			
			
			
			//update time slider and time label
			
			d3.select("#txtTime")
			.text(dvc.chartData.ons.area.label[dvc.timeIndex]);
			
			//apply transition on the y axis
			bar.transition()
				.duration(1000)
				.delay(function(d, i) {
					return i * 50;
				})
				.attr("transform", function(d, i) {
					return "translate(0," + dvc.yScale(i) + ")";
				});
		}
		
		function makeTinyUrl()
		
		{
		var longUrl = document.URL;
		$.shortenUrl(longUrl, function(short_url) {
		   post2Twitter(short_url);
		});
		
		}
		
		function post2Twitter(shortURL)
		
		{
			var myLoc = "of England & Wales";
			var myString="http://twitter.com/home?status="+escape("How do your earnings compare in your area? #earnings #map "+shortURL+" via @statisticsONS #ons");
			window.open(myString);
		
		}
		
		
		function makeFace()
		{
		
		var face = 'http://www.facebook.com/share.php?u=' + window.location.href;
			window.open(face);
		}
		
		function showEmbed()
		{
		
		$('#embedurl').val('<iframe width=940 height=660 src="' + document.URL + '" scrolling=no frameborder=0/>');
		$('#embedbox').show(400);
		
		}
		
		function embedHide()
		{
		
		$('#embedbox').hide(400);
		}
		
		
		function updateHash() {
	
		  window.location.hash = encodeURI("select=" + dvc.first + "&name=" + dvc.lab + "&ind=" + dvc.varIndex);
			
		}
		
		function getParams() {

		  firstbit = window.location.href.split(".html")[0];
		
		  var url = decodeURI(window.location.hash);
		
		  if(url != "") {		
				params = url.split("&");
				dvc.first = params[0].split("=")[1];
				dvc.lab= params[1].split("=")[1];
				dvc.varIndex=params[2].split("=")[1];
				
		  } else {
				/*first variable*/
				dvc.first='full'; 
				dvc.lab='All';
				dvc.varIndex='0'; 
		  }
		}


    if (pymChild) {
        pymChild.sendHeight();
    }

	
})

} 	else  // from modernizer
	
	{
		$("#ieMsg").fadeIn(1000);
		
	}
