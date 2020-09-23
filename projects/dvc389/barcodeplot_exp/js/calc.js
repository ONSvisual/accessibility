var pymChild = null;
var filter, filter2, filter3, filter4;
var filterreg = 'none';
var fixArray = [];
var filterArray = fixArray;
var filterUrl =[];

//---------------------------------------------------------
//---------------------------------------------------------
//---------------------------------------------------------
// Vis

function draw(){

var url = decodeURI(window.location.hash);

if (url == ""){
  
} else {
  params = url.split("/");
  
  params[0] = params[0].replace("#", "")
  filterArray = [];
  filterreg = params[0];
  
  params.forEach(function(d){ return filterArray.push(d.replace(/!/g , ","))})
  
  $(".category").val(filterArray)
  $(".category").trigger("chosen:updated")
  
  region = filterreg.replace(".","")
  $(".region").val(region)
  $(".region").trigger("chosen:updated")
  
}

d3.select("svg").remove();

//----------------------------

var wiwidth = $( window ).width();

if (wiwidth < 700) {
  marleft = 232;
  marleft2 = 238;
  marright = 0;
  ticknum = 1;
  ticknum2 = 2;
  marmid = -30;
  ffformat = ".1f";
}
else {
  marleft = 250;
  marleft2 = 250;
  marright = 25;
  ticknum = 8;
  ticknum2 = 8;
  marmid = -40;
  ffformat = ".2f";
}

var margin = {top: 75, right: marright, bottom: 75, left: marleft},
    width = $('#explore').width() - margin.left - margin.right,
    height = 60+(55*filterArray.length-1) - margin.top - margin.bottom;

var x = d3.scale.linear()
    .range([0, width]);

var x2 = d3.scale.linear()
    .range([0, width]);

var y = d3.scale.ordinal()
    .rangePoints([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .ticks(ticknum)
    .tickFormat(d3.format(ffformat));

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

function make_x_axis() {        
    return d3.svg.axis()
        .scale(x)
         .orient("bottom");
}

function make_y_axis() {        
    return d3.svg.axis()
        .scale(y)
        .orient("left");
}

var svg = d3.select("#explore")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

//----------------------------

d3.tsv("data/lpc.tsv", function(d) {
    for (var k in d) 
        if (k !== "toplevel" && k !== "secondlevel" && k !== "name" && k !== "hover_class") {
            d[k] = +d[k];
        }
    return d;
  }, function(error,data) {
    if (error) throw error;

  var seriesNames = d3.keys(data[0]).filter(function(key) { 
    return key !== "toplevel" && key !== "secondlevel" && key !== "name" && key !== "England" && key !== "United Kingdom" && key !== "hover_class"; 
  });

  function doFilter(d) {
      return d.name == filterArray[0] || d.name == filterArray[1] || d.name == filterArray[2] || d.name == filterArray[3] || d.name == filterArray[4] || d.name == filterArray[5] || d.name == filterArray[6] || d.name == filterArray[7] || d.name == filterArray[8] || d.name == filterArray[9] || d.name == filterArray[10] || d.name == filterArray[11] || d.name == filterArray[12] || d.name == filterArray[13] || d.name == filterArray[14] || d.name == filterArray[15] || d.name == filterArray[16] || d.name == filterArray[17] || d.name == filterArray[18] || d.name == filterArray[19];
  }

  // maybe automate via for loop? - doesn't work yet
  // function doFilter(d) {
  //   for (var i = 0; i < filterArray; i++) {
  //     return d.name == filterArray[i];
  //   }  
  // }

  var n_data = data.filter(doFilter);
   
  var series = seriesNames.map(function(region) {
    return {
      region: region,
      values: n_data.map(function(d) {
        return {toplevel: d.toplevel, 
                secondlevel: d.secondlevel,
                name: d.name,
                hover_class: d.hover_class,
                spending: +d[region],
                region: region };
      })
    };
  });

  x.domain([0,d3.max(series, function(c) { return d3.max(c.values, function(d) { return d.spending; }); })*1.55]);
  y.domain(n_data.map(function (d) {return d.name; }));

  svg.append("g")
      .attr("class", "y axis")
      .attr("transform", "translate("+ marmid +",0)")
      .call(yAxis)
      .style('opacity', 0)
      .transition()
      .duration(500)
      .style('opacity', 1)
      .selectAll(".tick text")
      .call(wrap, 200);

  function wrap(text, width) {
    text.each(function() {
      var text = d3.select(this),
          words = text.text().split(/\s+/).reverse(),
          word,
          line = [],
          lineNumber = 0,
          lineHeight = 1.1,
          y = text.attr("y"),
          dy = parseFloat(text.attr("dy")),
          tspan = text.text(null).append("tspan").attr("x", 0).attr("y", y).attr("dy", dy + "em");
      while (word = words.pop()) {
        line.push(word);
        tspan.text(line.join(" "));
        if (tspan.node().getComputedTextLength() > width) {
          line.pop();
          tspan.text(line.join(" "));
          line = [word];
          tspan = text.append("tspan").attr("x", 0).attr("y", y).attr("dy", ++lineNumber * lineHeight + dy + "em").text(word);
        }
      }
    });
  }

   svg.append("g")         
        .attr("class", "grid")
        .style("stroke-dasharray", ("3, 3"))
        .attr("transform", "translate(0," + height + ")")
        .call(make_x_axis()
            .tickSize(-height, 0, 0)
            .ticks(ticknum2)
            .tickFormat("")
        )

  var axis = svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + (height + 50) + ")")
      .call(xAxis)

  if(filterArray.length !=0){
    axis
      .append("text")
      .attr("x", (marleft2-5)*-1)
      .attr("y", 19)
      .text("Total expenditure per week in £")
  }

  axis
      .style('opacity', 0)
      .transition()
      .duration(500)
      .style('opacity', 1);
   
  var tooltip = d3.select("body")
      .append("div")
      .style("position", "absolute")
      .attr("class", "tooltip")
      .style("z-index", "10")
      .style("opacity", 0)
      .text("");

  var barcodes = svg.selectAll(".regions")
      .data(series)
      .enter()
      .append("g")
      .attr("class", "regions")

  var barcodes2 = svg.selectAll(".regions2")
      .data(series)
      .enter()
      .append("g")
      .attr("class", "regions")

  var barcodeplot = barcodes.selectAll('rect')
      .data(function(d) { return d.values; })
      .enter()
      .append("rect")
      .attr("class", function(d) {return ('value' + d3.round(d.spending*100)+ d.hover_class)})
      .attr("id", function(d) {return (d.region)})
      .attr("width", 1)
      .attr("height", 30)
      .attr("x", function(d) { return x(d.spending); })
      .attr("y", function(d) { return y(d.name)-15; })
      .style('stroke-width', 2)
      .style('stroke', '#393E46')
      .style('opacity', 0);

  barcodeplot
      .transition()
      .duration(500)
      .style('opacity', 0.2);
      
  barcodeplot
      .on("mouseover", function(d){
        tooltip
          .transition()
          .duration(400)
          .style("opacity", 1);

      //----------------------------

        selektor = '.' + d3.select(this).attr('class');

        selektorr = d3.selectAll(selektor);

        text = '';

        selektorr[0].forEach(function(element) {

        text += element.getAttribute('id') + ', ';

        });

        text = text.substring(0, text.length - 2);

        //----------------------------
        
        tooltip
          .html(text + '<br/>' + '£' + (d.spending).toFixed(2))
          .style("left", (d3.event.pageX-10) + "px")
          .style("top", (d3.event.pageY+10) + "px")
          .style('display', 'initial');
      })
      .on("mouseout", function(d){
        tooltip
        .transition()
        .duration(400)
        .style("opacity", 0);

        tooltip
        .style("display", 'none');
      });

  var barcodeplot_hover = barcodes2.selectAll('rect_top')
      .data(function(d) { return d.values; })
      .enter()
      .append("rect")
      .attr("class", function(d) {
        if (d.region === 'North East') return 'NE';
        if (d.region === 'North West') return 'NW';
        if (d.region === 'Yorkshire and The Humber') return 'Y';
        if (d.region === 'East Midlands') return 'EM';
        if (d.region === 'West Midlands') return 'WM';
        if (d.region === 'East') return 'E';
        if (d.region === 'London') return 'L';
        if (d.region === 'South East') return 'SE';
        if (d.region === 'South West') return 'SW';
        if (d.region === 'Wales') return 'W';
        if (d.region === 'Scotland') return 'S';
        if (d.region === 'Northern Ireland') return 'NI';
      })
      .attr("selektor", function(d) {return ('value' + d3.round(d.spending*100)+ d.hover_class)})
      .attr("width", 4)
      .attr("height", 32)
      .attr("x", function(d) { return x(d.spending)-2; })
      .attr("y", function(d) { return y(d.name)-16; })
      .style('fill', '#49acdb')
      .style('display', 'none')
      .style('opacity', 0);

  barcodeplot_hover
      .on("mouseover", function(d){
        tooltip
          .transition()
          .duration(400)
          .style("opacity", 1);

        //----------------------------

        selektor = '.' + d3.select(this).attr('selektor');

        selektorr = d3.selectAll(selektor);

        text = '';

        selektorr[0].forEach(function(element) {

        text += element.getAttribute('id') + ', ';

        });

        text = text.substring(0, text.length - 2);

        //----------------------------

        tooltip
          .html(text + '<br/>' + '£' + (d.spending).toFixed(2))
          .style("left", (d3.event.pageX-10) + "px")
          .style("top", (d3.event.pageY+10) + "px")
          .style('display', 'initial');
      })
      .on("mouseout", function(d){
        tooltip
        .transition()
        .duration(400)
        .style("opacity", 0);

        tooltip
        .style("display", 'none');
      });

//----------------------------

  d3.selectAll(filterreg)
    .style("display", "initial");

  d3.selectAll(filterreg)
    .transition()
    .duration(150)
    .style("opacity", 1);

  if (filterreg == '.none') {
    $('.chosen-single span').css('color','rgba(0,0,0,0.8)');
  }

  else if (filterreg == 'none'){
    $('.chosen-single span').css('color','rgba(0,0,0,0.8)');
  }
  else {
    $('.chosen-single span').css('color','#49acdb');
  }
   
  }); 

  if (pymChild) {
        pymChild.sendHeight();
  }

};

draw();

//---------------------------------------------------------
//---------------------------------------------------------
//---------------------------------------------------------
// Dropdown

$(".category").chosen({
    width: "350px",
    max_selected_options: 20

});

$(".region").chosen({
    width: "200px",
    disable_search: true,
    max_selected_options: 1
});

$('.category').on('change', function() {

    selection_cat = [];
    filterArray = [];

    $(".category").find(":selected").each(
      function(i){
        selection_cat[i] = $(this).val();
    });

    filterArray = fixArray.concat(selection_cat);

    filterNoCommas =[]
    filterArray.forEach(function(d){ return filterNoCommas.push(d.replace(/,/g , "!"))})
  
    filterUrl = filterNoCommas.join().replace(/,/g , "/")
  
    window.location.hash = encodeURI(filterreg+"/"+filterUrl)

    draw();

});

$('.region').on('change', function() {

  ident = '.' + $(".region").find(":selected").val();

  if (ident == '.none') {
    $('.chosen-single span').css('color','rgba(0,0,0,0.8)');
  } 

  else {
    $('.chosen-single span').css('color','#49acdb');
  }

  if (filterreg == 'none') {

    d3.selectAll(ident)
      .style('display', 'initial');

    d3.selectAll(ident)
      .transition()
      .duration(150)
      .style("opacity", 1);

    filterreg = ident;
  }

  else {

    d3.selectAll(filterreg)
      .style('display', 'none');

    d3.selectAll(ident)
    .style('display', 'initial');

    d3.selectAll(filterreg)
    .transition()
    .duration(250)
    .style('opacity', 0);

    d3.selectAll(ident)
    .transition()
    .duration(250)
    .style("opacity", 1);

    filterreg = ident;
  }

  filterNoCommas =[]
  filterArray.forEach(function(d,i){if(i!=0){ return filterNoCommas.push(d.replace(/,/g , "!"))}})
  
  filterUrl = filterNoCommas.join().replace(/,/g , "/") 

  window.location.hash = encodeURI(filterreg+"/"+filterUrl)

});

//---------------------------------------------------------
//---------------------------------------------------------
//---------------------------------------------------------
// Social Media

function addShare() {
      
  d3.select("#share").selectAll("a").remove();

  d3.select("#share")
    .append("img")
    .attr("id","face")
    .style("margin-right","10px")
    .style("height","25px")
    .style("width","25px")
    .style("padding-left","5px")
    .style("margin-top","0px")
    .attr("src","pics/facebook.svg");
    
  d3.select("#share")
    .append("img")
    .attr("id","twitter")
    .style("height","25px")
    .style("width","25px")
    .style("padding-left","5px")
    .style("padding-top","0px")
    .attr("src","pics/twitter.svg");
    
}

//----------------------------

addShare();

$("#twitter").on("click",tweet);
$("#face").on("click",faceb);

function faceb() {
    var face = 'http://www.facebook.com/share.php?u=' + window.location.href;
    window.open(face);
}

function tweet() {
    var myString="http://twitter.com/home?status="+escape("How much do households spend per week? "+ window.location.href);
    window.open(myString);
}

//---------------------------------------------------------
//---------------------------------------------------------
//---------------------------------------------------------

if (Modernizr.svg) {
    $("#content").fadeIn(500);
    pymChild = new pym.Child({
      renderCallback: draw
    });
  } 
else {
    pymChild = new pym.Child();
    
    if (pymChild) {
          pymChild.sendHeight();
    }

    $("#ieMsg").fadeIn(500);
}