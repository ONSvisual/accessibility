
//Check whether inline svg is supported

if(Modernizr.inlinesvg==true) {

pymChild = new pym.Child();


function initialise() {

	
	dvc = {};
	
	numberFormat = d3.format(",.0f");
	msoa = null;
	laCode = null;
	
	//Statistics
	housePrice = null;
	Income_Est = null;
	
	//ASSUMPTIONS
	lendAmount = 4.5; //subject to change
	depositAmount = 15; //subject to change
	balanceAmount = 100-depositAmount; //subject to change
	Stamp_Duty = null;
	conveyancingFees = 1200; //subject to change
	surveyCosts = 0; //subject to change
	removalCosts = 0; //subject to change
	otherFees = 800; //subject to change
	
	E_W_Average = (140000/100)*balanceAmount;
	E_W_Average_Income_Required = E_W_Average / lendAmount;
	
	allFees = conveyancingFees + surveyCosts + removalCosts + otherFees;
	totalSavings = null;
	
	fromPrice = 0;
	fromPriceText = "";
	
	checkTheSame = null;
	
	
	
	//╭━━╮╱╱╱╱╱╱╱╱╭╮
	//╰┫┣╯╱╱╱╱╱╱╱╭╯╰╮
	//╱┃┃╭━╮╭━━┳╮┣╮╭╋━━╮
	//╱┃┃┃╭╮┫╭╮┃┃┃┃┃┃━━┫
	//╭┫┣┫┃┃┃╰╯┃╰╯┃╰╋━━┃
	//╰━━┻╯╰┫╭━┻━━┻━┻━━╯
	//╱╱╱╱╱╱┃┃
	//╱╱╱╱╱╱╰╯
	
	$("#pcError").hide();
	$("#successMessage").hide();
	$("#pcGo").click(function( event ) {
		//console.log("helloyou");
			//	event.preventDefault();
			//	event.stopPropagation();
				myValue = $("#pcText").val(); 
				myValue = myValue.toUpperCase();
				
					//manual method for area lookup
					myValue2 = myValue.replace(/\s+/g, ''); 
					
					getCodes1(myValue2);
					
					//console.log("helloyou");  			
	});
	

	
	
	$("#pcText").keypress(function( event ) {
		if (event.which == 13) {
				event.preventDefault();
				event.stopPropagation();
				myValue = $("#pcText").val(); 
				myValue = myValue.toUpperCase();
				
					//manual method for area lookup
					myValue2 = myValue.replace(/\s+/g, ''); 
					
					getCodes1(myValue2);  
		}
	});
	
	MSOA = null;
	LAname = null;
	
	//╭━━━╮╱╱╭╮╱╭━━━╮
	//┃╭━╮┃╱╭╯╰╮┃╭━╮┃
	//┃┃╱╰╋━┻╮╭╯┃┃╱┃┣━┳━━┳━━╮
	//┃┃╭━┫┃━┫┃╱┃╰━╯┃╭┫┃━┫╭╮┃
	//┃╰┻━┃┃━┫╰╮┃╭━╮┃┃┃┃━┫╭╮┃
	//╰━━━┻━━┻━╯╰╯╱╰┻╯╰━━┻╯╰╯
	
	//your location
	d3.select(".useLocation").on("click",function(){
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition);
		} else {
			//x.innerHTML = "Geolocation is not supported by this browser.";
		}
	});
}

function showPosition(position) {
    latitudeValue = position.coords.latitude;
	longitudeValue = position.coords.longitude; 
	
	getCodes2(latitudeValue,longitudeValue);
}


function getCodes1(myValue2)    {
	
	//console.log("hellocodes");
    var myURIstring=encodeURI("https://api.postcodes.io/postcodes/"+myValue2);
    $.support.cors = true; 
    $.ajax({
        type: "GET",
        crossDomain: true,
        dataType: "jsonp",
        url: myURIstring,
        error: function (xhr, ajaxOptions, thrownError) {
                $("#pcError").text("Sorry, that's not a valid postcode. Try an English or Welsh postcode eg PO15 5RR.").show();
            },
        success: function(data1){
            if(data1.status == 200 ){
				
				             
                $("#pcError").hide();
                MSOA =data1.result.msoa.replace(/\s/g,'');
				laCode =data1.result.codes.admin_district;
			
               // LAname = data1.result.admin_district;
							
				//fire the function returning statistics
				drawStats();
				
				gotoArea(data1.result.latitude,data1.result.longitude);
				
				
            } else {
      $("#successMessage").hide();
                $("#pcError").text("Sorry, that's not a valid postcode. Try an English or Welsh postcode eg PO15 5RR.").show();
            }
        } 
    });
}


