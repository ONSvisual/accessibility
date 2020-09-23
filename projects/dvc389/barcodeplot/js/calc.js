var pymChild = null;
var bar, barindex, slider, scale, start;
var filter, filter2, filter3, filter4;
var filterreg = 'none';
var output = [0,0,0,0];

var cat_array = [20.40,22.90,21.90,20.90,22.10,25.10,25.80,25.60,20.20,21.30,21.70,37.80];
var cat2_array = [36.40,38.80,41.10,36.60,36.50,47.20,55.80,49.10,41.90,33.00,39.10,50.20];
var cat3_array = [49.60,54.80,51.40,57.80,55.80,61.70,62.60,64.20,60.40,53.20,56.10,64.20];
var cat4_array = [52.10,62.60,63.70,72.90,62.90,85.90,71.70,91.90,76.30,63.30,74.00,66.30];
var region_array = ["North East","North West","Yorkshire & the H.","East Midlands","West Midlands","East","London","South East","South West","Wales","Scotland","N. Ireland"];

//---------------------------------------------------------
//---------------------------------------------------------
//---------------------------------------------------------
// Input

$(".inputslider").hover(function(){
    bar_index = $(this).find('div:nth-child(2)').attr('id');
    slider_index = $(this).find('div:nth-child(2) div').attr('id');
    info_index = $(this).find('div:nth-child(1) span:nth-child(2)').attr('id');
    
    bar = document.getElementById(bar_index);
    slider = document.getElementById(slider_index);
    info = document.getElementById(info_index);
    
    bar.addEventListener('mousedown', startSlide, false); 
    bar.addEventListener('mouseup', stopSlide, false);
    // bar.addEventListener('mouseout', outSlide, false);

    switch(bar_index) {
      case 'bar':
        scale = 22;
        start = 18;
        init_min = 20;
        init_max = 37;
        zero = 'y';
        break;
      case 'bar2':
        scale = 28;
        start = 31;
        init_min = 33;
        init_max = 56;
        zero = 'y';
        break;
      case 'bar3':
        scale = 18;
        start = 48;
        init_min = 50;
        init_max = 64;
        break;
      case 'bar4':
        scale = 48;
        start = 48;
        init_min = 50;
        init_max = 92;
        break;
    }

});

//----------------------------

function startSlide(event){
  var set_amount = ((((event.clientX - bar.offsetLeft) / bar.offsetWidth)).toFixed(2));

  var amount = Math.round(set_amount*scale+start);

  if (amount == (init_min-1)) {
    info.innerHTML = '<£' + init_min; 
  }
  else if (amount == (init_min-2)) {
    info.innerHTML = '£0'; 
  }
  else if (amount > init_max) {
    info.innerHTML = '£' + (init_max+1) + '+'; 
  }
  else {
    info.innerHTML = '£' + amount; 
  } 

  bar.addEventListener('mousemove', moveSlide, false);  
  slider.style.width = (set_amount * 100) + '%';  
}

function moveSlide(event){
  var set_amount = ((((event.clientX - bar.offsetLeft) / bar.offsetWidth)).toFixed(2));

  var amount = Math.round(set_amount*scale+start);

  if (amount == (init_min-1)) {
    info.innerHTML = '<£' + init_min; 
  }
  else if (amount == (init_min-2)) {
    info.innerHTML = '£0'; 
  }
  else if (amount > init_max) {
    info.innerHTML = '£' + (init_max+1) + '+'; 
  }
  else {
    info.innerHTML = '£' + amount; 
  } 

  slider.style.width = (set_amount * 100) + '%';
}

