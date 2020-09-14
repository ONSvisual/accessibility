# Treemap
[Templated version of treemap](https://onsvisual.github.io/treemap/treemap/index.html)

![alt text](https://user-images.githubusercontent.com/11721913/49382059-4fc8df00-f70d-11e8-8b48-3ae3c2ca0d69.png)

## Data file
Save your data as a `.csv` file in the following format

| id     | parentId | name                         | size  | realsize | percent |
| ------ | -------- | ---------------------------- | ----- | -------- | ------- |
| c0     | NULL     | Total                        | 554.2 | 554.2 | null |
| c1     | c0       | Food and non-alcoholic drink | 58    | 58 | 10.5 |
| c1_1   | c1       | Food                         | 53.3  | 53.3 | null |
| c1_1_1 | c1_1     | Bread, rice and cereals      | 5.1   | 5.1 | null |
| c1_1_2 | c1_1     | Pastry                       | 0.8   | 0.8 | null |
| c1_2   | c1       | Non-alcoholic drink          | 4.7   | 4.7| null |
| c1_2_1 | c1_2     | Coffee                       | 0.9   | 0.9 | null |
| c1_2_2 | c1_2     | Tea                          | 0.5   | 0.5 | null |

```id```
Is a unique id for each item. It is hierarchical in format.

```parentId```
Is the unique id of the parent of each item. 

```name```
The name of each item

```size```
The value of each item. The size of each parent must equal the sum of it's children, the size of each grandparent must be the sum of the parents..... i.e the unrounded values

```realsize```
The value of each item that you wish to be displayed on the treemap. i.e rounded values

```percent```
The percentage of the total of each item. 

## Config

Edit the `config.json` with your favourite text editor.

#### essentials

These contain the main variables which the chart will need and will possibly need changing for each new chart.

```"graphic_data_url": "data.csv"```

Tells the chart the filename for the data.

```"formatNumber": ",.0f"```

Sets the number format for the data.

```"prefix": "£"```

Specifies any text required before the data, e.g £, $

```"suffix": " per week"```

Specifies any text required after the data, e.g  per week, million

```"sourceText":["Family spending 2017, ONS"]```


#### optional

```"ratiovar" : 0.5 ```

Set the ratio of the rectangles in the treemap at different window sizes.

```"margin_sm, margin_md, margin_lg" : [10, 5, 0, 0] ```

Set the ratio of the whole treemap at different window sizes.

```"aspectRatio_sm, aspectRatio_md, aspectRatio_lg" : [4, 4], [1, 1], [16,8] ```

Set the width for the mobile breakpoint. 

```"mobileBreakpoint" : 610 ```

Set the width for the mobile breakpoint. This only affect the number of ticks displayed.
