function drawApp () {

  var livingWageBudget = 0;
  var housing = 1500;
  var transport = 500;
  var food = 500;
  var clothing = 250;
  var hobbies = 750;
  var bills = 250;
  var holidays = 5000;
  var kids = 500;
  var yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
  var otherBenefits = 0;
  var adults = 1;
  var children=0;
  var salary=0
  var dispDiv = document.getElementById("result");

  // remove fallback image
  document.getElementById('fallback').remove();

  //calculating the neto anual wage
  function netoCalculation (salary) {
    if (salary > 11500) {
      var tax = (salary - 11500)*0.20;
      var nhs = (salary - 8164)*0.12;
      // salary = salary - tax;
      return (salary - tax- nhs);
    } else if (salary > 8164 && salary <= 11500) {
      var nhs = (salary - 8164)*0.12;
      return (salary - nhs);
    }
    else {
      return salary;
    }
  };

  // hiding sliders for working hours
  d3.select('#config').style('opacity', '1').style('display', 'block');


  for (i = 1; i <= 4; i++) {
    d3.select('.person'+i).style('opacity', '0').style('display', 'none');
  }
  // d3.select('person1')
  d3.select('#sliders').style('opacity', '0').style('display', 'none');
  d3.select('#result').style('opacity', '0').style('display', 'none');
  d3.select('.person1').style('opacity', '1').style('display', 'block');
  $("#person1").slider({
  tooltip: 'hide'
  });
  $('#person1').on('change', function(ev) {

    // how many working days are there in a year, also how will we calculate tax
    oldSalary = ev.value.oldValue*7.50*52;
    newSalary = ev.value.newValue*7.50*52;
    salary = +(salary + netoCalculation(newSalary) - netoCalculation(oldSalary)).toFixed(2);
    document.getElementById("changeHours1").innerHTML = ev.value.newValue;
    console.log(salary);
  });



  // calculating children benefits
  d3.selectAll("input[name='button-children']")
          .on('click', function() {
            children = (+this.value/7)*365.24;
            livingWageBudget = salary + children + otherBenefits;
          });

  // calculating the NLW household income
  d3.selectAll("input[name='button-household']")
          .on('click', function() {
            adults = +this.value;
            salary = 0;
            console.log(salary)
            // livingWageBudget = 0
            // $('.hours').each(function(){
            //   $('.hours').slider('refresh');
            //   // console.log(this.value);
            // });
            // livingWageBudget = salary + children + otherBenefits;
            dispDiv.innerHTML = budgetCalculation();
            for (i = 1; i <= 4; i++) {
              d3.select('.person'+i).style('opacity', '0').style('display', 'none');
              $("#person"+i).slider({
              tooltip: 'hide'
              });
              $("#person"+i).slider('destroy');
              document.getElementById("changeHours" + i).innerHTML = '0';

            }
            // displaying working hour sliders for number of persons selected
            for (i = 1; i <= adults; i++) {

              d3.select('.person'+i).style('opacity', '1').style('display', 'block');
              $("#person"+i).slider({
              tooltip: 'hide'
              });
            }
            // calculating the salary
            $('#person1').on('change', function(ev) {

              // how many working days are there in a year, also how will we calculate tax
              oldSalary = ev.value.oldValue*7.50*52;
              newSalary = ev.value.newValue*7.50*52;
              salary = +(salary + netoCalculation(newSalary) - netoCalculation(oldSalary)).toFixed(2);
              document.getElementById("changeHours1").innerHTML = ev.value.newValue;
              console.log(salary);
            });

            $('#person2').on('change', function(ev) {

              // how many working days are there in a year, also how we wil calculate tax
              oldSalary = ev.value.oldValue*7.50*52;
              newSalary = ev.value.newValue*7.50*52;
              salary = +(salary + netoCalculation(newSalary) - netoCalculation(oldSalary)).toFixed(2);
              document.getElementById("changeHours2").innerHTML = ev.value.newValue;
              // livingWageBudget = salary + children + otherBenefits;
              console.log(+salary.toFixed(2));

            });

            $('#person3').on('change', function(ev) {

              // how many working days are there in a year, also how we wil calculate tax
              oldSalary = ev.value.oldValue*7.50*52;
              newSalary = ev.value.newValue*7.50*52;
              salary = +(salary + netoCalculation(newSalary) - netoCalculation(oldSalary)).toFixed(2);
              document.getElementById("changeHours3").innerHTML = ev.value.newValue;
              // livingWageBudget = salary + children + otherBenefits;
              console.log(salary)

            });

            $('#person4').on('change', function(ev) {

              // how many working days are there in a year, also how we wil calculate tax
              oldSalary = ev.value.oldValue*7.50*52;
              newSalary = ev.value.newValue*7.50*52;
              salary = +(salary + netoCalculation(newSalary) - netoCalculation(oldSalary)).toFixed(2);
              document.getElementById("changeHours4").innerHTML = ev.value.newValue;
              // livingWageBudget = salary + children + otherBenefits;
              console.log(salary)

            });

      });

  // calculating the salary
  // $('#person1').on('change', function(ev) {
  //
  //   // how many working days are there in a year, also how will we calculate tax
  //   oldSalary = ev.value.oldValue*7.50*52;
  //   newSalary = ev.value.newValue*7.50*52;
  //   salary = salary + newSalary - oldSalary;
  //   livingWageBudget = salary + children + otherBenefits;
  //   console.log(livingWageBudget)
  // });
  //
  // $('#person2').on('change', function(ev) {
  //
  //   // how many working days are there in a year, also how we wil calculate tax
  //   oldSalary = ev.value.oldValue*7.50*52;
  //   newSalary = ev.value.newValue*7.50*52;
  //   salary = salary + newSalary - oldSalary;
  //   livingWageBudget = salary + children + otherBenefits;
  //   console.log(livingWageBudget)
  //
  // });
  //
  // $('#person3').on('change', function(ev) {
  //
  //   // how many working days are there in a year, also how we wil calculate tax
  //   oldSalary = ev.value.oldValue*7.50*52;
  //   newSalary = ev.value.newValue*7.50*52;
  //   salary = salary + newSalary - oldSalary;
  //   livingWageBudget = salary + children + otherBenefits;
  // });
  //
  // $('#person4').on('change', function(ev) {
  //
  //   // how many working days are there in a year, also how we wil calculate tax
  //   oldSalary = ev.value.oldValue*7.50*52;
  //   newSalary = ev.value.newValue*7.50*52;
  //   salary = salary + newSalary - oldSalary;
  //   livingWageBudget = salary + children + otherBenefits;
  // });

  // display sliders
  d3.select('#saveSettings').on('click', function() {
    // otherBenefits = +document.getElementById("searchTxt").value.replace('£', '');
    // if (isNaN(otherBenefits)) {
    //   document.getElementById("searchTxt").style.color = 'red';
    //   document.getElementById("searchTxt").value = "Enter a number";
    //   console.log('not number')
    //   d3.select("input[name='searchTxt']").on('click', function() {
    //     document.getElementById("searchTxt").style.color = '#424046';
    //     document.getElementById("searchTxt").value = "£";
    //   })

    // } else {
      // function toggleFixed () {
      // var parentwidth = $(".container-result").width();
      // $("#result").toggleClass("fixed").width(parentwidth);
  // }
      livingWageBudget = salary + children;
      console.log(livingWageBudget);
      d3.select('#config').style('opacity', '0').style('display', 'none');
      d3.select('#sliders').style('opacity', '1').style('display', 'block');
      d3.select('#result').style('opacity', '1').style('display', 'block');
      $("#ex1, #ex2, #ex3, #ex4, #ex5, #ex6, #ex7, #ex8").slider({
      tooltip: 'hide'
      });
      // dispDiv.style.width = "inherit";
      dispDiv.innerHTML = budgetCalculation();
    // }

  });

  // display config
  d3.select('#changeSettings').on('click', function() {
    d3.select('#config').style('opacity', '1').style('display', 'block')
    d3.select('#sliders').style('opacity', '0').style('display', 'none')
    d3.select('#result').style('opacity', '0').style('display', 'none');

  });

  // calculating the figure in the result div
  function budgetCalculation () { if (livingWageBudget - yourSpending > 0) {
              return "<p>Your household could save <span style='color:#206095;'>£"  +  d3.format(",.0f")(Math.abs(livingWageBudget - yourSpending).toFixed(0)) + '</span> per year living on the National Living Wage.</p>';
            } else if (livingWageBudget - yourSpending < 0) {
              return "<p>Your household would need to spend <span style='color:red'>£"  +  d3.format(",.0f")(Math.abs(livingWageBudget - yourSpending).toFixed(0)) + '</span>  less per year living on the National Living Wage.</p>';
            } else {
              return "<p>Your household could save <span style='color:black'>£"  +  d3.format(",.0f")(Math.abs(livingWageBudget - yourSpending).toFixed(0)) + '</span> per year living on the National Living Wage.</p>';
            }
          }

  // Housing slider
  $('#ex1').on('change', function (ev) {
          housing = ev.value.newValue;
          yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
          document.getElementById("changeHousing").innerHTML = '£' + ev.value.newValue;
          dispDiv.innerHTML = budgetCalculation();
      });

  // Transport slider
  $('#ex2').on('change', function (ev) {
          transport = ev.value.newValue;
          yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
          document.getElementById("changeTransport").innerHTML = '£' + ev.value.newValue;
          dispDiv.innerHTML = budgetCalculation();
      });

  // Food slider
  $('#ex3').on('change', function (ev) {
          food = ev.value.newValue;
          yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
          document.getElementById("changeFood").innerHTML = '£' + ev.value.newValue;
          dispDiv.innerHTML = budgetCalculation();
      });

  // Clothing slider
  $('#ex4').on('change', function (ev) {
          clothing = ev.value.newValue;
          yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
          document.getElementById("changeClothing").innerHTML = '£' + ev.value.newValue;
          dispDiv.innerHTML = budgetCalculation();
      });

  // Hobbies slider
  $('#ex5').on('change', function (ev) {
          hobbies = ev.value.newValue;
          yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
          document.getElementById("changeLeasure").innerHTML = '£' + ev.value.newValue;
          dispDiv.innerHTML = budgetCalculation();
      });

  // Bills slider
  $('#ex6').on('change', function (ev) {
          bills = ev.value.newValue;
          yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
          document.getElementById("changeBills").innerHTML = '£' + ev.value.newValue;
          dispDiv.innerHTML = budgetCalculation();
      });

  // Holidays slider
  $('#ex7').on('change', function (ev) {
          holidays = ev.value.newValue;
          yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
          document.getElementById("changeHolidays").innerHTML = '£' + ev.value.newValue;
          dispDiv.innerHTML = budgetCalculation();
      });

  // Kids activities slider
  $('#ex8').on('change', function (ev) {
          kids = ev.value.newValue;
          yourSpending = 12*(housing + transport + food + clothing + hobbies + bills + kids) + holidays;
          document.getElementById("changeKids").innerHTML = '£' + ev.value.newValue;
          dispDiv.innerHTML = budgetCalculation();
      });
    }

if (Modernizr.svg) {
  // supported
  // load data
  // run draw function
  pymchild = new pym.Child({ renderCallback: drawApp });
} else {
  // not-supported
  pymChild.sendheight();
}