function stopSlide(event){
  var set_amount = ((((event.clientX - bar.offsetLeft) / bar.offsetWidth)).toFixed(2));

  var amount = Math.round(set_amount*scale+start);

  switch(bar_index) {
        case 'bar':
          output[0] = amount;
          break;
        case 'bar2':
          output[1] = amount;
          break;
        case 'bar3':
          output[2] = amount;
          break;
        case 'bar4':
          output[3] = amount;
          break;
  }

  if (amount == (init_min-1)) {
    info.innerHTML = '<£' + init_min; 
  }
  else if (amount == (init_min-2)) {
    info.innerHTML = '£0'; 
  }
  else if (amount > init_max) {
    info.innerHTML = '£' + (init_max+1) + '+'; 
  }
  else {
    info.innerHTML = '£' + amount; 
  }


  //----------------------------

  bar.removeEventListener('mousemove', moveSlide, false);
  slider.style.width = (set_amount * 100) + '%';
  $('.droptext').text('or select your region');
  evaluate_1();
  evaluate_2();
  evaluate_3();
  evaluate_4();
  draw();
}

// function outSlide(event){
//   var set_amount = ((((event.clientX - bar.offsetLeft) / bar.offsetWidth)).toFixed(2));

//   var amount = Math.round(set_amount*scale+start);

//   switch(bar_index) {
//         case 'bar':
//           output[0] = amount;
//           break;
//         case 'bar2':
//           output[1] = amount;
//           break;
//         case 'bar3':
//           output[2] = amount;
//           break;
//         case 'bar4':
//           output[3] = amount;
//           break;
//   }

//   if (amount == (init_min-1)) {
//     info.innerHTML = '<£' + init_min; 
//   }
//   else if (amount == (init_min-2)) {
//     info.innerHTML = '£0'; 
//   }
//   else if (amount > init_max) {
//     info.innerHTML = '£' + (init_max+1) + '+'; 
//   }
//   else {
//     info.innerHTML = '£' + amount; 
//   }


//   //----------------------------

//   bar.removeEventListener('mousemove', moveSlide, false);
//   slider.style.width = (set_amount * 100) + '%';
//   $('.droptext').text('or select your region');
//   evaluate_1();
//   evaluate_2();
//   evaluate_3();
//   evaluate_4();
//   draw();
// }
 
//---------------------------------------------------------
//---------------------------------------------------------
//---------------------------------------------------------
// Calculation

function evaluate_1() {
  input = output[0];

  if (input == 0) {
    return;
  } 
  else {

    difference = cat_array.map(function (a){
      return Math.abs(output[0]-a)/a;
    });
    ranksum = cat_array.map(function (a,i){
      return a*difference[i];
    });
    //Arrow functions - not in IE
    // difference = cat_array.map((a) => Math.abs(output[0]-a)/a);
    // ranksum = cat_array.map((a, i) => a * difference[i]);
    result = ranksum.indexOf(Math.min.apply(null, ranksum));

    switch(result) {
          case 0:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_ne2.png)";
            filter = region_array[0];
            $('#region_name').text(filter);
            break;
          case 1:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_nw2.png)";
            filter = region_array[1];
            $('#region_name').text(filter);
            break;
          case 2:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_y2.png)";
            filter = region_array[2];
            $('#region_name').text(filter);
            break;
          case 3:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_em2.png)";
            filter = region_array[3];
            $('#region_name').text(filter);
            break;
          case 4:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_wm2.png)";
            filter = region_array[4];
            $('#region_name').text(filter);
            break;
          case 5:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_e2.png)";
            filter = region_array[5];
            $('#region_name').text(filter);
            break;
          case 6:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_l2.png)";
            filter = region_array[6];
            $('#region_name').text(filter);
            break;
          case 7:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_se2.png)";
            filter = region_array[7];
            $('#region_name').text(filter);
            break;
          case 8:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_sw2.png)";
            filter = region_array[8];
            $('#region_name').text(filter);
            break;
          case 9:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_wal2.png)";
            filter = region_array[9];
            $('#region_name').text(filter);
            break;
          case 10:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_sc2.png)"
            filter = region_array[10];
            $('#region_name').text(filter);
            break;
          case 11:
            document.getElementById('region_img').style.backgroundImage="url(pics/region_ni2.png)";
            filter = region_array[11];
            $('#region_name').text(filter);
            break;
    }
  }
}