function getCodes2(lat,lng)    {
	
	
    var myURIstring=encodeURI("https://api.postcodes.io/postcodes?lon="+lng+"&lat="+lat);
    $.support.cors = true; 
    $.ajax({
        type: "GET",
        crossDomain: true,
        dataType: "jsonp",
        url: myURIstring,
        error: function (xhr, ajaxOptions, thrownError) {
                $("#pcError").text("Sorry, that's not a valid postcode. Try an English or Welsh postcode eg PO15 5RR.").show();
            },
        success: function(data1){
            if(data1.status == 200 ){
				
				             
                $("#pcError").hide();
                MSOA =data1.result[0].msoa.replace(/\s/g,'');
			
               // LAname = data1.result[0].admin_district;
				
				//console.log(MSOA);
			
				//fire the function returning statistics
				drawStats();
				
				gotoArea(data1.result[0].latitude,data1.result[0].longitude);
				
				
            } else {
      $("#successMessage").hide();
                $("#pcError").text("Sorry, that's not a valid postcode. Try an English or Welsh postcode eg PO15 5RR.").show();
            }
        } 
    });
}




function areaName() {
	d3.select("#placeNameDisplay").style("display","block");
	d3.select("#placeNameName").text(LAname);
}



//╭━━━╮╱╱╱╱╱╱╱╱╱╱╭━━━╮╭╮╱╱╱╭╮
//╰╮╭╮┃╱╱╱╱╱╱╱╱╱╱┃╭━╮┣╯╰╮╱╭╯╰╮
//╱┃┃┃┣━┳━━┳╮╭╮╭╮┃╰━━╋╮╭╋━┻╮╭╋━━╮
//╱┃┃┃┃╭┫╭╮┃╰╯╰╯┃╰━━╮┃┃┃┃╭╮┃┃┃━━┫
//╭╯╰╯┃┃┃╭╮┣╮╭╮╭╯┃╰━╯┃┃╰┫╭╮┃╰╋━━┃
//╰━━━┻╯╰╯╰╯╰╯╰╯╱╰━━━╯╰━┻╯╰┻━┻━━╯

function drawStats() {
	//d3.select("#visualWrapper").style("display","block");
	//d3.select("#visualWrapper").transition().duration(1000).style("opacity","1");
	//d3.select("#mapWrapper").style("display","block");
	//d3.select("#mapWrapper").transition().duration(1000).style("opacity","1");
	
		//reading in the data
		//d3.csv("data/Cut/" + laCode + ".csv", function(data) {
	    d3.csv("data/Cut2/" + MSOA + ".csv", function(data) {
			
			dvc.dataObj = data;	
			
			//console.log(data);	

			//filter the data
			filtereddata = dvc.dataObj.filter(function(d) {return d.MSOA_name == MSOA});
			
			housePrice = filtereddata[0].House_Price;
			Stamp_Duty = filtereddata[0].Stamp_Duty;
			Income_Est = filtereddata[0].Income_Est;
			LAname = filtereddata[0].Local_authority_name;
			
	
			housePriceX = Number(housePrice);
			Balance_85pcntX = (housePriceX/100)*balanceAmount;
				BalenceDiv = Balance_85pcntX/lendAmount;
				
			depositValueX = (housePriceX/100)*depositAmount;
			Stamp_DutyX = Number(Stamp_Duty);
			Income_EstX = Number(Income_Est);
				Income_Est2 = Income_EstX / 7;
				Income_Est3 = Income_Est2 * 365.24;
				
								
			//Total savings required
			//this is all assumed costs, plus the deposit, plus stamp duty.		
			
			totalSavings = depositValueX + Stamp_DutyX + allFees;
			
			//edits footnote to contain correct info
			d3.select("#footnoteDeposit").text(depositAmount);
			d3.select("#footnoteSalary").text(lendAmount);
			
			
			//puts stamp duty value in assumptions view
			d3.select("#stampDutyDisplay").text(numberFormat(Stamp_DutyX));
			
			window.odometerOptions = {
			  format: '(,ddd)',
			  duration: 1000, // Change how long the javascript expects the CSS animation to take
			};
			
			//d3.select("#savingsOf").text("£0")			
			d3.select("#savingsOf").text(numberFormat(totalSavings))
			
			//d3.select("#propertyPrice").text("£0")			
			d3.select("#propertyPrice").text(numberFormat(housePriceX))
			
			//d3.select("#householdIncome").text("£0")			
			d3.select("#householdIncome").text(numberFormat(Income_Est3))
			
			d3.select("#assumptionWrapper").transition().delay(1000).duration(1000).style("display","block").style("opacity","1");
			
			//fire the function dealing with area name displayed
			areaName();
			
			
			drawGraphic();
	});
}


			

