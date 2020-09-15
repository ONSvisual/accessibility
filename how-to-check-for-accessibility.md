# How to check for accessibility

## How to use voiceover

Use voiceover for mac, cmd + f5

Ctrl + Alt + shift + up/down = leave/enter group

Ctrl + Alt + left/right = next item

Ctrl + Alt + space = click

Chrome has [lighthouse](https://developers.google.com/web/tools/lighthouse) to do automated checking

## Checklist

Do inputs have labels?

Groups of inputs are inside a fieldset?

Fieldsets have legends?

Links are described?

Buttons/imgs have labels

Tab order is logical (top to bottom, left to right) TIdeally, tabindex should be =0 and elements reordered in the DOM

Interactive elements have keyboard focus states, have high enough contrast 3:1?

Contrast on text is sufficient (Firefox & Chrome have contrast checkers in dev tools) 

Text updates and is read to you when something changes

Pym is right height

Page can be navigated by keyboard

Text/elements flows even when on high zoom?

HTML element has a [lang] attribute

Is minimum-scale=1, maximum-scale=1, user-scalable=no" removed from viewport