function evaluate_2() {
  input = output[1];

  if (input == 0) {
    return;
  } 
  else {
    difference = cat2_array.map(function (a){
      return Math.abs(output[1]-a)/a;
    });
    ranksum = cat2_array.map(function (a,i){
      return a*difference[i];
    });
    //Arrow functions - not in IE
    // difference = cat2_array.map((a) => Math.abs(output[1]-a)/a);
    // ranksum = cat2_array.map((a, i) => a * difference[i]);
    result = ranksum.indexOf(Math.min.apply(null, ranksum));

    switch(result) {
          case 0:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_ne.png)";
            filter2 = region_array[0];
            $('#region_name2').text(filter2);
            break;
          case 1:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_nw.png)";
            filter2 = region_array[1];
            $('#region_name2').text(filter2);
            break;
          case 2:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_y.png)";
            filter2 = region_array[2];
            $('#region_name2').text(filter2);
            break;
          case 3:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_em.png)";
            filter2 = region_array[3];
            $('#region_name2').text(filter2);
            break;
          case 4:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_wm.png)";
            filter2 = region_array[4];
            $('#region_name2').text(filter2);
            break;
          case 5:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_e.png)";
            filter2 = region_array[5];
            $('#region_name2').text(filter2);
            break;
          case 6:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_l.png)";
            filter2 = region_array[6];
            $('#region_name2').text(filter2);
            break;
          case 7:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_se.png)";
            filter2 = region_array[7];
            $('#region_name2').text(filter2);
            break;
          case 8:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_sw.png)";
            filter2 = region_array[8];
            $('#region_name2').text(filter2);
            break;
          case 9:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_wal.png)";
            filter2 = region_array[9];
            $('#region_name2').text(filter2);
            break;
          case 10:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_sc.png)"
            filter2 = region_array[10];
            $('#region_name2').text(filter2);
            break;
          case 11:
            document.getElementById('region_img2').style.backgroundImage="url(pics/region_ni.png)";
            filter2 = region_array[11];
            $('#region_name2').text(filter2);
            break;
    }
  }
}

function evaluate_3() {
  input = output[2];

  if (input == 0) {
    return;
  } 
  else {
    difference = cat3_array.map(function (a){
      return Math.abs(output[2]-a)/a;
    });
    ranksum = cat3_array.map(function (a,i){
      return a*difference[i];
    });
    //Arrow functions - not in IE
    // difference = cat3_array.map((a) => Math.abs(output[2]-a)/a);
    // ranksum = cat3_array.map((a, i) => a * difference[i]);
    result = ranksum.indexOf(Math.min.apply(null, ranksum));

    switch(result) {
          case 0:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_ne3.png)";
            filter3 = region_array[0];
            $('#region_name3').text(filter3);
            break;
          case 1:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_nw3.png)";
            filter3 = region_array[1];
            $('#region_name3').text(filter3);
            break;
          case 2:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_y3.png)";
            filter3 = region_array[2];
            $('#region_name3').text(filter3);
            break;
          case 3:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_em3.png)";
            filter3 = region_array[3];
            $('#region_name3').text(filter3);
            break;
          case 4:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_wm3.png)";
            filter3 = region_array[4];
            $('#region_name3').text(filter3);
            break;
          case 5:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_e3.png)";
            filter3 = region_array[5];
            $('#region_name3').text(filter3);
            break;
          case 6:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_l3.png)";
            filter3 = region_array[6];
            $('#region_name3').text(filter3);
            break;
          case 7:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_se3.png)";
            filter3 = region_array[7];
            $('#region_name3').text(filter3);
            break;
          case 8:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_sw3.png)";
            filter3 = region_array[8];
            $('#region_name3').text(filter3);
            break;
          case 9:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_wal3.png)";
            filter3 = region_array[9];
            $('#region_name3').text(filter3);
            break;
          case 10:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_sc3.png)"
            filter3 = region_array[10];
            $('#region_name3').text(filter3);
            break;
          case 11:
            document.getElementById('region_img3').style.backgroundImage="url(pics/region_ni3.png)";
            filter3 = region_array[11];
            $('#region_name3').text(filter3);
            break;
    }
  }
}