//╭━━━╮╱╱╱╱╱╱╱╱╱╱╭━━━┳╮╱╱╱╱╱╱╭╮
//╰╮╭╮┃╱╱╱╱╱╱╱╱╱╱┃╭━╮┃┃╱╱╱╱╱╭╯╰╮
//╱┃┃┃┣━┳━━┳╮╭╮╭╮┃┃╱╰┫╰━┳━━┳┻╮╭╋━━╮
//╱┃┃┃┃╭┫╭╮┃╰╯╰╯┃┃┃╱╭┫╭╮┃╭╮┃╭┫┃┃━━┫
//╭╯╰╯┃┃┃╭╮┣╮╭╮╭╯┃╰━╯┃┃┃┃╭╮┃┃┃╰╋━━┃
//╰━━━┻╯╰╯╰╯╰╯╰╯╱╰━━━┻╯╰┻╯╰┻╯╰━┻━━╯

graphic = $(".resultsChart");
function drawGraphic() {
	
	graphic.empty();
	
			barheight = 40;
			margin = {}
			margin.left = 0;
			margin.right = 0;
			margin.top = 0;
			margin.bottom = 70;
			graphic_width = graphic.width() - margin.left - margin.right;
						
			var height = barheight + margin.top + margin.bottom;
		
			var data = [E_W_Average_Income_Required];
			
			var x = d3.scale.linear()
				.domain([0,150000])
				.range([0,graphic_width]);
				
			var chart = d3.select(".resultsChart")
				.attr("width", graphic_width)
				.attr("height", height);

			
			var bar = chart.append("svg")
				.attr("width", graphic_width)
				.attr("height", height)
				.attr("id","chartAreaStuff")
			      
			//Reset the text value to 0 so it animates up
			d3.select("#incomeOfNumber").text("");
			                         
			//grey backing
			bar.append("rect")
				.attr("width", function(d) { return x(150000); })
				.attr("height", barheight)
				.attr("transform","translate(0,30)")
				.attr("fill","#f4f4f4");
				
			//data bar
			bar.append("rect")
				.attr("width",fromPrice)
				.attr("height", barheight)
				.attr("transform","translate(0,30)")
				.attr("fill","#007F7F")
				.transition().duration(2000).attr("width", function(d) { return x(BalenceDiv); });
			
			//average bar
			bar.append("rect")
				.attr("width","3")
				.attr("height", barheight + 25)
				.attr("transform","translate(" + x(E_W_Average_Income_Required) + ",5)")
				.attr("fill","orange");
				
					
			//your text (Not SVG, in div above to apply odometer animation)
			d3.select("#incomeOfNumber").text(numberFormat(BalenceDiv))
										.style("text-anchor","start")
										.style("font-size","34px")
										.style("font-weight","bold")
										.style("color","#007F7F")
										.style("margin-top","10px");
							
			//average text
			var text = d3.select("#chartAreaStuff")
                        .append("text")
							.text("E&W average** (£" + numberFormat(E_W_Average_Income_Required) + ")")
							.attr("x", function(d) { return x(E_W_Average_Income_Required) + 10 })
							.attr("y","20")
							.attr("text-anchor","start")
							.attr("font-size","16px")
							.attr("fill","grey")
							.attr("id","EWAverageText");
							
			//axis text
			var text = d3.select("#chartAreaStuff")
                        .append("text")
							.text("£0k")
							.attr("x","0")
							.attr("y","95")
							.attr("text-anchor","start")
							.attr("font-size","14px")
							.attr("fill","grey");
			var text = d3.select("#chartAreaStuff")
                        .append("text")
							.text("£50k")
							.attr("x", function(d) { return x(50000) })
							.attr("y","95")
							.attr("text-anchor","middle")
							.attr("font-size","14px")
							.attr("fill","grey");
			var text = d3.select("#chartAreaStuff")
                        .append("text")
							.text("£100k")
							.attr("x", function(d) { return x(100000) })
							.attr("y","95")
							.attr("text-anchor","middle")
							.attr("font-size","14px")
							.attr("fill","grey");
			var text = d3.select("#chartAreaStuff")
                        .append("text")
							.text("£150k +")
							.attr("x", function(d) { return x(150000) })
							.attr("y","95")
							.attr("text-anchor","end")
							.attr("font-size","14px")
							.attr("fill","grey");
							
			//axis tick marks
			bar.append("rect")
				.attr("width","1")
				.attr("height", 10)
				.attr("transform","translate(" + x(0) + ",70)")
				.attr("fill","#dadada");
		
			bar.append("rect")
				.attr("width","1")
				.attr("height", 10)
				.attr("transform","translate(" + x(50000) + ",70)")
				.attr("fill","#dadada");
		
			bar.append("rect")
				.attr("width","1")
				.attr("height", 10)
				.attr("transform","translate(" + x(100000) + ",70)")
				.attr("fill","#dadada");
				
			bar.append("rect")
				.attr("width","1")
				.attr("height", 10)
				.attr("transform","translate(" + x(149800) + ",70)")
				.attr("fill","#dadada");
				
			setTimeout(function() {fromPrice = x(BalenceDiv)},1500);
							
			

			//use pym to calculate dimensions	
		   if (pymChild) {
		       pymChild.sendHeight();
		   }
}


