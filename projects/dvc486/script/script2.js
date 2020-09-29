if (Modernizr.svg) {

  var pymChild = new pym.Child();

  // set the on load values
  var wagePerson1 = 7.83;
  var wagePerson2 = 7.83;
  var wagePerson3 = 7.83;
  var wagePerson4 = 7.83;
  var livingWageBudget = 0;
  var housing = 0;
  var housingAverage = 202.41;
  var transport = 0;
  var transportAverage = 72.88;
  var food = 0;
  var foodAverage = 97.13;
  var alcohol = 0;
  var alcoholAverage = 11.93;
  var clothing = 0;
  var clothingAverage = 25.13;
  var communication = 0;
  var communicationAverage = 17.18;
  var hobbies = 0;
  var hobbiesAverage = 46.7;
  var holidays = 0;
  var holidaysAverage =44.54;
  var maintenance = 0;
  var maintenanceAverage = 36.28;
  var scotlandResident = 0;
  // var health = 0;
  // var healthAverage = 13;
  // var publicTransport = 0;
  // var publicTransportAverage = 18.20;
  var yourSpending = 0;
  var otherBenefits = 0;
  var adults = 1;
  var children = 0;
  var salary = 0
  var dispDiv = document.getElementById("result");

  var averages = [housingAverage, transportAverage, foodAverage, alcoholAverage, clothingAverage, communicationAverage, hobbiesAverage, holidaysAverage, maintenanceAverage];
  var inputs = [housing, transport, food, alcohol, clothing, communication, hobbies, holidays, maintenance]

  // remove fallback image
  pymChild.sendHeight();
  $('#fallback').remove();

  // disable zoom in on mobile
  $(this).on('touchmove', function (event) {
      if (event.originalEvent.scale !== 1) {
          event.preventDefault();
          event.stopPropagation();
      }
  });

  // disabling refresh when enter clicked

  $(function() {
    $("form").submit(function() { return false; });
  });

  // function making slider handlers

  function makeHandle() {
    // get the handle
    var width = 80;
    var height = 40;
    var sliderHandle = d3.selectAll('.slider-handle');
    sliderHandle.style('margin-left', '-40px');

    sliderHandle.selectAll('svg').remove();

    var svg = d3.selectAll('.slider-handle').append('svg')
                  .attr('width', width)
                  .attr('height', height)
                  .append('g')
                  .attr("transform", "translate(" + 0 + "," + -20 + ")")


    var circle = svg.append("circle")
                    .attr('cy', 40)
                    .attr('cx', 40)
                    .attr('r', 17)
                    .style('fill', "#3b7a9e")

    var arrowRight = svg.append('path')
          .attr('class', 'right-arrow')
          .attr('d', 'm20,-7l7,7l-7,7')
          .attr("transform", "translate(" + 45 + "," + 40 + ")")
          .style('stroke', '#3b7a9e')
          .style('stroke-width', '2px')
          .style('fill', 'none')
          .transition()
            .duration(500)
            .on('start', function repeat() {
              d3.active(this)
                  .attr("transform", "translate(" + 50 + "," + 40 + ")")
                .transition()
                  .attr("transform", "translate(" + 45 + "," + 40 + ")")
                .transition()
                  .on('start', repeat);
          });
    //
    var arrowLeft = svg.append('path')
          .attr('class', 'left-arrow')
          .attr('d', 'm-20,-7l-7,7l7,7')
          .attr("transform", "translate(" + 20 + "," + 40 + ")")
          .style('stroke', '#3b7a9e')
          .style('stroke-width', '2px')
          .style('fill', 'none')
          .transition()
            .duration(500)
            .on('start', function repeat() {
              d3.active(this)
                  .attr("transform", "translate(" + 30 + "," + 40 + ")")
                .transition()
                  .attr("transform", "translate(" + 35 + "," + 40 + ")")
                .transition()
                  .on('start', repeat);
          });

  }

  // hover over function to change the info sign to black

  $(".info-sign").hover(
    function () {
         $(this).attr("src","./img/nlw_calculator_information-hover.svg");
    },
    function () {
        $(this).attr("src","./img/nlw_calculator_information.svg");
    }
);


  // disable navigation links - display only first
  d3.select('#second').style('display', 'none');
  d3.select('#third').style('display', 'none');


  //calculating the neto anual wage
  function netoCalculation(scotlandResident,salary) {
    if (scotlandResident === 0) {
      if (salary > 11850) {
        var tax = (salary - 11850) * 0.20;
        var nhs = (salary - 8424) * 0.12;
        // salary = salary - tax;
        return (salary - tax - nhs)
      }
      else if (salary > 8424 && salary <= 11850) {
        var nhs = (salary - 8424) * 0.12;
        return (salary - nhs);
      }
      else {
        return salary;
      }
    }
    else { //scotland
      if (salary > 24000) {
        var tax = ((salary - 24000) * 0.21)+(10150*0.20)+(2000*0.19);
        var nhs = (salary - 8424) * 0.12;
        // salary = salary - tax;
        return (salary - tax - nhs);
      }
      else if (salary > 13850 && salary <= 24000){
        var tax = ((salary - 13850) * 0.20)+(2000*0.19);
        var nhs = (salary - 8424) * 0.12;
        return (salary - tax - nhs);

      }
      else if (salary > 11850 && salary <= 13850){
        var tax = (salary - 11850) * 0.19;
        var nhs = (salary - 8424) * 0.12;
        return (salary - tax - nhs);
      }
      else if (salary > 8424 && salary <= 11850) {
        var nhs = (salary - 8424) * 0.12;
        return (salary - nhs);
      }
      else {
        return salary;
      }

    }
  };

  // calculating the figure in the result div
  function budgetCalculation() {
    if (livingWageBudget - yourSpending > 0) {
      return "<p>If you earned the National Living Wage, your household could save <span style='color:#3b7a9e; font-weight:900;'>£" + d3.format(",.0f")(Math.abs(livingWageBudget - yourSpending)) + '</span> per year.</p>';
    } else if (livingWageBudget - yourSpending < 0) {
      return "<p>If you earned the National Living Wage, your household would have to spend <span style='color:#3b7a9e; font-weight:900;'>£" + d3.format(",.0f")(Math.abs(livingWageBudget - yourSpending)) + "</span> less per year or work <span style='color:#3b7a9e; font-weight:900;'>" + d3.format(",.0f")((yourSpending-livingWageBudget)/52/7.5) + "</span> hours per week more to avoid spending more than you earn.</p>";
    } else {
      return "<p>Your household could save <span style='color:#3b7a9e; font-weight:900;'>£" + d3.format(",.0f")(Math.abs(livingWageBudget - yourSpending)) + '</span> per year living on the National Living Wage.</p>';
    }
  }

  // If you earned the National Living Wage, your household would have to spend £__________________ less per year, or work ______ hours per week more to avoid spending more than you earn


  // set the onload div display to none to get correct height for pym
  d3.select('#config').style('opacity', '0').style('display', 'none');
  pymChild.sendHeight();

  // displaying only the config div
  d3.select('#config').style('opacity', '1').style('display', 'block');
  d3.select('#config-text').style('opacity', '1').style('display', 'block');


  d3.select('#household-contributers').style('opacity', '0').style('display', 'none');

  for (i = 1; i < 4; i++) {
    d3.select('.person' + i).style('opacity', '0').style('display', 'none');
  }
  // d3.select('#changeSettings').style('opacity', '0').style('display', 'none');
  d3.select('#inputs').style('opacity', '0').style('display', 'none');
  d3.select('#sliders').style('opacity', '0').style('display', 'none');
  d3.select('#result').style('opacity', '0').style('display', 'none');
  d3.select('#under-nlw').style('opacity', '0').style('display', 'none');
  d3.select('#saveSettings').style('opacity', '0').style('display', 'none');
  d3.select('#text-slider').style('opacity', '0').style('display', 'none');

  d3.select('#config-text').style('opacity', '1').style('display', 'block');
  d3.select('#text-slider').style('opacity', '0').style('display', 'none');
  d3.select('#text-inputs').style('opacity', '0').style('display', 'none');

  d3.select('#previous-next-inputs').style('opacity', '0').style('display', 'none');
  d3.select('#previous-next-sliders').style('opacity', '0').style('display', 'none');



  // d3.select('.person1').style('opacity', '1').style('display', 'block');
  // $("#person1").slider({
  //   tooltip: 'hide'
  // });
  pymChild.sendHeight();



  // info if user lives in Scotland
  d3.selectAll("input[name='button-scotland']").on('click', function() {
      d3.select('#household-contributers').style('opacity', '1').style('display', 'block');
      scotlandResident = +this.value;
      pymChild.sendHeight();
    });

  // d3.selectAll("input[name='button-scotland']").on('keydown', function() {
  //   d3.selectAll("input[name='button-scotland']").dispatch('click');
  // })

  $("#input[name='button-scotland']").keypress(function(e){
        if(e.which == 13){//Enter key pressed
            $("input[name='button-scotland']").click();//Trigger button click event
        }
    });



  // calculating wage per hour
  d3.selectAll("input[name='button-age-1']")
    .on('click', function() {
      wagePerson1 = +this.value;
      // d3.select('#saveSettings').style('opacity', '1').style('display', 'block');

      // livingWageBudget = salary + children + otherBenefits;
    });

  d3.selectAll("input[name='button-age-2']")
    .on('click', function() {
      wagePerson2 = +this.value;
      // d3.select('#saveSettings').style('opacity', '1').style('display', 'block');

      // livingWageBudget = salary + children + otherBenefits;
    });

  d3.selectAll("input[name='button-age-3']")
    .on('click', function() {
      wagePerson3 = +this.value;
      // d3.select('#saveSettings').style('opacity', '1').style('display', 'block');

      // livingWageBudget = salary + children + otherBenefits;
    });

  // d3.selectAll("input[name='button-age-4']")
  //   .on('click', function() {
  //     wagePerson4 = +this.value;
  //     console.log(wagePerson4);
  //     // livingWageBudget = salary + children + otherBenefits;
  //   });

  // onload display only one slider for working hours
  // $('#person1').on('change', function(ev) {
  //
  //   // how many working days are there in a year, also how will we calculate tax
  //   oldSalary = ev.value.oldValue * wagePerson1 * 52;
  //   newSalary = ev.value.newValue * wagePerson1 * 52;
  //   salary = +(salary + netoCalculation(newSalary) - netoCalculation(oldSalary)).toFixed(2);
  //   document.getElementById("changeHours1").innerHTML = ev.value.newValue;
  // });

  // displaying "How many people contribute to household"



  // calculating the NLW household income and dispaying the sliders depending how many persons are chosen
  d3.selectAll("input[name='button-household']")
    .on('click', function() {



      adults = +this.value;

      //  if more than 1, chanke 'How old are you' to 'How old is person 1'

      if (adults !== 1) {
        document.getElementById('question-person1-age').innerHTML = 'How old is person 1?';
        document.getElementById('question-person1-hours').innerHTML = 'does person 1';
      } else {
        document.getElementById('question-person1-age').innerHTML = 'How old are you?';
        document.getElementById('question-person1-hours').innerHTML = 'do you';
      }

      salary = 0;
      dispDiv.innerHTML = budgetCalculation();
      for (i = 1; i < 4; i++) {
        // destroy the displayed sliders everytime the number of perons button is clicked
        d3.select('.person' + i).style('opacity', '0').style('display', 'none');
        $("#person" + i).slider({
          tooltip: 'hide'
        });
        $("#person" + i).slider('destroy');
        pymChild.sendHeight();

        document.getElementById("changeHours" + i).innerHTML = '0';
      }

      // displaying working hour sliders for number of persons selected
      for (i = 1; i <= adults; i++) {

        d3.select('.person' + i).style('opacity', '1').style('display', 'block');
        pymChild.sendHeight();

        $("#person" + i).slider({
          tooltip: 'hide'
        });
        pymChild.sendHeight();

      }

      makeHandle()

      // calculating the salary
      $('#person1').on('change', function(ev) {

        // how many working days are there in a year, also how will we calculate tax
        oldSalary = ev.value.oldValue * wagePerson1 * 52;
        newSalary = ev.value.newValue * wagePerson1 * 52;
        salary = +(salary + netoCalculation(scotlandResident, newSalary) - netoCalculation(scotlandResident, oldSalary)).toFixed(2);
        document.getElementById("changeHours1").innerHTML = ev.value.newValue;
        d3.select('#saveSettings').style('opacity', '1').style('display', 'block');
        pymChild.sendHeight();


      });

      $('#person2').on('change', function(ev) {

        // how many working days are there in a year, also how we wil calculate tax
        oldSalary = ev.value.oldValue * wagePerson2 * 52;
        newSalary = ev.value.newValue * wagePerson2 * 52;
        salary = +(salary + netoCalculation(scotlandResident, newSalary) - netoCalculation(scotlandResident, oldSalary)).toFixed(2);
        document.getElementById("changeHours2").innerHTML = ev.value.newValue;
      });

      $('#person3').on('change', function(ev) {

        // how many working days are there in a year, also how we wil calculate tax
        oldSalary = ev.value.oldValue * wagePerson3 * 52;
        newSalary = ev.value.newValue * wagePerson3 * 52;
        salary = +(salary + netoCalculation(scotlandResident, newSalary) - netoCalculation(scotlandResident, oldSalary)).toFixed(2);
        document.getElementById("changeHours3").innerHTML = ev.value.newValue;
      });

      // $('#person4').on('change', function(ev) {
      //
      //   // how many working days are there in a year, also how we wil calculate tax
      //   oldSalary = ev.value.oldValue * wagePerson4 * 52;
      //   newSalary = ev.value.newValue * wagePerson4 * 52;
      //   salary = +(salary + netoCalculation(newSalary) - netoCalculation(oldSalary)).toFixed(2);
      //   document.getElementById("changeHours4").innerHTML = ev.value.newValue;
      // });

    });

    $('#saveSettings').keypress(function(e){
          if(e.which == 13){//Enter key pressed
              $('#saveSettings').click();//Trigger search button click event
          }
      });
  // when save button is clicked, display the inputs div and the navigation link to it
  d3.select('#saveSettings').on('click', function() {
    // scroll to top otherwise the position of previous screen is used
    document.getElementById("wrapper").scrollIntoView();

    // d3.select('#second').style('display', 'inline');
    // d3.select('#third').style('display', 'none');

    d3.select('#config').style('opacity', '0').style('display', 'none');
    // d3.select('#changeSettings').style('opacity', '0').style('display', 'none');
    d3.select('#sliders').style('opacity', '0').style('display', 'none');
    d3.select('#result').style('opacity', '0').style('display', 'none');
    d3.select('#under-nlw').style('opacity', '0').style('display', 'none');
    d3.select('#inputs').style('opacity', '1').style('display', 'block');
    d3.select('#config-text').style('opacity', '0').style('display', 'none');
    d3.select('#text-slider').style('opacity', '0').style('display', 'none');
    d3.select('#text-inputs').style('opacity', '1').style('display', 'block');
    d3.select('#saveSettings').style('opacity', '0').style('display', 'none');
    d3.select('#previous-next-inputs').style('opacity', '1').style('display', 'block');
    d3.select('#previous-next-sliders').style('opacity', '0').style('display', 'none');


    pymChild.sendHeight();

  });

  $("#button-18").keypress(function(e){
        if(e.which == 13){//Enter key pressed
            $("button-18").click();//Trigger button click event
        }
    });


  // when home navigation link is clicked, display only the settings div and only the home navigation link
  d3.select('#button-18').on('click', function() {
    // scroll to top otherwise the position of previous screen is used
    document.getElementById("wrapper").scrollIntoView();

    // d3.select('#second').style('display', 'none');
    // d3.select('#third').style('display', 'none');
    d3.select('#config').style('opacity', '1').style('display', 'block');
    // d3.select('#changeSettings').style('opacity', '0').style('display', 'none');
    d3.select('#inputs').style('opacity', '0').style('display', 'none');
    d3.select('#sliders').style('opacity', '0').style('display', 'none');
    d3.select('#result').style('opacity', '0').style('display', 'none');
    d3.select('#under-nlw').style('opacity', '0').style('display', 'none');
    d3.select('#config-text').style('opacity', '1').style('display', 'block');
    d3.select('#text-slider').style('opacity', '0').style('display', 'none');
    d3.select('#text-inputs').style('opacity', '0').style('display', 'none');
    d3.select('#saveSettings').style('opacity', '1').style('display', 'block');
    d3.select('#previous-next-inputs').style('opacity', '0').style('display', 'none');
    d3.select('#previous-next-sliders').style('opacity', '0').style('display', 'none');


    pymChild.sendHeight();

  });

  $("#button-20").keypress(function(e){
        if(e.which == 13){//Enter key pressed
            $("button-20").click();//Trigger button click event
        }
    });



  // when navigation link for inputs is clicked display the inputs div and destroy sliders
  d3.select('#button-20').on('click', function() {
    // scroll to top otherwise the position of previous screen is used
    document.getElementById("wrapper").scrollIntoView();

    // d3.select('#third').style('display', 'none');
    d3.select('#config').style('opacity', '0').style('display', 'none');
    // d3.select('#changeSettings').style('opacity', '0').style('display', 'none');
    d3.select('#sliders').style('opacity', '0').style('display', 'none');
    d3.select('#result').style('opacity', '0').style('display', 'none');
    d3.select('#under-nlw').style('opacity', '0').style('display', 'none');
    d3.select('#inputs').style('opacity', '1').style('display', 'block');
    d3.select('#config-text').style('opacity', '0').style('display', 'none');
    d3.select('#text-slider').style('opacity', '0').style('display', 'none');
    d3.select('#text-inputs').style('opacity', '1').style('display', 'block');
    d3.select('#saveSettings').style('opacity', '0').style('display', 'none');
    d3.select('#previous-next-inputs').style('opacity', '1').style('display', 'block');
    d3.select('#previous-next-sliders').style('opacity', '0').style('display', 'none');



    $("#ex1, #ex2, #ex3, #ex4, #ex5, #ex6, #ex7, #ex8, #ex9").slider('destroy');

    pymChild.sendHeight();

  });

  $("#button-22").keypress(function(e){
        if(e.which == 13){//Enter key pressed
            $("button-22").click();//Trigger button click event
        }
    });


  // when navigation link for inputs is clicked display the inputs div and destroy sliders
  d3.select('#button-22').on('click', function() {
    // scroll to top otherwise the position of previous screen is used
    document.getElementById("wrapper").scrollIntoView();

    // d3.select('#third').style('display', 'none');
    d3.select('#config').style('opacity', '0').style('display', 'none');
    // d3.select('#changeSettings').style('opacity', '0').style('display', 'none');
    d3.select('#sliders').style('opacity', '0').style('display', 'none');
    d3.select('#result').style('opacity', '0').style('display', 'none');
    d3.select('#under-nlw').style('opacity', '0').style('display', 'none');
    d3.select('#inputs').style('opacity', '1').style('display', 'block');
    d3.select('#config-text').style('opacity', '0').style('display', 'none');
    d3.select('#text-slider').style('opacity', '0').style('display', 'none');
    d3.select('#text-inputs').style('opacity', '1').style('display', 'block');
    d3.select('#saveSettings').style('opacity', '0').style('display', 'none');
    d3.select('#previous-next-inputs').style('opacity', '1').style('display', 'block');
    d3.select('#previous-next-sliders').style('opacity', '0').style('display', 'none');



    // $("#ex1, #ex2, #ex3, #ex4, #ex5, #ex6, #ex7, #ex8, #ex9").slider('destroy');

    pymChild.sendHeight();

  })

  // delete input box content when clicked
  document.getElementById('housing-input').onclick = function () {
    document.getElementById('housing-input').value = "";
  };

  document.getElementById('transport-input').onclick = function () {
    document.getElementById('transport-input').value = "";
  };

  document.getElementById('food-input').onclick = function () {
    document.getElementById('food-input').value = "";
  };

  document.getElementById('alcohol-input').onclick = function () {
    document.getElementById('alcohol-input').value = "";
  };

  document.getElementById('clothing-input').onclick = function () {
    document.getElementById('clothing-input').value = "";
  };

  document.getElementById('communication-input').onclick = function () {
    document.getElementById('communication-input').value = "";
  };

  document.getElementById('leasure-input').onclick = function () {
    document.getElementById('leasure-input').value = "";
  };

  // document.getElementById('restaurant-input').onclick = function () {
  //   document.getElementById('restaurant-input').value = "";
  // };

  document.getElementById('holidays-input').onclick = function () {
    document.getElementById('holidays-input').value = "";
  };

  document.getElementById('maintenance-input').onclick = function () {
    document.getElementById('maintenance-input').value = "";
  };

  // document.getElementById('health-input').onclick = function () {
  //   document.getElementById('health-input').value = "";
  // };

  // document.getElementById('public-input').onclick = function () {
  //   document.getElementById('public-input').value = "";
  // };

  $("#button-19").keypress(function(e){
        if(e.which == 13){//Enter key pressed
            $("button-19").click();//Trigger button click event
        }
    });


  // get values from input windows, display sliders
  d3.select('#button-19').on('click', function() {

    // scroll to top otherwise the position of previous screen is used
    document.getElementById("wrapper").scrollIntoView();

    // get values
    housing = +document.getElementById('housing-input').value;
    transport = +document.getElementById('transport-input').value;
    food = +document.getElementById('food-input').value;
    alcohol = +document.getElementById('alcohol-input').value;
    clothing = +document.getElementById('clothing-input').value;
    communication = +document.getElementById('communication-input').value;
    hobbies = +document.getElementById('leasure-input').value;
    // restaurant = +document.getElementById('restaurant-input').value;
    holidays = +document.getElementById('holidays-input').value;
    maintenance = +document.getElementById('maintenance-input').value;
    // health = +document.getElementById('health-input').value;
    // publicTransport = +document.getElementById('public-input').value;

    // average and input arrays
    // averages = [housingAverage, transportAverage, foodAverage, alcoholAverage, clothingAverage, communicationAverage, hotelsAverage];
    inputs = [housing, transport, food, alcohol, clothing, communication, hobbies, holidays, maintenance]

    // get the preiod of time
    var housingPeriod = +document.getElementById('period-1').value;
    var transportPeriod = +document.getElementById('period-2').value;
    var foodPeriod = +document.getElementById('period-3').value;
    var alcoholPeriod = +document.getElementById('period-4').value;
    var clothingPeriod = +document.getElementById('period-5').value;
    var communicationPeriod = +document.getElementById('period-6').value;
    var hobbiesPeriod = +document.getElementById('period-7').value;
    // var restaurantPeriod = +document.getElementById('period-8').value;
    var holidaysPeriod = +document.getElementById('period-8').value;
    var maintenancePeriod = +document.getElementById('period-9').value;
    // var healthPeriod = +document.getElementById('period-10').value;
    // var publicPeriod = +document.getElementById('period-10').value;



    // console.log(billsPeriod);

    livingWageBudget = salary;
    yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;

    // check if inputs are numbers

    if (isNaN(housing) === false && isNaN(transport) === false && isNaN(food) === false && isNaN(alcohol) === false && isNaN(clothing) === false && isNaN(communication) === false && isNaN(hobbies) === false && isNaN(maintenance) === false && isNaN(holidays) === false) {

      // if spending is lower than NLW budget or equal, display only message
      if (livingWageBudget - yourSpending >= 0) {

        // disable navigation links
        // d3.select('#first').style('display', 'none');
        // d3.select('#second').style('display', 'none');
        // d3.select('#third').style('display', 'none');

        // display only the result div
        d3.select('#under-nlw').style('opacity', '1').style('display', 'block');
        d3.select('#config').style('opacity', '0').style('display', 'none');
        // d3.select('#changeSettings').style('opacity', '0').style('display', 'none');
        d3.select('#inputs').style('opacity', '0').style('display', 'none');
        d3.select('#sliders').style('opacity', '0').style('display', 'none');
        d3.select('#result').style('opacity', '1').style('display', 'block');
        d3.select('#config-text').style('opacity', '0').style('display', 'none');
        d3.select('#text-inputs').style('opacity', '0').style('display', 'none');
        d3.select('#text-slider').style('opacity', '0').style('display', 'none');

        d3.select('#saveSettings').style('opacity', '0').style('display', 'none');
        d3.select('#previous-next-inputs').style('opacity', '0').style('display', 'none');
        d3.select('#previous-next-sliders').style('opacity', '0').style('display', 'none');



        dispDiv.innerHTML = budgetCalculation();

        pymChild.sendHeight();

      }
      // if spending is higher than NLW budget display sliders so that users can adjust their spendings
      else {

        // change per month amount  - sliders
        document.getElementById("changeHousing").innerHTML = '£' + d3.format(",.0f")(housing);
        document.getElementById("changeTransport").innerHTML = '£' + d3.format(",.0f")(transport);
        document.getElementById("changeFood").innerHTML = '£' + d3.format(",.0f")(food);
        document.getElementById("changeAlcohol").innerHTML = '£' + d3.format(",.0f")(alcohol);
        document.getElementById("changeClothing").innerHTML = '£' + d3.format(",.0f")(clothing);
        document.getElementById("changeCommunication").innerHTML = '£' + d3.format(",.0f")(communication);
        document.getElementById("changeLeasure").innerHTML = '£' + d3.format(",.0f")(hobbies);
        // document.getElementById("changeRestaurant").innerHTML = '£' + d3.format(",.0f")(restaurant);
        document.getElementById("changeHolidays").innerHTML = '£' + d3.format(",.0f")(holidays);
        document.getElementById("changeMaintenance").innerHTML = '£' + d3.format(",.0f")(maintenance);
        // document.getElementById("changeHealth").innerHTML = '£' + d3.format(",.0f")(health);
        // document.getElementById("changePublic").innerHTML = '£' + d3.format(",.0f")(publicTransport);

        // change the period of time

        // housing
        if (housingPeriod === 1) {
          document.getElementById("housing-time").innerHTML = 'year';
        }
        if (housingPeriod === 12) {
          document.getElementById("housing-time").innerHTML = 'month';
        }
        if (housingPeriod === 52) {
          document.getElementById("housing-time").innerHTML = 'week';
        }

        // transport
        if (transportPeriod === 1) {
          document.getElementById("transport-time").innerHTML = 'year';
        }
        if (transportPeriod === 12) {
          document.getElementById("transport-time").innerHTML = 'month';
        }
        if (transportPeriod === 52) {
          document.getElementById("transport-time").innerHTML = 'week';
        }

        // food
        if (foodPeriod === 1) {
          document.getElementById("food-time").innerHTML = 'year';
        }
        if (foodPeriod === 12) {
          document.getElementById("food-time").innerHTML = 'month';
        }
        if (foodPeriod === 52) {
          document.getElementById("food-time").innerHTML = 'week';
        }

        // clothing
        if (alcoholPeriod === 1) {
          document.getElementById("alcohol-time").innerHTML = 'year';
        }
        if (alcoholPeriod === 12) {
          document.getElementById("alcohol-time").innerHTML = 'month';
        }
        if (alcoholPeriod === 52) {
          document.getElementById("alcohol-time").innerHTML = 'week';
        }

        // hobbies
        if (clothingPeriod === 1) {
          document.getElementById("clothing-time").innerHTML = 'year';
        }
        if (clothingPeriod === 12) {
          document.getElementById("clothing-time").innerHTML = 'month';
        }
        if (clothingPeriod === 52) {
          document.getElementById("clothing-time").innerHTML = 'week';
        }

        // bills
        if (communicationPeriod === 1) {
          document.getElementById("communication-time").innerHTML = 'year';
        }
        if (communicationPeriod === 12) {
          document.getElementById("communication-time").innerHTML = 'month';
        }
        if (communicationPeriod === 52) {
          document.getElementById("communication-time").innerHTML = 'week';
        }

        // holidays
        if (hobbiesPeriod === 1) {
          document.getElementById("leasure-time").innerHTML = 'year';
        }
        if (hobbiesPeriod === 12) {
          document.getElementById("leasure-time").innerHTML = 'month';
        }
        if (hobbiesPeriod === 52) {
          document.getElementById("leasure-time").innerHTML = 'week';
        }

        // // children
        // if (restaurantPeriod === 1) {
        //   document.getElementById("restaurant-time").innerHTML = 'year';
        // }
        // if (restaurantPeriod === 12) {
        //   document.getElementById("restaurant-time").innerHTML = 'month';
        // }
        // if (restaurantPeriod === 52) {
        //   document.getElementById("restaurant-time").innerHTML = 'week';
        // }


        // children
        if (holidaysPeriod === 1) {
          document.getElementById("holidays-time").innerHTML = 'year';
        }
        if (holidaysPeriod === 12) {
          document.getElementById("holidays-time").innerHTML = 'month';
        }
        if (holidaysAverage === 52) {
          document.getElementById("holidays-time").innerHTML = 'week';
        }

        // maintenance
        if (maintenancePeriod === 1) {
          document.getElementById("maintenance-time").innerHTML = 'year';
        }
        if (maintenancePeriod === 12) {
          document.getElementById("maintenance-time").innerHTML = 'month';
        }
        if (maintenancePeriod === 52) {
          document.getElementById("maintenance-time").innerHTML = 'week';
        }

        // health & education
        // if (healthPeriod === 1) {
        //   document.getElementById("health-time").innerHTML = 'year';
        // }
        // if (healthPeriod === 12) {
        //   document.getElementById("health-time").innerHTML = 'month';
        // }
        // if (healthPeriod === 52) {
        //   document.getElementById("health-time").innerHTML = 'week';
        // }

        // public transport
        // if (publicPeriod === 1) {
        //   document.getElementById("public-time").innerHTML = 'year';
        // }
        // if (publicPeriod === 12) {
        //   document.getElementById("public-time").innerHTML = 'month';
        // }
        // if (publicPeriod === 52) {
        //   document.getElementById("public-time").innerHTML = 'week';
        // }

        // dispDiv.innerHTML = budgetCalculation();

        d3.select('#third').style('display', 'inline');

        d3.select('#config').style('opacity', '0').style('display', 'none');
        // d3.select('#changeSettings').style('opacity', '1').style('display', 'block');
        d3.select('#inputs').style('opacity', '0').style('display', 'none');
        d3.select('#sliders').style('opacity', '1').style('display', 'block');
        d3.select('#result').style('opacity', '1').style('display', 'block');
        d3.select('#config-text').style('opacity', '0').style('display', 'none');
        d3.select('#text-inputs').style('opacity', '0').style('display', 'none');
        d3.select('#text-slider').style('opacity', '1').style('display', 'block');
        d3.select('#saveSettings').style('opacity', '0').style('display', 'none');
        d3.select('#previous-next-inputs').style('opacity', '0').style('display', 'none');
        d3.select('#previous-next-sliders').style('opacity', '1').style('display', 'block');



        // // set the values of sliders with the values from inputs
        // $('#ex1').attr('data-slider-value', housing);
        // $('#ex2').attr('data-slider-value', transport);
        // $('#ex3').attr('data-slider-value', food);
        // $('#ex4').attr('data-slider-value', clothing);
        // $('#ex5').attr('data-slider-value', hobbies);
        // $('#ex6').attr('data-slider-value', bills);
        // $('#ex7').attr('data-slider-value', holidays);
        // $('#ex8').attr('data-slider-value', kids);

        // // set the maximums
        // $('#ex1').attr('data-slider-max', housing);
        // // document.getElementById('tick-two-housing').innerHTML = '£' + housing;
        //
        // $('#ex2').attr('data-slider-max', transport);
        // // document.getElementById('tick-two-transport').innerHTML = '£' + transport;
        //
        // $('#ex3').attr('data-slider-max', food);
        // // document.getElementById('tick-two-food').innerHTML = '£' + food;
        //
        // $('#ex4').attr('data-slider-max', clothing);
        // // document.getElementById('tick-two-clothing').innerHTML = '£' + clothing;
        //
        // $('#ex5').attr('data-slider-max', hobbies);
        // // document.getElementById('tick-two-hobbies').innerHTML = '£' + hobbies;
        //
        // $('#ex6').attr('data-slider-max', bills);
        // // document.getElementById('tick-two-bills').innerHTML = '£' + bills;
        //
        // $('#ex7').attr('data-slider-max', holidays);
        // // document.getElementById('tick-two-holidays').innerHTML = '£' + holidays;
        //
        // $('#ex8').attr('data-slider-max', kids);
        // // document.getElementById('tick-two-kids').innerHTML = '£' + kids;

        // $("#ex1, #ex2, #ex3, #ex4, #ex5, #ex6, #ex7, #ex8").slider({
        //   tooltip: 'hide'
        // });



        // console.log(+document.getElementById('period-11').value);


        for (i=0; i<inputs.length; i++) {
          // console.log(+document.getElementById('period-11');
          if (+document.getElementById('period-' + (i+1)).value === 52) {
            var averageValue = averages[i];
          }
          else if (+document.getElementById('period-' + (i+1)).value === 12) {
            var averageValue = (averages[i]*4.333);

          } else {
            var averageValue = (averages[i]*52);

          }
          var inputValue = inputs[i];
          var average_div = 'uk-average-' + (i+1);

          if (inputValue > averageValue) {
            // set the values of sliders with the values from inputs
            if ($('#ex'+(i+1))) {
              $('#ex'+(i+1)).slider('destroy');
            }

            $('#ex'+(i+1)).attr('data-slider-value', inputValue);
            $('#ex'+(i+1)).attr('value', inputValue);


            // set the maximums
            $('#ex'+(i+1)).attr('data-slider-max', inputValue);
            $("#ex"+(i+1)).slider({
              tooltip: 'hide'
            });
            pymChild.sendHeight();


          } else {
            // set the values of sliders with the values from inputs
            if ($('#ex'+(i+1))) {
              $('#ex'+(i+1)).slider('destroy');
            }

            $('#ex'+(i+1)).attr('data-slider-value', inputValue);
            $('#ex'+(i+1)).attr('value', inputValue);


            // set the maximums
            $('#ex'+(i+1)).attr('data-slider-max', averageValue);

            $("#ex"+(i+1)).slider({
              tooltip: 'hide'
            });
            pymChild.sendHeight();


          }


          // var average_div = document.getElementById('uk-average-'+(i+1))
          drawAverage(average_div, averageValue, inputValue)
          // document.getElementById('ex'+i).value
        }

        makeHandle()




        function drawAverage(average_div, averageValue, inputValue){

          // draw UK average line
          var width_average = document.getElementById(average_div).clientWidth;
          var height_average = 50;
          var data = [[averageValue, 0], [averageValue, 20]];

          if (inputValue > averageValue) {

            var x = d3.scaleLinear()
                .domain([0,inputValue])
                .range([0, width_average]);

          } else {

            var x = d3.scaleLinear()
                .domain([0,averageValue])
                .range([0, width_average]);
          }

          //

          var y = d3.scaleLinear()
              .domain([0, 20])
              .range([0, 35])
          //
          // // x;
          // // y;
          //
          var line = d3.line()
                .x( function(d) { if ((x(averageValue)) < (width_average/2)) { return x(d[0])+1 }
                else { return x(d[0])-1; }})
                .y( function(d) { return y(d[1]); });
          //
          //
          d3.select('#'+ average_div).selectAll("*").remove();

          var svg_average = d3.select('#'+average_div).append('svg')
                        .attr('class', 'svg-line')
                        .attr('class', average_div)
                        .attr('width', width_average)
                        .attr('height', height_average)
                        // .append('g');
                        // .attr("transform", "translate(" + 0 + "," + -3 + ")");

          var average_line = svg_average.selectAll('.line')
                                .data([data]);

          average_line
            .enter()
            .append('path')
              .attr('class', 'line')
              .attr("fill", "none")
              .attr("stroke", "#BBBDBF")
              .attr("stroke-width", 3)
              .attr('d', line);

          var text = average_line.enter().append('text')
              // .attr('x', x(30))
              .attr("x", function() {
                if ((x(averageValue)) < (width_average/2)) { return x(averageValue) +5 }
                else { return x(averageValue) -70 }
              })
              .attr('y', y(18.5))
              .attr('text-anchor', function () {
                if ((x(averageValue)) < (width_average/2)) { return 'start' }
                else { return 'end'}
              })
              .text('£'+d3.format(",.0f")(averageValue))
              .style('fill', '#BBBDBF')
              .style('font-weight', 'bold')
              .style('font-size', '18px' );

          d3.select('.'+average_div).append('text')
              .attr("x", function() {
                if ((x(averageValue)) < (width_average/2)) { return x(averageValue)+48 }
                else { return x(averageValue)-5 }
              })
              .attr('y', y(18.5))
              .attr('text-anchor', function () {
                if ((x(averageValue)) < (width_average/2)) { return 'start' }
                else { return 'end'}
              })
              .text('UK average')
              .style('fill', '#BBBDBF')
              .style('font-size', '12px' );



          pymChild.sendHeight();
        }

        // // draw UK average line
        // var width = document.getElementById(average_div).clientWidth;
        // var height = 50;
        // var data = [[30, 0], [30, 20]];
        // //
        // var x = d3.scaleLinear()
        //     .domain([0,housing])
        //     .range([0, width]);
        //
        // var y = d3.scaleLinear()
        //     .domain([0, 25])
        //     .range([0, height])
        // //
        // // // x;
        // // // y;
        // //
        // var line = d3.line()
        //       .x( function(d) { console.log(d);return x(d[0]); })
        //       .y( function(d) { return y(d[1]); });
        // //
        // //
        // d3.select('#uk-housing-average').selectAll("*").remove();
        //
        // var svg = d3.select('#uk-housing-average').append('svg')
        //               .attr('class', 'svg-line')
        //               .attr('width', width)
        //               .attr('height', height)
        //               // .append('g');
        //               //.attr("transform", "translate(" + 0 + "," + 0 + ")");
        //
        // var average_line = svg.selectAll('.line')
        //                       .data([data]);
        //
        // average_line
        //   .enter()
        //   .append('path')
        //     .attr('class', 'line')
        //     .attr("fill", "none")
        //     .attr("stroke", "steelblue")
        //     .attr("stroke-width", 1.5)
        //     .attr('d', line);
        //
        // var text = average_line.enter().append('text')
        //     // .attr('x', x(30))
        //     .attr("x", function() {
        //       if ((x(30)) < (width/2)) { return x(31) }
        //       else { return x(29)}
        //     })
        //     .attr('y', y(20))
        //     .attr('text-anchor', function () {
        //       if ((x(30)) < (width/2)) { return 'start' }
        //       else { return 'end'}
        //     })
        //     .attr('class', 'housing-average')
        //     .text('UK average');

        pymChild.sendHeight();


        // svg.append('g')
        //     .attr("transform", "translate(" + 0 + "," + 10 + ")")
        //     .call(d3.axisBottom(x));
            // .append('line')
            //                 .attr("x1", 30)
            //                 .attr("x2", 30)
            //
            //                 .attr("y1", 0)
            //                 .attr("y2", height)
            //                 .attr("stroke-width", 2)
            //                 .attr("stroke", "gray");

        // svg.append('g')
        //     .call(d3.axisLeft(y));





        // var g = svg.append('g');

        // var line = svg.
        dispDiv.innerHTML = budgetCalculation();

        pymChild.sendHeight();

        // Housing slider
        $('#ex1').on('change', function(ev) {
          housing = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeHousing").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
          // console.log((Math.abs((yourSpending/wage)/52)))
        });

        // Transport slider
        $('#ex2').on('change', function(ev) {
          transport = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeTransport").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
        });

        // Food slider
        $('#ex3').on('change', function(ev) {
          food = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeFood").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
        });

        // Clothing slider
        $('#ex4').on('change', function(ev) {
          alcohol = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeAlcohol").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
        });

        // Hobbies slider
        $('#ex5').on('change', function(ev) {
          clothing = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeClothing").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
        });

        // Bills slider
        $('#ex6').on('change', function(ev) {
          communication = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeCommunication").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
        });

        // Holidays slider
        $('#ex7').on('change', function(ev) {
          hobbies = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeLeasure").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
        });

        // // restaurant activities slider
        // $('#ex8').on('change', function(ev) {
        //   restaurant = ev.value.newValue;
        //   console.log(restaurant)
        //   yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + restaurantPeriod * restaurant + holidaysPeriod * holidays + maintenancePeriod * maintenance;
        //   document.getElementById("changeRestaurant").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
        //   dispDiv.innerHTML = budgetCalculation();
        // });

        // changeHolidays  slider
        $('#ex8').on('change', function(ev) {
          holidays = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeHolidays").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
          // console.log((Math.abs((yourSpending/wage)/52)))
        });


        // Maintenance activities slider
        $('#ex9').on('change', function(ev) {
          maintenance = ev.value.newValue;
          yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + holidaysPeriod * holidays + maintenancePeriod * maintenance;
          document.getElementById("changeMaintenance").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
          dispDiv.innerHTML = budgetCalculation();
        });

        // health activities slider
        // $('#ex10').on('change', function(ev) {
        //   health = ev.value.newValue;
        //   console.log(health)
        //   yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + restaurantPeriod * restaurant + holidaysPeriod * holidays + maintenancePeriod * maintenance + healthPeriod * health + publicPeriod * publicTransport;
        //   document.getElementById("changeHealth").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
        //   dispDiv.innerHTML = budgetCalculation();
        // });

        // public transport slider
        // $('#ex10').on('change', function(ev) {
        //   publicTransport = ev.value.newValue;
        //   console.log(publicTransport)
        //   yourSpending = housingPeriod * housing + transportPeriod * transport + foodPeriod * food + alcoholPeriod * alcohol + clothingPeriod * clothing  + communicationPeriod * communication + hobbiesPeriod * hobbies + restaurantPeriod * restaurant + holidaysPeriod * holidays + maintenancePeriod * maintenance +  publicPeriod * publicTransport;
        //   document.getElementById("changePublic").innerHTML = '£' + d3.format(",.0f")(ev.value.newValue);
        //   dispDiv.innerHTML = budgetCalculation();
        //   // console.log((Math.abs((yourSpending/wage)/52)))
        // });




      }
    }
    // display warning in input boxes
    else {

      if (isNaN(housing) === true ) {

        document.getElementById('housing-input').value = "Enter a number";
        document.getElementById('housing-input').style.color = 'red';
        document.getElementById('housing-input').onclick = function() {
          document.getElementById('housing-input').value = "";
          document.getElementById('housing-input').style.color = 'black';

        }
      }

      if (isNaN(transport) === true ) {

        document.getElementById('transport-input').value = "Enter a number";
        document.getElementById('transport-input').style.color = 'red';
        document.getElementById('transport-input').onclick = function() {
          document.getElementById('transport-input').value = "";
          document.getElementById('transport-input').style.color = 'black';

        }
      }

      if (isNaN(food) === true ) {

        document.getElementById('food-input').value = "Enter a number";
        document.getElementById('food-input').style.color = 'red';
        document.getElementById('food-input').onclick = function() {
          document.getElementById('food-input').value = "";
          document.getElementById('food-input').style.color = 'black';

        }
      }

      if (isNaN(alcohol) === true ) {

        document.getElementById('alcohol-input').value = "Enter a number";
        document.getElementById('alcohol-input').style.color = 'red';
        document.getElementById('alcohol-input').onclick = function() {
          document.getElementById('alcohol-input').value = "";
          document.getElementById('alcohol-input').style.color = 'black';

        }
      }

      if (isNaN(clothing) === true ) {

        document.getElementById('clothing-input').value = "Enter a number";
        document.getElementById('clothing-input').style.color = 'red';
        document.getElementById('clothing-input').onclick = function() {
          document.getElementById('clothing-input').value = "";
          document.getElementById('clothing-input').style.color = 'black';

        }
      }

      if (isNaN(communication) === true ) {

        document.getElementById('communication-input').value = "Enter a number";
        document.getElementById('communication-input').style.color = 'red';
        document.getElementById('communication-input').onclick = function() {
          document.getElementById('communication-input').value = "";
          document.getElementById('communication-input').style.color = 'black';

        }
      }

      if (isNaN(hobbies) === true ) {

        document.getElementById('leasure-input').value = "Enter a number";
        document.getElementById('leasure-input').style.color = 'red';
        document.getElementById('leasure-input').onclick = function() {
          document.getElementById('leasure-input').value = "";
          document.getElementById('leasure-input').style.color = 'black';

        }
      }

      // if (isNaN(restaurant) === true ) {
      //
      //   document.getElementById('restaurant-input').value = "Enter a number";
      //   document.getElementById('restaurant-input').style.color = 'red';
      //   document.getElementById('restaurant-input').onclick = function() {
      //     document.getElementById('restaurant-input').value = "";
      //     document.getElementById('restaurant-input').style.color = 'black';
      //
      //   }
      // }


      if (isNaN(holidays) === true ) {

        document.getElementById('holidays-input').value = "Enter a number";
        document.getElementById('holidays-input').style.color = 'red';
        document.getElementById('holidays-input').onclick = function() {
          document.getElementById('holidays-input').value = "";
          document.getElementById('holidays-input').style.color = 'black';

        }
      }

      if (isNaN(maintenance) === true ) {

        document.getElementById('maintenance-input').value = "Enter a number";
        document.getElementById('maintenance-input').style.color = 'red';
        document.getElementById('maintenance-input').onclick = function() {
          document.getElementById('maintenance-input').value = "";
          document.getElementById('maintenance-input').style.color = 'black';

        }
      }

      // if (isNaN(health) === true ) {
      //
      //   document.getElementById('health-input').value = "Enter a number";
      //   document.getElementById('health-input').style.color = 'red';
      //   document.getElementById('health-input').onclick = function() {
      //     document.getElementById('health-input').value = "";
      //     document.getElementById('health-input').style.color = 'black';
      //
      //   }
      // }

      // if (isNaN(publicTransport) === true ) {
      //
      //   document.getElementById('public-input').value = "Enter a number";
      //   document.getElementById('public-input').style.color = 'red';
      //   document.getElementById('public-input').onclick = function() {
      //     document.getElementById('public-input').value = "";
      //     document.getElementById('public-input').style.color = 'black';
      //
      //   }
      // }




    }

  });

  // when reset button is clicked, reset all previous input and return to first screen
  d3.selectAll('.resetSettings').on('click', function() {

    // scroll to top otherwise the position of previous screen is used
    document.getElementById("wrapper").scrollIntoView();

    // reset all period of time dropdowns
    var elements = document.getElementsByTagName('select');
    for (var i = 0; i < elements.length; i++)
    {
        elements[i].selectedIndex = 1;
    }

    // set the on load values
    wagePerson1 = 7.83;
    wagePerson2 = 7.83;
    wagePerson3 = 7.83;
    wagePerson4 = 7.83;
    livingWageBudget = 0;
    housing = 0;
    housingAverage = 202.41;
    transport = 0;
    transportAverage = 72.88;
    food = 0;
    foodAverage = 97.13;
    alcohol = 0;
    alcoholAverage = 11.93;
    clothing = 0;
    clothingAverage = 25.13;
    communication = 0;
    communicationAverage = 17.18;
    hobbies = 0;
    hobbiesAverage = 46.7;
    holidays = 0;
    holidaysAverage =44.54;
    maintenance = 0;
    maintenanceAverage = 36.28;
    scotlandResident = 0;
    // var health = 0;
    // var healthAverage = 13;
    // var publicTransport = 0;
    // var publicTransportAverage = 18.20;
    yourSpending = 0;
    otherBenefits = 0;
    adults = 1;
    children = 0;
    salary = 0
    dispDiv = document.getElementById("result");
    // reset all buttons on settings page
    for ( var i = 1; i < 18; i++) {
      if (document.getElementById("button-" + i).checked === true) {
        document.getElementById('button-' + i).checked = false;
        document.getElementById('button-' + i).setAttribute("aria-checked", false);
      }
    };

    document.getElementById('button-4').setAttribute("aria-checked", true);
    document.getElementById('button-4').checked = true;

    document.getElementById('button-11').setAttribute("aria-checked", true);
    document.getElementById('button-11').checked = true;

    document.getElementById('button-15').setAttribute("aria-checked", true);
    document.getElementById('button-15').checked = true;


    // select a button for people in household
    // document.getElementById('button-5').checked = true;
    // document.getElementById('button-5').setAttribute("aria-checked", true);

    for (i = 1; i <= 4; i++) {
      d3.select('.person' + i).style('opacity', '0').style('display', 'none');
    }

    // $("#person1").slider('refresh');

    // d3.select('.person1').style('opacity', '1').style('display', 'block');

    // document.getElementById("changeHours1").innerHTML = '0';

    // select buttons for age
    // document.getElementById('button-1').checked = true;
    // document.getElementById('button-1').setAttribute("aria-checked", true);
    // document.getElementById('button-8').checked = true;
    // document.getElementById('button-8').setAttribute("aria-checked", true);
    // document.getElementById('button-12').checked = true;
    // document.getElementById('button-12').setAttribute("aria-checked", true);
    // document.getElementById('button-17').checked = true;
    // document.getElementById('button-17').setAttribute("aria-checked", true);


    // reseting the input values
    document.getElementById('housing-input').value = 0;
    document.getElementById('transport-input').value = 0;
    document.getElementById('food-input').value = 0;
    document.getElementById('alcohol-input').value = 0;
    document.getElementById('clothing-input').value = 0;
    document.getElementById('communication-input').value = 0;
    document.getElementById('leasure-input').value = 0;
    // document.getElementById('restaurant-input').value = 0;
    document.getElementById('holidays-input').value = 0;
    document.getElementById('maintenance-input').value = 0;
    // document.getElementById('health-input').value = 0;
    // document.getElementById('public-input').value = 0;



    // displaying only the settings div
    dispDiv.innerHTML = budgetCalculation();
    d3.select('#saveSettings').style('opacity', '0').style('display', 'none');
    d3.select('#first').style('display', 'inline');
    d3.select('#second').style('display', 'none');
    d3.select('#third').style('display', 'none');
    d3.select('#config').style('opacity', '1').style('display', 'block');
    d3.select('#inputs').style('opacity', '0').style('display', 'none');
    d3.select('#sliders').style('opacity', '0').style('display', 'none');
    d3.select('#result').style('opacity', '0').style('display', 'none');
    d3.select('#under-nlw').style('opacity', '0').style('display', 'none');
    d3.select('#config-text').style('opacity', '1').style('display', 'block');
    d3.select('#text-slider').style('opacity', '0').style('display', 'none');
    d3.select('#text-inputs').style('opacity', '0').style('display', 'none');
    d3.select('#household-contributers').style('opacity', '0').style('display', 'none');
    d3.select('#saveSettings').style('opacity', '0').style('display', 'none');
    d3.select('#previous-next-inputs').style('opacity', '0').style('display', 'none');
    d3.select('#previous-next-sliders').style('opacity', '0').style('display', 'none');



    pymChild.sendHeight();

  })

} else {
  // not-supported
  pymChild.sendHeight();
}