function evaluate_4() {
  input = output[3];

  if (input == 0) {
    return;
  } 
  else {
    difference = cat4_array.map(function (a){
      return Math.abs(output[3]-a)/a;
    });
    ranksum = cat4_array.map(function (a,i){
      return a*difference[i];
    });
    // Arrow functions - not in IE
    // difference = cat4_array.map((a) => Math.abs(output[3]-a)/a);
    // ranksum = cat4_array.map((a, i) => a * difference[i]);
    result = ranksum.indexOf(Math.min.apply(null, ranksum));

    switch(result) {
          case 0:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_ne4.png)";
            filter4 = region_array[0];
            $('#region_name4').text(filter4);
            break;
          case 1:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_nw4.png)";
            filter4 = region_array[1];
            $('#region_name4').text(filter4);
            break;
          case 2:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_y4.png)";
            filter4 = region_array[2];
            $('#region_name4').text(filter4);
            break;
          case 3:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_em4.png)";
            filter4 = region_array[3];
            $('#region_name4').text(filter4);
            break;
          case 4:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_wm4.png)";
            filter4 = region_array[4];
            $('#region_name4').text(filter4);
            break;
          case 5:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_e4.png)";
            filter4 = region_array[5];
            $('#region_name4').text(filter4);
            break;
          case 6:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_l4.png)";
            filter4 = region_array[6];
            $('#region_name4').text(filter4);
            break;
          case 7:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_se4.png)";
            filter4 = region_array[7];
            $('#region_name4').text(filter4);
            break;
          case 8:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_sw4.png)";
            filter4 = region_array[8];
            $('#region_name4').text(filter4);
            break;
          case 9:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_wal4.png)";
            filter4 = region_array[9];
            $('#region_name4').text(filter4);
            break;
          case 10:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_sc4.png)"
            filter4 = region_array[10];
            $('#region_name4').text(filter4);
            break;
          case 11:
            document.getElementById('region_img4').style.backgroundImage="url(pics/region_ni4.png)";
            filter4 = region_array[11];
            $('#region_name4').text(filter4);
            break;
    }
  }
}

//---------------------------------------------------------
//---------------------------------------------------------
//---------------------------------------------------------
// Vis