//╭━━━╮╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭╮
//┃╭━╮┃╱╱╱╱╱╱╱╱╱╱╱╱╱╭╯╰╮
//┃┃╱┃┣━━┳━━┳╮╭┳╮╭┳━┻╮╭╋┳━━┳━╮╭━━╮
//┃╰━╯┃━━┫━━┫┃┃┃╰╯┃╭╮┃┃┣┫╭╮┃╭╮┫━━┫
//┃╭━╮┣━━┣━━┃╰╯┃┃┃┃╰╯┃╰┫┃╰╯┃┃┃┣━━┃
//╰╯╱╰┻━━┻━━┻━━┻┻┻┫╭━┻━┻┻━━┻╯╰┻━━╯
//╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱┃┃
//╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰╯


//deals with the changing of assumptions
d3.select(".editAssumptions").on("click", function() {
	d3.select("#toolView").transition().duration(525).style("opacity","0").transition().delay(500).style("display","none");
	d3.select("#assumptionsView").transition().delay(525).duration(525).style("display","block").style("opacity","1");
	fromPrice = 0; //resets to 0 for full animation effect whon closing view.	
});

				//now the functions that will change the assumption variables
				d3.select("#manualDeposit").on("change", function(){
					depositAmount = $("#manualDeposit").val(); 
						balanceAmount = 100-depositAmount;
						E_W_Average = (140000/100)*balanceAmount;
						E_W_Average_Income_Required = E_W_Average / lendAmount;
						fromPrice = 0;
				});

				d3.select("#manualConveyance").on("change", function(){
					conveyancingFees = $("#manualConveyance").val(); 
						allFees = Number(conveyancingFees) + Number(surveyCosts) + Number(removalCosts) + Number(otherFees);
						fromPrice = 0;
				});
				
				d3.select("#manualOther").on("change", function(){
					otherFees = $("#manualOther").val(); 
						allFees = Number(conveyancingFees) + Number(surveyCosts) + Number(removalCosts) + Number(otherFees);
						fromPrice = 0;
				});
				
				d3.select("#manualLendAmount").on("change", function(){
					lendAmount = $("#manualLendAmount").val();
						E_W_Average_Income_Required = E_W_Average / lendAmount;
						fromPrice = 0;
				});


//reset stuff
d3.select(".editAssumptionsReset").on("click", function(){ 
	$("#manualDeposit").val(15);					
						depositAmount = $("#manualDeposit").val(); 
						balanceAmount = 100-depositAmount;
						E_W_Average = (140000/100)*balanceAmount;
						E_W_Average_Income_Required = E_W_Average / lendAmount;
						fromPrice = 0;
	$("#manualConveyance").val(1200);
						conveyancingFees = $("#manualConveyance").val(); 
						allFees = Number(conveyancingFees) + Number(surveyCosts) + Number(removalCosts) + Number(otherFees);
						fromPrice = 0;
	$("#manualOther").val(800);
						otherFees = $("#manualOther").val(); 
						allFees = Number(conveyancingFees) + Number(surveyCosts) + Number(removalCosts) + Number(otherFees);
						fromPrice = 0;
	$("#manualLendAmount").val(4.5);
						lendAmount = $("#manualLendAmount").val();
						E_W_Average_Income_Required = E_W_Average / lendAmount;
						fromPrice = 0;
});

d3.select(".editAssumptionsBack").on("click", function() {
	d3.select("#assumptionsView").transition().duration(525).style("opacity","0").transition().delay(500).style("display","none");
	d3.select("#toolView").transition().delay(525).duration(525).style("display","block").style("opacity","1");




	
	
	setTimeout(function() {
		
	
			myValue = $("#pcText").val(); 
			myValue = myValue.toUpperCase();
			
				//manual method for area lookup
				myValue2 = myValue.replace(/\s+/g, ''); 
				
				getCodes1(myValue2);  
								
	},550);
});



//
//if (pymChild) {
//    pymChild.sendHeight();
//}

		
//Social media

//$("#share1").empty();
//$("#share2").empty();
//d3.select("#share").style("display","block");
//fireSocial();
function fireSocial() {
	
d3.select("#share1").append("a")
	.attr("href","https://www.facebook.com/sharer/sharer.php?u=")
	.attr("target","_blank")
	.attr("class","share")
	.style("display","block")
	.style("height","25px")
	.style("width","25px")
	.style("background","#3B5998")
	.style("margin-top","0px")
	.style("margin-bottom","10px")
	.append("img")
	.style("padding-left","5px")
	.style("padding-top","3px")
	.attr("src","./images/facebook.svg");
	
d3.select("#share2").append("a")
	.attr("href",encodeURI("https://twitter.com/intent/tweet?text=Find out where you can afford to buy a home at http://visual.ons.gov.uk/prospective-homeowners-struggling-to-get-onto-the-property-ladder/"))
	.attr("target","_blank")
	.attr("class","share")
	.style("display","block")
	.style("height","25px")
	.style("width","25px")
	.style("background","#4099FF")
	.append("img")
	.style("height","22px")
	.style("width","22px")
	.style("padding-left","3px")
	.style("padding-top","3px")
	.attr("src","./images/twitter.svg");
}


