//setting up constants for maths functions
if (Modernizr.svg)
	{
		
d3.select(".container").classed("hide",false);
d3.select("#fallback").remove();

var publicSpending = 814600000000;
var ukPopulation = 65648100;
var timesBy = 1000000000;
var numberword = "billion";
var usernumber = 1;
//dummy variables that will be chnged by the functions below
var mes1 = 0;
var mes2 = 0;
var mes3 = 0;
var mes4 = 0;
//number formatting for display
var numberFormat = d3.format(",.0f");
var numberFormat2 = d3.format(",.2f");
var numberFormat3 = d3.format(",.1f");	
var predefinedNumber = 0;

//changes color of the buttons on click

d3.selectAll(".selectable").on("click",function(){
		d3.select("#Option2").classed("franksButton",false);
		d3.select("#Option3").classed("franksButton",false);
		d3.select("#Option4").classed("franksButton",false);
		d3.select(this).classed("franksButton",true);
});
	
function ChangeBack(selection){
	//takes the pre-defined button numbers and puts them in the input box
	predefinedNumber = d3.select("#" + selection).attr("data-nm");
	$(".form-control").val(predefinedNumber);
	//calls the function below that does the calculations
	changeValue();
}

function changeValue() {
	//passes the user's selected number into a js variable
	usernumber = $(".form-control").val();
	//does calculations
	mes1 = (usernumber / 52) * 1000;
	mes2 = (timesBy * usernumber) / ukPopulation;
	mes3 = (mes2 / 365);
	mes4 = ((usernumber*timesBy) / publicSpending) * 100;
	//puts calculated numbers in the display
	document.getElementById('selectedmeasure1').innerHTML=("£" + numberFormat(mes1) + " million");
	document.getElementById('selectedmeasure2').innerHTML=("£" + numberFormat(mes2));
	document.getElementById('selectedmeasure3').innerHTML=("£" + numberFormat2(mes3));
	document.getElementById('selectedmeasure4').innerHTML=(numberFormat3(mes4) + "%");
	d3.selectAll(".qlabel").style("color","#6f6f6f");
}

//user to submit number with form control
d3.select(".form-control").on("change", function(){
	//actions the function above 
	changeValue();
	//re-sets button colors
		d3.select("#Option2").classed("franksButton",false);
		d3.select("#Option3").classed("franksButton",false);
		d3.select("#Option4").classed("franksButton",false); 
}).on("keyup", function(){
	//actions the function above 
	changeValue();
	//re-sets button colors
		d3.select("#Option2").classed("franksButton",false);
		d3.select("#Option3").classed("franksButton",false);
		d3.select("#Option4").classed("franksButton",false); 
});	

	if (pymChild) { pymChild.sendHeight(); }
	
	
	}