function draw(){

d3.select("svg").remove();

//----------------------------

var wiwidth = $( window ).width();

if (wiwidth < 700) {
  marleft = 215;
  marleft2 = 225;
  ticknum = 2;
}
else {
  marleft = 225;
  marleft2 = 233;
  ticknum = 8;
}

var margin = {top: 15, right: 25, bottom: 75, left: marleft},
    width = $('#explore').width() - margin.left - margin.right,
    height = 450 - margin.top - margin.bottom;

var x = d3.scale.linear()
    .range([0, width]);

var y = d3.scale.ordinal()
    .rangePoints([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .ticks(ticknum);

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var svg = d3.select("#explore")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

//----------------------------

d3.tsv("data/lpc.tsv", function(d) {
    for (var k in d) 
        if (k !== "toplevel" && k !== "secondlevel" && k !== "name" && k !== "min") {
            d[k] = +d[k];
        }
    return d;
  }, function(error,data) {
    if (error) throw error;

  var seriesNames = d3.keys(data[0]).filter(function(key) { 
                                    return key !== "toplevel" && key !== "secondlevel" && key !== "name" && key !== "min" && key !== "England" && key !== "United Kingdom"; 
                                 });

  var series = seriesNames.map(function(region) {
    return {
      region: region,
      values: data.map(function(d) {
        return {toplevel: d.toplevel, 
                secondlevel: d.secondlevel,
                name: d.name,
                min: +d.min,
                spending: +d[region],
                region: region };
      })
    };
  });

  x.domain([0,d3.max(series, function(c) { return d3.max(c.values, function(d) { return d.spending; }); })+15]);
  y.domain(data.map(function (d) {return d.toplevel; }));

  svg.append("g")
      .attr("class", "y axis")
      .attr("transform", "translate(-10,0)")
      .call(yAxis);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + (height + 45) + ")")
      .call(xAxis)
      .append("text")
      .attr("x", (marleft2-10)*-1)
      .attr("y", 19)
      .text("Total expenditure per week in £");

  var tooltip = d3.select("body")
      .append("div")
      .style("position", "absolute")
      .attr("class", "tooltip_barcode")
      .style("z-index", "1")
      .style("opacity", 0)
      .style("visibility", 'hidden')
      .text("");

  var barcodes = svg.selectAll(".regions")
      .data(series)
      .enter()
      .append("g")
      .attr("class", "regions")

  barcodes.selectAll('rect')
      .data(function(d) { return d.values; })
      .enter()
      .append("rect")
      .attr("class", function(d) {
        if (d.region == 'North East') return 'NE';
        if (d.region == 'North West') return 'NW';
        if (d.region == 'Yorkshire & The H.') return 'Y';
        if (d.region == 'East Midlands') return 'EM';
        if (d.region == 'West Midlands') return 'WM';
        if (d.region == 'East') return 'E';
        if (d.region == 'London') return 'L';
        if (d.region == 'South East') return 'SE';
        if (d.region == 'South West') return 'SW';
        if (d.region == 'Wales') return 'W';
        if (d.region == 'Scotland') return 'S';
        if (d.region == 'N. Ireland') return 'NI';
      })
      .attr("width", 1)
      .attr("height", 30)
      .attr("x", function(d) { return x(d.spending); })
      .attr("y", function(d) { return y(d.toplevel)-15; })
      //filter for subcategories
      .style('stroke-width', function(d) {
        if (d.region == filter && d.toplevel == 'Clothing and footwear') return 2.5;
        if (d.region == filter2 && d.toplevel == 'Restaurants and hotels') return 2.5;
        if (d.region == filter3 && d.toplevel == 'Food and non-alcoholic drinks') return 2.5;
        if (d.region == filter4 && d.toplevel == 'Transport') return 2.5;
        else return 1.5;
      })
      .style('opacity', function(d) {
        if (d.region == filter && d.toplevel == 'Clothing and footwear') return 1;
        if (d.region == filter2 && d.toplevel == 'Restaurants and hotels') return 1;
        if (d.region == filter3 && d.toplevel == 'Food and non-alcoholic drinks') return 1;
        if (d.region == filter4 && d.toplevel == 'Transport') return 1;
        else return 0.2;
      })
      .style('stroke', function(d) {
        if (d.region == filter && d.toplevel == 'Clothing and footwear') return '#43abdd';
        if (d.region == filter2 && d.toplevel == 'Restaurants and hotels') return '#00B8A9';
        if (d.region == filter3 && d.toplevel == 'Food and non-alcoholic drinks') return '#FEE388';
        if (d.region == filter4 && d.toplevel == 'Transport') return '#F6416C';
        else return '#393E46';

      })
      .on("mouseover", function(d){

        tooltip
          .transition()
          .duration(100)
          .style("opacity", 1)

        tooltip
          .html(d.region + '<br/>' + '£' + (d.spending).toFixed(2))
          .style("left", (d3.event.pageX) + "px")
          .style("top", (d3.event.pageY + 20) + "px")
          .style('visibility', 'initial');

      })
      .on("mouseout", function(d){

        tooltip
        .transition()
        .duration(100)
        .style("opacity", 0);

        tooltip
        .style('visibility', 'hidden');

      });

  barcodes.selectAll('lines')
    .data(function(d) { return d.values; })
    .enter()
    .append("line")
    .attr("class", "grid")
    .attr("x1", x(0))
    .attr("y1", function(d) { return y(d.toplevel); })
    .attr("x2", function(d) { return x(d.min)-20; })
    .attr("y2", function(d) { return y(d.toplevel); })
    .style("stroke-dasharray", ("3, 3"))
    .style('stroke', 'rgba(0, 0, 0, 0.01)')
    .style('stroke-width', 2);

  });

  if (pymChild) {
      pymChild.sendHeight();
  }

};

draw();

//----------------------------

$('#dropbtn').hover(function() {

  $('#dropdown-content').css('display','inline-block');
  
});

$('.dropdownclick').click(function(){

  ident = '.'+$(this).attr('id');

  if (filterreg == 'none') {

    switch(ident) {
          case '.NE':
            $('.droptext').text('with North East selected');
            break;

          case '.NW':
            $('.droptext').text('with North West selected');
            break;

          case '.Y':
            $('.droptext').text('with Yorkshire and the Humber selected');
            break;

          case '.EM':
            $('.droptext').text('with East Midlands selected');
            break;  

          case '.WM':
            $('.droptext').text('with West Midlands selected');
            break;

          case '.E':
            $('.droptext').text('with East selected');
            break;

          case '.L':
            $('.droptext').text('with London selected');
            break;

          case '.SE':
            $('.droptext').text('with South East selected');
            break;

          case '.SW':
            $('.droptext').text('with South West selected');
            break;

          case '.W':
            $('.droptext').text('with Wales selected');
            break;

          case '.S':
            $('.droptext').text('with Scotland selected');
            break;

          case '.NI':
            $('.droptext').text('with Northern Ireland selected');
            break;
    }

    d3.selectAll(ident)
      .transition()
      .duration(150)
      .style("opacity", 1);

    filterreg = ident;

  }

  else if (filterreg == ident) {
    d3.selectAll(filterreg)
    .transition()
    .duration(150)
    .style('stroke', function(d) {
      if (d.region == filter && d.toplevel == 'Clothing and footwear') return '#43abdd';
      if (d.region == filter2 && d.toplevel == 'Restaurants and hotels') return '#00B8A9';
      if (d.region == filter3 && d.toplevel == 'Food and non-alcoholic drinks') return '#FEE388';
      if (d.region == filter4 && d.toplevel == 'Transport') return '#F6416C';
      else return '#393E46';
    })
    .style('opacity', function(d) {
      if (d.region == filter && d.toplevel == 'Clothing and footwear') return 1;
      if (d.region == filter2 && d.toplevel == 'Restaurants and hotels') return 1;
      if (d.region == filter3 && d.toplevel == 'Food and non-alcoholic drinks') return 1;
      if (d.region == filter4 && d.toplevel == 'Transport') return 1;
      else return 0.2;
    });

    $('.droptext').text('or select your region');

    filterreg = 'none';
  }

  else {

    d3.selectAll(filterreg)
    .transition()
    .duration(150)
    .style('stroke', function(d) {
      if (d.region == filter && d.toplevel == 'Clothing and footwear') return '#43abdd';
      if (d.region == filter2 && d.toplevel == 'Restaurants and hotels') return '#00B8A9';
      if (d.region == filter3 && d.toplevel == 'Food and non-alcoholic drinks') return '#FEE388';
      if (d.region == filter4 && d.toplevel == 'Transport') return '#F6416C';
      else return '#393E46';
    })
    .style('opacity', function(d) {
      if (d.region == filter && d.toplevel == 'Clothing and footwear') return 1;
      if (d.region == filter2 && d.toplevel == 'Restaurants and hotels') return 1;
      if (d.region == filter3 && d.toplevel == 'Food and non-alcoholic drinks') return 1;
      if (d.region == filter4 && d.toplevel == 'Transport') return 1;
      else return 0.2;
     });

    switch(ident) {
      case '.NE':
      $('.droptext').text('with North East selected');
      break;

      case '.NW':
        $('.droptext').text('with North West selected');
        break;

      case '.Y':
        $('.droptext').text('with Yorkshire and the Humber selected');
        break;

      case '.EM':
        $('.droptext').text('with East Midlands selected');
        break;  

      case '.WM':
        $('.droptext').text('with West Midlands selected');
        break;

      case '.E':
        $('.droptext').text('with East selected');
        break;

      case '.L':
        $('.droptext').text('with London selected');
        break;

      case '.SE':
        $('.droptext').text('with South East selected');
        break;

      case '.SW':
        $('.droptext').text('with South West selected');
        break;

      case '.W':
        $('.droptext').text('with Wales selected');
        break;

      case '.S':
        $('.droptext').text('with Scotland selected');
        break;

      case '.NI':
        $('.droptext').text('with Northern Ireland selected');
        break;
    }

    d3.selectAll(ident)
    .transition()
    .duration(150)
    .style("opacity", 1);

    filterreg = ident;

  }

$('#dropdown-content').css('display','none');

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