//if (pymChild) {
//   pymChild.sendHeight();
//}
		 
		 
		 //╭━╮╭━╮
//┃┃╰╯┃┃
//┃╭╮╭╮┣━━┳━━┳━━┳┳━╮╭━━╮
//┃┃┃┃┃┃╭╮┃╭╮┃╭╮┣┫╭╮┫╭╮┃
//┃┃┃┃┃┃╭╮┃╰╯┃╰╯┃┃┃┃┃╰╯┃
//╰╯╰╯╰┻╯╰┫╭━┫╭━┻┻╯╰┻━╮┃
//╱╱╱╱╱╱╱╱┃┃╱┃┃╱╱╱╱╱╭━╯┃
//╱╱╱╱╱╱╱╱╰╯╱╰╯╱╱╱╱╱╰━━╯

    // Copyright (c) 2013 Ryan Clark
    // https://gist.github.com/rclark/5779673
	function ready (error, topoMSOA, topoLAD, boundsData, config){
						  
					if($(window).width() >= 650){
 
						  
						  L.TopoJSON = L.GeoJSON.extend({
						  addData: function(jsonData) {    
							if (jsonData.type === "Topology") {
							  for (key in jsonData.objects) {
								geojson = topojson.feature(jsonData, jsonData.objects[key]);
								L.GeoJSON.prototype.addData.call(this, geojson);
							  }
							}    
							else {
							  L.GeoJSON.prototype.addData.call(this, jsonData);
							}
						  }  
						});
					  
						dvc.config = config
							
						d3.select("#graphic").remove();
						//dvc = {};
						dataLayer = [];
						dataObj = [];
						
							
						
						if(dvc.config.ons.varcolour instanceof Array) {
							dvc.colour = dvc.config.ons.varcolour 
						} else {
							dvc.colour = eval("colorbrewer." + dvc.config.ons.varcolour);
						}
						
						highlighted = 0;
						dvc.curr = dvc.config.ons.varload;
						a = 0;
						dvc.unittext = dvc.config.ons.varunit[a];
						dvc.label = dvc.config.ons.varlabel[a];
						dvc.prefix = dvc.config.ons.varprefix[a];
					
					
						
						//data2 = data;
						config2 = dvc.config;
							
						if(dvc.config.ons.varlabel.length > 1)
							{navigation(config2);}
						else {d3.selectAll("#varsel").attr("class","hidden")};
						
					
					
						
						if(dvc.config.ons.breaks =="jenks")
							{breaks = ss.jenks(values, 5);}
						else {breaks = dvc.config.ons.breaks[a];};
							
						layerx = L.tileLayer('http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}@2x.png',{
						  attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> &copy; <a href="http://cartodb.com/attributions">CartoDB background</a>'
						});
					   
						map = L.map('map',{maxZoom:13,minZoom:10}),
						
					
						//Set-up colour scale
						color = d3.scale.threshold()
								.domain(breaks.slice(1,5))
								.range(dvc.colour);
								
						//Set initial centre view and zoom layer
						map.setView(eval(dvc.config.ons.centre), dvc.config.ons.zoom).addLayer(layerx);
						
					
					
						map.on("zoomstart", leaveLayer)
						map.on("zoomend", function(){setTimeout(function(){highlightArea()},150)})
						
					
						  
						d3.select(".leaflet-top").style("top","70px");
						createKey(dvc.config);
					
					
						//Set-up new Topojson layer (for LAs)
						
						  topoLayerLA= new L.TopoJSON();
					
						  topoLayerLA.addData(topoLAD);
						  topoLayerLA.eachLayer(handleLayerLAD);
						  topoLayerLA.addTo(map);
						
					
						topoLayer = [];
						
						boundarySearch(boundsData.regions);
						
						//Get bounds of map
						
						// Handle map movement
						map.on('moveend', function(e) {
							
							boundarySearch(boundsData.regions);
							
						});
						
						}
						
						//first firing on load
								
						setTimeout(function() {
					//	$( document ).ready(function( event ) {	
						
								myValue = $("#pcText").val(); 
								myValue = myValue.toUpperCase();
								
								//manual method for area lookup
								myValue2 = myValue.replace(/\s+/g, ''); 
								getCodes1(myValue2); 	
								
								d3.select("#toolView").transition().duration(750).style("opacity","1");
								
								fireSocial();
								pymChild.sendHeight();
					//	});
						},1000);
	} // end ready
	
	function handleLayerLAD(layer){
		
		x = layer.feature.properties.LAD13CD;

		//fillColor = color(rateById[x]);
		
        layer.setStyle({ 
		  fillColor: '#fff',
          fillOpacity: 0,
          color:'#fff',
          weight:0,
          opacity:1,
		  className: x
        });
	
    }
	
	
	function handleLayerMSOA(layer){
		
		x = layer.feature.properties.MSOA11CD + " MSOA";
		x2 = layer.feature.properties.MSOA11CD;
		x3 = layer.feature.properties.MSOA11NM.replace(/\s/g,'');
		
		//console.log(layer.feature.properties);
	
		fillColor = color(rateById[x2]);
		//console.log(fillColor);
		
        layer.setStyle({
		  fillColor: fillColor,
          fillOpacity: 0.7,
          color:'#fff',
          weight:0.7,
          opacity:1,
		  className: x + " " + x3
        });
	
    }
	

    function mouseEvents(){

	  
	  var xy = d3.select(".leaflet-overlay-pane").selectAll(".MSOA");
  
	  xy.on("mouseout",leaveLayer).on("mouseover",enterLayer).on("click",clicked);
	  
    }

  	function clicked(d) {
	  if (d3.event.defaultPrevented) return;
	  
	  selectArea(this);
	  
	  //MSOA = d3.select(this).attr("class").split(' ')[2];
	  
	  MSOA = d3.select(this).attr("class").split(' ')[2];
		
		//console.log(MSOA);
		
	  drawStats();
	  
	}
	
	function getLatLng(){
		
	}
	
	function selectArea(xx) {
		
					
				selected=true;
				myId = d3.select(xx).attr("class").split(' ')[0];
				currclass = d3.select(xx).attr("class").split(' ')[0];
				
				highlightArea();
				$("#occselect").val(currclass);
				$("#occselect").trigger("chosen:updated");		
				
				d3.select(".leaflet-overlay-pane").selectAll(".MSOA").on("mouseout",null).on("mouseover",null);
				
				//indexarea = document.getElementById("occselect").selectedIndex;
				//pymChild.sendMessage('navigate', indexarea + " " + dvc.time);	
	}
	
  
  
  
	
	function enterLayer(){
		currclass = d3.select(this).attr("class").split(' ')[0];
		highlightArea();
		
	}

    function highlightArea(){
		
		//console.log(currclass);
		
		d3.select('#selected').remove();
		
		//console.log(currclass);
		var currpath = d3.select("." + currclass).attr("d");
		
		d3.select(".leaflet-overlay-pane").select("svg").append("path")
				.attr("d",currpath)
				.attr("id","selected")
				.attr("class", "arcSelection")
				.attr("pointer-events", "none")
				.attr("fill", "none")
				.attr("stroke", "#b4005a")
				.attr("stroke-width", "2");
		
	
		/* Display name of area*/
		d3.select("#areanm").text(areaById[currclass]);
		d3.select("#areainfo").html(function(d,i){if (!isNaN(rateById[currclass]))  {return "<span>" + dvc.unittext + "</span>" + dvc.prefix + rateById[currclass] } else {return "Data unavailable"}});


    }

    function leaveLayer(){

		d3.select('#selected').remove();
		d3.select("#areanm").text("");
		d3.select("#areainfo").text("");
    }
	
	
	
	
	function boundarySearch(regions) {

	//console.log(regions);
	oldDistricts = dvc.districtsInView;
	
	//console.log(oldDistricts);
	
	districtsInView = [];
	
	
	updateBoundaryData();
	
	

	function updateBoundaryData(mapBounds) {

		mapBounds = map.getBounds();

		var districtsInView = [],
			regionCodes = Object.keys(regions),
			regionBounds,
			districts,
			districtCodes, 
			districtBounds,
			bounds;
	

		for (var i = 0; i < regionCodes.length; i++) {
			
			regionBounds = regions[regionCodes[i]].bounds;

			//console.log(mapBounds);

			if (mapBounds.intersects(regionBounds)) {

				districts = regions[regionCodes[i]].districts;	
				districtCodes = Object.keys(districts);

				for (var j = 0; j < districtCodes.length; j++) {

					districtCode = districtCodes[j];
					districtBounds = districts[districtCode].bounds;

					if (mapBounds.intersects(districtBounds)) {

						districtsInView.push(districtCode);
					}
				}
			}
		}

		districtsInView = districtsInView;
		dvc.districtsInView = districtsInView;
		
		
		addRemoveAreas(oldDistricts,districtsInView);
	};
};
	
