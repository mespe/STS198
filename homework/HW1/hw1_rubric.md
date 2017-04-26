#Post-data #1 rubric

Total: 20 points (5% of final grade)

###Stakeholders: 6 points

  * Are two unique stakeholders identified? 2 pts
  * Are the answers specifically tailored to each stakeholder? 2 pt
  * Are the answers complete? 1 pt
  * Are the answers well communicated? 1 pt
  
###What are the data: 8 points

  * The answers are correct and well communicated (within reason - some leeway given for
    observational units and repeated measures)? 8 pts
	
	1. How many observations are there? 56225
	2. What are the observational units? Flights between two cities on
       a given day.
	3. How many variables are there? 48
	4. What units are the following variables in?
		+ DepTime: hhmm
		+ DepDelay: minutes
		+ Origin: City (categorical)
		+ ArrDelay15: logical, 0 or 1 (also accept categorical) 
	5. Are the available variables direct measurements of what you are
       interested in? Or are they indirect measurements? Many correct
       answers here - depends on answers to part 1
	6. What scale are the data on? 
		+ For numeric variables, what is the smallest/biggest number?
          Are those reasonable?
			  - DepTime: 1 -- 2400. 
			  - DepDelay: -36 -- 1287. 1287 minutes seems much too high - almost
                a 21.5 hour delay.
	    + For categorical variables, how many categories are there?
          What is the most/least frequent category?
			  - Origin: 90 categories, SFO is most frequent, LWS is
                  the least
			  - ArrDelay15: 2 categories, 0/FALSE most frequent, 1/TRUE
				is least (or NA)
			  - Are data collected at different times or at different
				locations? How many times/locations? Yes, many locations
				throughout CA (90) over the course of a month (Jan 2016)
     7. Are the same observational units measured repeatedly?
		Depends on how they answered what the observational units were.
	 8. Is there variability in the data? Yes - large range in most
		variables, but only included flights arriving in CA.


###Scope: 4 pts

  * Have thought through the complexities of the data (i.e., are not
    overly simplistic - "There are no problems with the data"). 2 pts
  * Recognized there might be missingness in data coverage. 2 pts

###Appendix: 2 points

  * Is the code used to answer the questions included? 1pt
  * Is the code reasonably able to arrive at the answer provided? 1 pt




