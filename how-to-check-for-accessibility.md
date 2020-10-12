# How to check for accessibility

[Text content](#text-content)

[Images, video and audio content](link)

[Interactive tools and transactions](link)

[Technology](link)

[HTML checks](link)

[Screen reader](link)

[JavaScript](link)

[Tools](link)

[How to use VoiceOver](link)


## Text content

### Check you’re using proper headings

In Web Developer go to 'Information > View Document Outline' to view the heading structure of the page.

Heading should follow a logical structure, `H1` to `H6`

### Check pages are usable when stylesheets are disabled

In Web Developer, go to 'CSS - Disable All Styles' to view the page without styles.

The page should still be understandable and usable without styles.

### Check that instructions are styled properly

Make sure you're not using instructions that rely on the users ability to see the page, such as 'Below the green button'.

### Check that links make sense

Taken out of context, links should convey enough information to understand where they will take the user. Text like 'Click here' or 'More information' would need more description.

### Check that pages have good titles

The page title should accurately describe the page you're on. For example, 'Apply for child benefits - GOV.UK' is better than just 'Application'.


## Images, video and audio content

### Check any images have a description

Check that non-decorative images have appropriate alternative (`alt`) text.

Decorative images don't need description. Put `alt=''` on those.

### Check any video or audio content is properly described

Audio and video should have text equivalent, such as captions and transcripts.


## Interactive tools and transactions

### Check form fields are marked up appropriately

Use `<fieldset>` and `<legend>` around groups of form fields.

Make sure all form inputs have a label.

Buttons that don’t have text should have a visually hidden text for screen readers.

### Check it’s clear what information users need to provide

As a general rule, field labels should be specific. Avoid vague labels.

### Check form elements are consistent across your website

Check you're using the correct colour or text and that it's consistenly applied.

Should the submit button be green and say 'Submit' or blue and say 'Go'? Refer to a style guide if there is one.

### Check that any error messages are helpful

Describe the issue and offer information on how to correct the error. Something like ‘You cannot enter a date in the future - please enter a past date’ is more helpful than 'invalid date'.

### Check that form elements behave as expected

Check if anything unexpected happens while interacting with the form, such as the appearance of a popup, changing of focused elements, etc.


## Technology

### Tests using a mobile or tablet device

Check different screen sizes and page orientation for any visual issues.

Make sure navigation does not require more than one finger and interactions do not rely on complex motions.

### Navigating just using a keyboard

Make sure that all keyboard focusable elements on the page have a clearly visible outline or style.

Check that the tab order is logical (top to bottom, left to right) and that nothing unexpected happens while tabbing through the page.

Check that all form interactions can be completed with the keyboard, such as 'Enter' to submit or select, or 'esc' to leave an interaction.

### Checking content is usable when zoomed in or magnified

Check if you can still use the page on 300% - 400% zoom or with text enlarged.

Chrome offers only zoom, while Firefox has a 'Zoom text only' option.

### Colour contrast

Check for text contrast issues. This includes any buttons and navigational elements.

Use the WAVE Tool to check colour contrast, or [Contrast Checker](https://contrastchecker.com/).

Firefox & Chrome also have contrast checkers in their respective dev tools.

### Pop-ups and interactive or flashing content

Check that users can disable animated or moving content.

Make sure no content plays automatically on page load.

Try to provide alternatives to interactive maps.

## HTML checks

Make sure your HTML is valid. Run a validator on your code and fix any issues.

Use [Validity Chrome Extension](https://chrome.google.com/webstore/detail/validity/bbicmjjbohdfglopkidebfccilipgeif?hl=en-GB) or in Web Developer, you can use 'Tools > Validate Local HTML'

## Screen reader

### aria-hidden

Use `aria-hidden="true"` surgically where there are sections that most likely won’t make sense to a screen reader. This might include font icons, small elements which purely serve a visual purpose. Avoid hiding large parts of a user interface. When hiding a graphic SVG visualisation, briefly describe the visualisation that’s been hidden.

### Announcing results

Announce data results from interacting with the visualisation. In most cases, the results are rendered into various containers in the DOM. One solution is to build up a sensible summary of the results and injecting it into a `<p>` element with a `role="alert"`

## JavaScript

### Non-JS alternatives

The page should ideally work without JS. At the very least provide a non-js message briefly describing the page and which things aren't working.

### Console Log

The console log should be free of any JS errors or verbose console logs. Although not a part of any accessibility criteria, this indicates clean, bug-free code.


## Tools

An excellent dev tool for Firefox and Chrome is Web Developer:

[Web Developer for Chrome](https://chrome.google.com/webstore/detail/web-developer/bfbameneiokkgbdmiekhjnmfkcnldhhm)

[Web Developer for Firefox](https://addons.mozilla.org/en-GB/firefox/addon/web-developer/)

### Accessibility evaluation tools:

For Chrome:

[WAVE Evaluation Tool](https://chrome.google.com/webstore/detail/wave-evaluation-tool/jbbplnpkjmmeebjpijfedlgcdilocofh)

[axe - Web Accessibility Testing](https://chrome.google.com/webstore/detail/axe-web-accessibility-tes/lhdoppojpmngadmnindnejefpokejbdd)

[Lighthouse](https://developers.google.com/web/tools/lighthouse#devtools)

For Firefox:

[WAVE Accessibility Extension](https://addons.mozilla.org/en-GB/firefox/addon/wave-accessibility-tool/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)

[axe - Web Accessibility Testing](https://addons.mozilla.org/en-GB/firefox/addon/axe-devtools/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)

[Accessibility Inspector](https://developer.mozilla.org/en-US/docs/Tools/Accessibility_inspector)

## How to use voiceover

Use voiceover for mac, cmd + f5

Ctrl + Alt + shift + up/down = leave/enter group

Ctrl + Alt + left/right = next item

Ctrl + Alt + space = click

[VoiceOver Keyboard Shortcuts](https://dequeuniversity.com/screenreaders/voiceover-keyboard-shortcuts)

Sources:

[GDS - Doing a basic accessibility check if you cannot do a detailed one](https://www.gov.uk/government/publications/doing-a-basic-accessibility-check-if-you-cant-do-a-detailed-one/doing-a-basic-accessibility-check-if-you-cant-do-a-detailed-one)