function addRemoveAreas(oldDistricts, newDistricts) {
		
	
	areasToAdd = $(newDistricts).not(oldDistricts).get();
	
	var areasToRemove = $(oldDistricts).not(newDistricts).get();
	
		 
	areasToRemove.forEach(function(d,i) {
		 map.removeLayer(topoLayer[d]);
		 
		 removeData(d);
		
	});
	
	leng = areasToAdd.length;
				
	areasToAdd.forEach(function(d,i) {
	
		//var jsonPath = 'lsoa_by_lad/topo_' + d + '.json';
		//console.log(jsonPath);	
		
		d3.json('https://cdn.ons.gov.uk/assets/topojson/msoa_by_lad/topo_' + d + '.json', function(error, distData) {
			
			//console.log('https://cdn.ons.gov.uk/assets/topojson/msoa_by_lad/topo_' + d + '.json');
			
			d3.csv('data/Cut/' + d + '.csv', function(error, csvData) {
			  
			  buildDataInView(d,csvData);
			  
			  topoLayer[d] = new L.TopoJSON();
			  
			  topoLayer[d].on('click', function(e) {
				  gotoArea(e.latlng.lat,e.latlng.lng);
					
			   });
				

			  topoLayer[d].addData(distData);
			  topoLayer[d].eachLayer(handleLayerMSOA);
			  topoLayer[d].addTo(map);
			
			  
			
			  mouseEvents();
			  
			  
			  
			  
			  if(highlighted == d) {
				  areaHigh = leafletPip.pointInLayer([storeLong,storeLat], topoLayer[d]);
				  
				  currclass = areaHigh[0].options.className.split(' ')[0];
				  //console.log(areaHigh[0].options.className.split(' ')[0]);
				
				highlightArea();
				
			  }
	
	
	
			 if(i == leng-1 && highlighted !=0) {
				d3.select(".leaflet-overlay-pane").selectAll(".MSOA").on("mouseout",null).on("mouseover",null);
			 }
			  
			});
		
		});
		
	});
	
	


	 
	

}


	function buildDataInView(d,csvData) {
		  
			dataObj[d] = csvData;
			
			dataLayer.push(dataObj[d]) ;
			
			flattenedData = [].concat.apply([],dataLayer);
			
			rateById = {};
			areaById = {};
			
			//console.log(flattenedData);
	
			flattenedData.forEach(function(d) {rateById[d.MSOA_code] = +eval("d.House_Price"); areaById[d.MSOA_code] = d.MSOA_name});
			
	}
	
	function removeData(d,csvData) {
		  
		  	delete dataLayer[d]; 
		  
			//console.log(d);
			
			flattenedData = [].concat.apply([],dataLayer);
	
	}

	
	
	
	function createKey(config){
		
		var mapTitle = d3.select("#mapTitleText")
			.append("svg")
				.attr("id","mapDescription")
				.attr("width","295px")
				.attr("height","40px")
				.attr("z-index","6")
				.style("padding-left","10px")
				.attr("fill","#007F7F")
					.append("text")
					.text("Entry level property price* (£)")
					.attr("text-anchor","start")
					.attr("font-size","20px")
					.attr("transform","translate(0,30)");
					
		
		var svgkey = d3.select("#keydiv")
			.append("svg")
			.attr("id", "key")
		    .attr("height", 300);
		
		newbreaks = breaks;
	
		var color = d3.scale.threshold()
		   .domain(newbreaks)
		   .range(dvc.colour);

		//console.log(color.domain());

		y = d3.scale.linear()
		    .domain([newbreaks[0], breaks[5]]) /*range for data*/
		    .range([250, 0]); /*range for pixels*/

		keywidth = $("#keydiv").width();	
		
		x = d3.scale.linear()
		    .domain([newbreaks[0], breaks[5]]) /*range for data*/
		    .range([0,keywidth-50]); /*range for pixels*/

		var xAxis = d3.svg.axis()
		    .scale(x)
		    .orient("bottom")
    		.tickSize(15)
		    .tickValues(color.domain())
			.tickFormat(d3.format(",.0f"));

		
		var yAxis = d3.svg.axis()
		    .scale(y)
		    .orient("left")
    		.tickSize(15)
		    .tickValues(color.domain())
			.tickFormat(d3.format(",.0f"));

		var g = svgkey.append("g").attr("id","vert").attr("class","hidden-xs")
			.attr("transform", "translate(70,20)");
		
		
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
			.style("opacity",0.8)
			.style("fill", function(d) {return d.z; });
		
		g.call(yAxis).append("text");
		
		g.append("line")
			.attr("x1","8")
			.attr("x2","55")
			.attr("y1",function(d,i){return y(config.ons.average[a])})
			.attr("y2",function(d,i){return y(config.ons.average[a])})
			.attr("stroke","blue")
			.attr("stoke-width",1);	
		
		g.append("text")
			.attr("x","10")
			.attr("y",function(d,i){return y(config.ons.average[a]) - 4})
			.attr("class","average")
			.text(dvc.config.ons.averagelabel);
						
		g.append("text")
			.attr("x","10")
			.attr("y",function(d,i){return y(config.ons.average[a]) + 11})
			.attr("class","average")
			.text(numberFormat(dvc.config.ons.average[a]));		
		
		//add units
		
		g.append("text").attr("id","keyunit").text(dvc.unittext).attr("transform","translate(0,-5)");
		
		
		//horizontal key		
			
		var g2 = svgkey.append("g").attr("id","horiz").attr("class","visible-xs")
			.attr("transform", "translate(25,5)");
		
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
			.style("opacity",0.8)
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
			
		}
		
		
		
		function navigation(data){
			
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
					updateMap(dvc.config2);
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
						updateMap(dvc.config2);
						dvc.unittext = dvc.varunit[a];
						d3.select("#varsel").html(data.ons.varlabel[i] + " <span class='caret'></span>");
						dvc.label = data.ons.varlabel[a];
						d3.select("#keyunit").text(dvc.unittext);
						dropnext.selectAll("li").attr("class","")
						d3.select("#drop" + dvc.curr).attr("class","active");
					});
			
			d3.select("#drop" + dvc.curr).attr("class","active");
			
	}
	
