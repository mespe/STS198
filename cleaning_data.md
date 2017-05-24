---
output: pdf
geometry: margin=1in
---

# Cleaning data

Here are a few important things to keep in mind when cleaning data.

### Getting data into a useable format

Often data are in a format that is not useable. Examples include:
  
  * numeric data stored in character strings, including:
    - extra characters such as "$" or "," 
    - missing parts (e.g., 97 instead of 1997)
  * dates missing day, month, or year
  * character strings which include multiple variables (e.g., "2010
    Camery 150,000 odom $6000")

Some useful tricks:

  * \texttt{gsub()} allows you to wipe out extra characters: \texttt{gsub(",",
    "", data)} removes an extra comma.
  * \texttt{as.numeric()} converts from character to numeric values. _WARNING: If
    the data contain elements other than 0-9, the result is \texttt{NA}_
  * \texttt{paste()} allows you to combine two character strings together:
    \texttt{paste("2015-", "02-15", sep = "")} results in \texttt{"2015-02-15"}.
  * \texttt{strsplit()} can divide a character string by a character:
    \texttt{strsplit("Hi Bob", " ")} returns \texttt{"Hi"
    "Bob"}. _WARNING: strsplit() returns the results in a list. Use
    do.call(rbind, strsplit(...)) to combine the results._

### Correcting errors

You should always assume that all data have errors (guilty until
proven innocent). These errors can be minor, major, or
catestrophic. You should verify or validate the data prior to any
analysis.

Common issues:

  * Unrealistic values (outliers): some knowledge of what the data
    represent can help identify when a value is out of the realistic
    range. For example, it is unlikely for an car or truck to cost
    less than $5 or over $1 million. 
  * Repeated values: If each row in the data represent an observation,
    repeats in the data can introduce biase in an analysis assuming
    each observation is represented only once.
  * Missing data: Missing data is often the most difficult to
    investigate. Missing data can be represented in the data set as
    \texttt{NA} values, or can be completely missing (i.e., no
    record). Of the two, \texttt{NA} values are better because they
    can provide some clues as to why the data are missing. Therefore,
    avoid discarding \texttt{NA} values by default. \newline Additionally,
    data can be missing:
	- At random: Can be problematic, but generally can be
    excluded without biasing the analysis 
	- Systematicly/non-random: represent a reporting bias
	and can be more problematic. Cannot be excluded from the data without
	biasing an analysis.

Some useful tricks:

  * Plotting is often the easiest way to quickly assess
    outliers. Boxplots show the range of the 25 -- 75\%, as well as
    more extreme values. Density plot allow you to quickly assess
    difference in the distributions of the values. 
  * \texttt{table()} can help with finding duplicates. For example,
    with the state-level election results data, it is unexpected to have results
    for the same state multiple times.
  * \texttt{table()} is also helpful to compare the count within categories, which can
    show you quickly if there are large difference in sample size
    between categories. Combined with \texttt{is.na()}, table can show
    you the number of \texttt{NA} values in each category. For
    example: \texttt{table(is.na(var1), var2)} shows the number of
    \texttt{NA} values in \texttt{var1} by each category of
    \texttt{var2}.
 
