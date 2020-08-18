## Data vis accessibility issues



## Unlabelled buttons

Difficulty 2/5

Buttons are not announced by screenreader

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

Option 2. Use an accessible alternative to chosen dropdown.  

e.g. Here's [input box with autocomplete](https://alphagov.github.io/accessible-autocomplete/examples/form-single.html ) from alphagov. This has been super seeded by Gov Design System where I can't find autocomplete. Not sure if it ties with event-listeners to control the vis.

Option 3. use label for multiselect and gov

[Multiselect](https://ej2.syncfusion.com/documentation/multi-select/accessibility/) 

[List of accessible custom select dropdowns](https://www.webaxe.org/accessible-custom-select-dropdowns/)



## Inaccessible element

Difficulty 2/5

Using images as buttons but no cont

ext

### Template affected

Baby names

### Solution

Use `<button aria-label="copy link to clipboard"> </button>` markup instead.



## Unlabelled buttons that control an input field

Difficulty 1/5

Input not announced when button used to change input, they also lack labels

### Templates affected

Commuting gender gap

### Solution

Additional aria tags `aria-live` which reads the input out when the buttons are used.

Use labels for inputs



## Truncated links



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

Provide accessible alternative