//	function selectlist(data, datacsv) {
//	
//			var areacodes =  datacsv.map(function(d) { return d.MSOA_code; });
//			var areanames =  datacsv.map(function(d) { return d.MSOA_name; });
//			var menuarea = d3.zip(areanames,areacodes).sort(function(a, b){ return d3.ascending(a[0], b[0]); });
//			
//			// Build option menu for occupations
//			var optns = d3.select("#chosensel").append("div").attr("id","sel").append("select")
//				.attr("id","occselect")
//				.attr("style","width:98%")
//				.attr("class","chosen-select");
//			
//			
//			optns.append("option")
//				.attr("value","first")
//				.text("");
//			
//			optns.selectAll("p").data(menuarea).enter().append("option")
//				.attr("value", function(d){ return d[1]}) 
//				.text(function(d){ return d[0]});
//			
//			
//			$('#occselect').chosen({width: "98%", allow_single_deselect:true}).on('change',function(evt,params){
//		
//								if(typeof params != 'undefined') {
//									
//										
//										/* identify the data-nm attribute of the polygon you've hovered over */
//										currclass=params.selected;
//										leaveLayer();
//										highlightArea();
//										
//										
//										d3.select(".leaflet-overlay-pane").selectAll("path").attr("pointer-events","none");
//
//								}
//								else {
//										// Remove any selections
//										myId=null;
//										leaveLayer();
//										d3.select(".leaflet-overlay-pane").selectAll("path").attr("pointer-events","all");
//										
//								}
//								
//			});
//	
//	};


	
	
	function gotoArea(lat,lng) {
		
			map.setView([lat,lng], dvc.config.ons.zoom)
				
			storeLong = lng;
			storeLat = lat;
			
			var results = leafletPip.pointInLayer([storeLong,storeLat], topoLayerLA);
			
			if(results.length > 0) {
					highlighted = results[0].options.className;
			}	
		
	}
	
	
	if($(window).width() >= 650){
  // do your stuff

	function updateMap(config){
		//var values =  data.map(function(d) { return +eval("d." + dvc.curr); }).filter(function(d) {return !isNaN(d)}).sort(d3.ascending);

		// Generate some breaks based on the Jenks algorithm - http://en.wikipedia.org/wiki/Jenks_natural_breaks_optimization
		if(config.ons.breaks =="jenks")
			{breaks = ss.jenks(values, 5);}
		else {breaks = config.ons.breaks[a];};

		// Set up a colour scaling variable
		// This time using the jenks breaks we've defined		
		color = d3.scale.threshold()
			.domain(breaks.slice(1,5))
			.range(dvc.colour);
		
	
		d3.select("#keydiv").select("svg").remove();
		
		//createKey(dvc.config);
	
	
		// Create an object to give yourself a pair of values for the parlicon code and data value
		
		rateById = {};
		flattenedData.forEach(function(d) { rateById[d.MSOA_code] = +eval("d." + dvc.curr); });

		dvc.districtsInView.forEach(function(d,i) {
			topoLayer[d].eachLayer(handleLayerMSOA);
		});
		
		var xy = d3.select(".leaflet-overlay-pane").selectAll(".MSOA");
		
		xy.on("mouseout",leaveLayer).on("mouseover",enterLayer).on("click",click);
		
	}	
	
	}

		

  //  }; // End function ready


	initialise();
	//Load data and config file
	

	//if($(window).width() >= 650){
    queue()
		.defer(d3.json, "data/topo_E06000008.json")
		.defer(d3.json, "data/topo_lad.json")
		.defer(d3.json, "data/bounds.json")
		.defer(d3.json, "data/config.json")
		.await(ready);	
	//}
	
	} else {
		d3.select(".container").html("Sorry your browser does not support this interactive graphic");
		d3.select(".container")
			.append("img")
			.attr("src","./images/altaffordability.png")
			.attr("width","100%")
			.attr("height","100%");
		
		
	}

