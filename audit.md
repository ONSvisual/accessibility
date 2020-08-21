## Data vis accessibility issues



## Unlabelled buttons

Difficulty 2/5

Search buttons are not announced by screenreader

### Templates affected

- LSOA/MSOA map



### Solutions 

Use `aria-label` within the button eg

```html
<button aria-label=“[Full descriptive text for calendar here]” class="btn btn--narrow btn--small datepicker__icon" id="js-start-date" type="button"><span

class="icon icon-calendar--dark-small"></span></button>

```



Instead of `display:none` which hides it from screen readers too use 

```css
.visuallyhidden{
position: absolute; width: 1px; height: 1px; margin: -1px; padding: 0; overflow: hidden;
 clip: rect(0,0,0,0);  border: 0;
}
```

This will ensure that the text is hidden on screen but available to users of assistive technologies.



## Tab order

Difficulty 5/5

iframes cause confusing tab order.

### Templates affected 

Everything flat!

### Solution

DAC says use `focusable="false"` on the SVG

Although https://allyjs.io/tutorials/focusing-in-svg.html suggests using `focusable='false'` and `tabindex=-1`

I'm testing this on safari with voiceover and `focusable="false"` doesn't seem to work. Doing some [more reading](https://allyjs.io/tutorials/focusing-in-svg.html) and it looks like `focusable` is supported differently by different browser. The SVG 2.0 spec says `tabindex=-1` should be also make things non tabbable but again this isn't implemented by all browsers equally. There's also a [whole table](https://allyjs.io/data-tables/focusable.html#svg-element-ident-142) of what different combinations do with different browsers (admittly some are quite out of date e.g. Chrome 55).

I wonder if one possible solution since most data vis are flat charts with no interactive elements is to add `aria-hidden=true` to the iframe instead. Then we could disable that option for interactives that do have form elements. 



Use backend to give screen readable description eg. this interactive has been skipped.



## Non descriptive links

Difficulty 1/5

Social images as buttons do not descriptions

### Templates affected

Baby names

### Solution

Put alt text for the images.



## Unlabelled form fields

Difficulty 4/5

Chosen dropdown input is not labelled

### Templates affected

Many, anything with a dropdown

### Solution

Option 1. d3.insert an label before the option as DAC recommend after the chosen dropdown has been rendered

Option 1b. rewrite the chosen dropdown to include a label field.

Option 2. Use an accessible alternative to chosen dropdown.  

e.g. ONS have an [input box with autocomplete](https://ons-design-system.netlify.app/components/autosuggest/). Here's [input box with autocomplete](https://alphagov.github.io/accessible-autocomplete/examples/form-single.html) from alphagov ([github](https://github.com/alphagov/accessible-autocomplete)).  This has been super seeded by Gov Design System where I can't find autocomplete. Not sure if it ties with event-listeners to control the vis.

[W3 example 3 List with inline autocomplete](https://www.w3.org/TR/wai-aria-practices-1.1/examples/combobox/aria1.1pattern/listbox-combo.html)

[Another example](https://adamsilver.io/articles/building-an-accessible-autocomplete-control/)



Option 3. use label for multiselect and gov

[Multiselect](https://ej2.syncfusion.com/documentation/multi-select/accessibility/) 

[List of accessible custom select dropdowns](https://www.webaxe.org/accessible-custom-select-dropdowns/)



## Inaccessible element

Difficulty 2/5

Using images as buttons but no context

### Template affected

Baby names

### Solution

Use `<button aria-label="copy link to clipboard"> </button>` markup instead.



## Unlabelled buttons that control an input field

Difficulty 1/5

Input not announced when button used to change input, they also lack labels. E.g. - or + buttons around a text field

### Templates affected

Commuting gender gap

### Solution

Additional aria tags `aria-live=polite` which reads the input out when the buttons are used.

Use labels for inputs



Difficulty 1/5

Postcode field doesn't have an indication what it is

### Templates affected

Maps with postcode search

### Solution

Either create a `label` for the input or use `aria-label`. 



## Truncated links

Difficulty 1/5

Download the data buttons chopped off

### Templates affected 

LSOA house price map

### Solution

Ensure pym is working correctly for height



## Graphs are inaccessible

Difficulty 5/5

Screen readers read too much information 

### Templates affected

Everything

### Solution

A few  thoughts on why this might be more complicated than DAC are making out.  They suggest just making the SVG not readable using `aria-hidden='true'`. I think this might be confusing in because if the screen reader read  "Figure X, descriptive title, units" and then goes on to the next thing, would that not be weird?

Second thing is if interactives have some sort of form before, e.g.  choose something, then the SVG shows relevant data. If the SVG is  aria-hidden then the voice reader will still read out the bits before  but nothing about the results. Again I think this would be confusing.

## Interactive Map

Difficulty 5/5

No understandable info about the map given, can't tell what updates when put in a postcode.

### Template affected

Every map

### Solution

Provide accessible alternative. I think we're going to have to code up something that reads out the value once you put the postcode in that's visually hidden. And possibly what quintile you're in. Read out the area name and value as a default (choropleth map). Anything that's a bit more bespoke e.g. deaths map read out the value. 



## Tab order

Difficulty 2/5

Tab order of page need to be changed so it's logical, Top to bottom, left to right

### Templates affected

Commuting gender gap

### Solution

Reorder the page with better flow



## Inaccessible radio buttons

Buttons to choose things don't work with assistive technology

Difficulty 4/5

### Templates affected

Any that use buttons, e.g. multimap

### Solution

They suggest using the [GDS radio buttons](https://design-system.service.gov.uk/components/radios/). Create some custom ones https://www.a11ywithlindsey.com/blog/create-custom-keyboard-accessible-radio-buttons. This guide looks a bit more complicated but more of what we want https://blog.bitsrc.io/customise-radio-buttons-without-compromising-accessibility-b03061b5ba93.

Maybe use treat them like cards https://inclusive-components.design/cards/ 



## Inaccessible tabs

Baby names, tabs buttons for boys/girls were not screen readable.

Difficulty 3/5

### Templates affected

Baby names, multimap

### Solution

Use the [GDS tab pattern](https://design-system.service.gov.uk/components/tabs/).



## Colour palette

Difficulty 2/5

Colours do not meet sufficient colour contrast with surrounding colours on white (line chart)

### Template affected

All line charts

### Solution

Replace chartbuilder palette, use new palette in old charts



## Focus indicator

Difficulty 2/5

Input did not have focus state with sufficient contrast

### Templates affected

Gender commute gap

### Solution

Choose a colour with sufficient contrast



Difficulty 1/5

Zoom buttons do not have focus state

### Template affected

Older map templates

### Solution

Update to latest mapbox CSS



## Low contrast text

Text is below require contrast

Difficulty 1/5

### Templates affected

MSOA house price map on mobile

### Solution

Fix the CSS



## Reflow

When zoomed in, text collides

### Template affected

Gender commute gap

### Solution

Use CSS media queries? Remove text at certain zooms, widths?



## Focus indicator

Ensure all interactive elements have focus

Difficulty 1/5

### Templates affected

Gender commuting gap

### Solution

Ensure CSS has `outline`.



## Status Message

Tell user that error message occurs

Difficulty 2/5

### Templates affected

Gender commuting tool

### Solution 

Implement **role=“status”** on the <div> containing the error so that screen reader users are at least made aware that an error has occurred.

[GDS error summary](https://design-system.service.gov.uk/components/error-summary/) 



## Elements

- Multiselect https://www.w3.org/TR/wai-aria-practices-1.1/examples/listbox/listbox-rearrangeable.html
- Accessible sliders https://www.a11ywithlindsey.com/blog/creating-accessible-range-slider-css

- Toggles (used in pop pyramids) https://a11y-style-guide.com/style-guide/section-forms.html#kssref-forms-toggles



Burn up charts

https://docs.google.com/spreadsheets/d/1y1dK7odpDK31EKRGCNHVIrgFF6-CmZqjYLaWNC0XXAM/edit#gid=0

