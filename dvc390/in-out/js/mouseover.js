$.fn.triggerSVGEvent = function(eventName) {
		 var event = document.createEvent('SVGEvents');
		 event.initEvent(eventName,true,true);
		 this[0].dispatchEvent(event);
		 return $(this);
};
