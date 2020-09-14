// ELEMENTS.JS
//--------------------------------------------------------------------------------------------------------------------------------
// Author: Designova.
// Version 1.0 - Initial Release
// Website: http://www.Designova.net 
// Copyright: (C) 2015 
// Do NOT redistribute without permission
// -------------------------------------------------------------------------------------------------------------------------------

/*global $:false */
/*global window: false */

(function(){
  "use strict";


$(function ($) {

     
    $(".dropdown").hover(            
        function() {
            $('.dropdown-menu', this).stop( true, true ).slideDown("fast");
            $(this).toggleClass('open');        
        },
        function() {
            $('.dropdown-menu', this).stop( true, true ).slideUp("fast");
            $(this).toggleClass('open');       
        }
    );


        $(".slider-carousel").owlCarousel({
            autoWidth: false,
            autoHeight: false,
            items: 1,
            loop: true,
            nav: true,
            dots: false,
            navText: false,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:1
                },
                1000:{
                    items:1
                }
            }
        });

        $(".fluid-carousel").owlCarousel({
            autoWidth: false,
            autoHeight: false,
            items: 3,
            loop: true,
            nav: false,
            dots: true,
            navText: false,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:2
                },
                1000:{
                    items:3
                }
            }
        });


        $(".spaced-carousel").owlCarousel({
            autoWidth: false,
            autoHeight: false,
            margin: 30,
            items: 2,
            loop: true,
            nav: false,
            dots: true,
            navText: false,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:2
                },
                1000:{
                    items:2
                }
            }
        });

    $('.carousel .item').each(function(){
      var next = $(this).next();
      if (!next.length) {
        next = $(this).siblings(':first');
      }
      next.children(':first-child').clone().appendTo($(this));

      if (next.next().length>0) {
     
          next.next().children(':first-child').clone().appendTo($(this)).addClass('rightest');
          
      }
      else {
          $(this).siblings(':first').children(':first-child').clone().appendTo($(this));
         
      }
    });


     $('.skills').waypoint(function(direction) {
        // $(".progress-bar").animate({
        //     width: "70%"
        // }, 2500);

        $('.progress-bar').each(function() {
            var progressValue = $(this).attr('data-skills-value');
            $(this).animate({
                            width: progressValue+"%"
                            }, 2500);
        });

    }, { offset: '35%' });



        //Mobile Menu Toggle
        
        $('.nav-mobile-toggle').on('click', function(){
            $('nav').toggleClass('nav-open');
        });
        
        $('.menu li').on('click', function(ev){
            var navItem = $(this),
                e       = ev || window.event;
            
            e.stopPropagation();
            if (navItem.find('ul').length) {
                navItem.toggleClass('active');
            } else {
                navItem.parents('.active').removeClass('active');
            }
        });

// Digits Counter Plugin     

(function($) {
    $.fn.countTo = function(options) {
        // merge the default plugin settings with the custom options
        options = $.extend({}, $.fn.countTo.defaults, options || {});

        // how many times to update the value, and how much to increment the value on each update
        var loops = Math.ceil(options.speed / options.refreshInterval),
            increment = (options.to - options.from) / loops;

        return $(this).each(function() {
            var _this = this,
                loopCount = 0,
                value = options.from,
                interval = setInterval(updateTimer, options.refreshInterval);

            function updateTimer() {
                value += increment;
                loopCount++;
                $(_this).html(value.toFixed(options.decimals));

                if (typeof(options.onUpdate) == 'function') {
                    options.onUpdate.call(_this, value);
                }

                if (loopCount >= loops) {
                    clearInterval(interval);
                    value = options.to;

                    if (typeof(options.onComplete) == 'function') {
                        options.onComplete.call(_this, value);
                    }
                }
            }
        });
    };

    $.fn.countTo.defaults = {
        from: 0,  // the number the element should start at
        to: 100,  // the number the element should end at
        speed: 1000,  // how long it should take to count between the target numbers
        refreshInterval: 100,  // how often the element should be updated
        decimals: 0,  // the number of decimal places to show
        onUpdate: null,  // callback method for every time the element is updated,
        onComplete: null,  // callback method for when the element finishes updating
    };
})(jQuery);   

  //counter init

      $('.elements-counter-wrap').waypoint(function() {

         $(this).css('opacity',1);
        $('.elements-counter').each(function() {
                var $endNum = parseInt($(this).find('.number').text());
                    $(this).find('.number').countTo({
                      from: 0,
                      to: $endNum,
                      speed: 2500,
                      refreshInterval: 40
                    });
                });

    }, { offset: '35%' });






});
// $(function ($)  : ends

})();
//  JSHint wrapper $(function ($)  : ends







  

