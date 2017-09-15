---
output: pdf
geometry: margin=1in
---

# Post-data 7 Rubric

*STS198 Spring 2017*

**Total points: 20**

### Prompt
>
> **Cleaning and validating data:**
>
>A major aspect of every data analysis project in the real world involves cleaning and verification/validation of the data. Without this step, any analysis is of questionable accuracy.
>
>You task this week is to clean and validate some columns in the craigslist.org apartment data. The data can be loaded with:
>
>Specifically, you are tasked with cleaning and validating these columns:
>
>  * price
>  * BR (bedrooms)
>  * Ba (bathrooms)
>  * lat (latitude)
>  * long (longitude)

>You will need to (1) convert these to a useful format (numeric), (2) check for extreme or unreasonable values, and (3) explore if missing values are missing at random or systematically.
>
>Bonus: create 2 new columns, each logical. One should be TRUE if cats are allowed, and the other should be TRUE if dogs are allowed.
>
>Format: Technical report outlining the issues you found with each column, what you did to correct the issue, and if there are outstanding issues (including missing values).
>
>Audience: Managerial/technical
>


### Content

For each of the 5 columns (lat/long OK to be handled together): 

Criteria | Points
---- | ----:
Converted to numeric  | 1
Checked for reasonableness of values\* | 1
Investigated NA values for patterns\*\* | 1
| 
**Subtotal** | 15
Bonus - add cat/dog column | 1

\* I made it clear on Piazza that they should be using plots to
actually look at the data. They do not need to present a plot for each
column *per se* (due to space limitations), but I would expect this
report to have at least **2 plots minimum**. Tables are OK for data that
are not plotted. No credit if they do not provide evidence for their
conclusions about whether there are extreme values that might
influence future analysis or not.

\*\* I made it extraordinarily clear in class and on Piazza that they
always should investigate NA. They should have a sense of whether the
NAs are random or if there is a systematic pattern.

### Completeness

Criteria | Points
---- | ----:
Includes code as Appendix | 2  
Within page limit (see prompt) | 2  
Well-written, free of grammar and spelling errors | 1
| 
**Subtotal** | 5


