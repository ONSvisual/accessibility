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
Instead of `display:none` which hides it from screen readers too use `.visuallyhidden`
```css
.visuallyhidden{
position: absolute; width: 1px; height: 1px; margin: -1px; padding: 0; overflow: hidden;
 clip: rect(0,0,0,0);  border: 0;
}
```
This will ensure that the text is hidden on screen but available to users of assistive technologies.

## Tab order

Everything that needs to be tabbed must have `tabindex=0`. It should be set out in a logical flow, top to bottom, left to right

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

Option 1b. rewrite the chosen dropdown to include a label field.

Option 2. Use an accessible alternative to chosen dropdown.  

e.g. ONS have an [input box with autocomplete](https://ons-design-system.netlify.app/components/autosuggest/). Here's [input box with autocomplete](https://alphagov.github.io/accessible-autocomplete/examples/form-single.html) from alphagov ([github](https://github.com/alphagov/accessible-autocomplete)).  This has been super seeded by Gov Design System where I can't find autocomplete. Not sure if it ties with event-listeners to control the vis.[W3 example 3 List with inline autocomplete](https://www.w3.org/TR/wai-aria-practices-1.1/examples/combobox/aria1.1pattern/listbox-combo.html). [Another example](https://adamsilver.io/articles/building-an-accessible-autocomplete-control/)

Matt has come up with a proposal for multiselect which combines a single select with an area to show selected options. (see Slack channel)

## Inaccessible element

A button is not marked up as a button.

Use `<button aria-label="copy link to clipboard"> </button>` markup instead.

## Unlabelled buttons that control an input field

Additional aria tags `aria-live=assertive` which reads the input out when the buttons are used. E.g. when using plus or minus buttons next to an input. 

Use labels for inputs

## Truncated links

Ensure pym.js is working correctly for height

## Graphs are inaccessible

DAC Suggests making some or all parts of the chart `aria-hidden=true` but this might depend on the surrounding text.

## Interactive Map
Similar to Unlabelled buttons that control an input field. I think we're going to have to code up something that reads out the value once you put the postcode in that's visually hidden.

## Inaccessible radio buttons
Use [new radio button element](https://onsvisual.github.io/accessibility/radio-button-group.html).

## Inaccessible tabs
Make sure tabs can be focussed (`tabindex=0`), have focus state and allow for keyboard control (keyCode==13 is enter, and keyCode==32 is space).

## Colour palette
Use new palette in old charts

## Focus indicator
Ensure buttons have focus state with sufficient contrast

## Low contrast text
Adjust CSS to ensure text has sufficient contrast

## Reflow
Zoom in up to 400% to check page is still usable at high zoom. Use CSS media queries? Remove text at certain zooms, widths?

## Status Message
Implement **role=“status”** on the <div> containing the error so that screen reader users are at least made aware that an error has occurred.

### Keyboard control on cross on chosen dropdown

Add keybinding events to cross once it's generated, this is normally once something is selected from the chosen dropdown.

```javascript
d3.select('abbr').on('keypress',function(evt){
				if(d3.event.keyCode==13 || d3.event.keyCode==32){
					d3.event.preventDefault();
					//clear behaviour
				}
			})
```

