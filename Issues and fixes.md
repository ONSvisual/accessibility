# Issues


[TOC]

## Unlabelled buttons

1. Use `aria-label` within the button eg

```html
<button aria-label=“[Full descriptive text for calendar here]” class="btn btn--narrow btn--small datepicker__icon" id="js-start-date" type="button"><span class="icon icon-calendar--dark-small"></span></button>

```
2.
```html
<button type="submit" class="search__button col--md-3 col--lg-3" id="nav-search- submit">
  <span class="visuallyhidden">Search</span>
 	<span class="icon icon-search--light"></span>
</button>

```
Instead of `display:none` which hides it from screen readers too use `.visuallyhidden`. This hides it from the screen, but not from screenreaders and it doesn't affect positioning.
```css
.visuallyhidden{
	position: absolute; 
  width: 1px; 
  height: 1px; 
  margin: -1px; 
  padding: 0; 
  overflow: hidden;
 	clip: rect(0,0,0,0);  
  border: 0;
}
```
This will ensure that the text is hidden on screen but available to users of assistive technologies.

## Focus indicator

Ensure elements e.g. buttons have focus state with sufficient contrast

Focus is normally an orange box-shadow with 3px.

```css
element:focus{
	box-shadow: 0 0 0px 3px #f93;
}
```

## Tab order

Everything that needs to be tabbed must have `tabindex=0`. It'll then follow the DOM order for tab order. It should be set out in a logical flow, top to bottom, left to right. 

Best left to be tested once everything is in place.

## Non descriptive links

Social images as buttons need descriptions

```html
<img alt=“Facebook - share this view (link opens in a new window)” class="socialicon" style="width: 30px; height: 30px;" src="images/facebook.svg">

```

## Unlabelled form fields
Any input needs a label. For Chosen dropdown this is not generated.

Option 1. `d3.insert` an label before the option as DAC recommend after the chosen dropdown has been rendered

```javascript
d3.select('input.chosen-search-input').attr('id','chosensearchinput')
d3.select('div.chosen-search').insert('label','input.chosen-search-input').attr('class','visuallyhidden').attr('for','chosensearchinput').html("Type to select an area")
```

and add another label to the select that's disabled

```javascript
dropdown0.append("div").attr("id","sel0")
				.insert("label","areaselect0")
  			.attr("class", "visuallyhidden")
	 			.attr("for", "areaselect0")
	 			.html("Inactive dropdown element, replaced by custom dropdown")
```

Option 1b. rewrite the chosen dropdown to include a label field.

Option 2. Use an accessible alternative to chosen dropdown.  

e.g. ONS have an [input box with autocomplete](https://ons-design-system.netlify.app/components/autosuggest/). Here's [input box with autocomplete](https://alphagov.github.io/accessible-autocomplete/examples/form-single.html) from alphagov ([github](https://github.com/alphagov/accessible-autocomplete)).  This has been super seeded by Gov Design System where I can't find autocomplete. Not sure if it ties with event-listeners to control the vis.[W3 example 3 List with inline autocomplete](https://www.w3.org/TR/wai-aria-practices-1.1/examples/combobox/aria1.1pattern/listbox-combo.html). [Another example](https://adamsilver.io/articles/building-an-accessible-autocomplete-control/)

Matt has come up with a proposal for multiselect which combines a single select with an area to show selected options. (see Slack channel)

## Inaccessible element

Use of native, semantic html elements are better than elements that behave like something else. E.g. Use `<button aria-label="copy link to clipboard"> </button>` markup for a button. If you are using other html elements, check whether you can use `role` or `aria-role` to tell what it is. Also make sure for other html elements that keyboard events mimic native behaviour e.g. space or enter pushes a button. 

## Unlabelled buttons that control an input field

Additional aria tags `aria-live=assertive` which reads the input out when the buttons are used. E.g. when using plus or minus buttons next to an input. 

## Truncated links

Ensure pym.js is working correctly for height so content is not cut off

## Graphs are inaccessible

DAC Suggests making some or all parts of the chart `aria-hidden=true` if the chart is too complex or too burdensome for the user to hear with a screenreader e.g. axis ticks. This might depend on the surrounding text.

## Interactive Map
Similar to Unlabelled buttons that control an input field. Create a sentence that's visually hidden that reads out the value or responds to the user e.g. postcode input, mouseover, dropdown select. 

## Inaccessible radio buttons
Use [new radio button element](https://onsvisual.github.io/accessibility/radio-button-group.html)?

## Inaccessible tabs
Make sure tabs can be focussed (`tabindex=0`), have focus state and allow for keyboard control (keyCode==13 is enter, and keyCode==32 is space).

## Colour palette
Use new palette in old charts

## Low contrast text
Adjust CSS to ensure text has sufficient contrast

## Reflow
Zoom in up to 400% to check page is still usable at high zoom. Text does not overlap and chart is still readable and useable. 

## Status Message
Implement **role=“status”** on the <div> containing the error so that screen reader users are at least made aware that an error has occurred.

## Keyboard control on cross on chosen dropdown

Add keybinding events to cross once it's generated, this is normally once something is selected from the chosen dropdown.

```javascript
d3.select('abbr').on('keypress',function(evt){
				if(d3.event.keyCode==13 || d3.event.keyCode==32){
					d3.event.preventDefault();
					//clear behaviour
				}
			})
```

