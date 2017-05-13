

plotMap = function(data, states)
{
    require(fiftystater)
    require(ggplot2)

    # if(length(data) == 0 || !is.vector(data))
    #     stop("Must provide data vector")
    # if(length(states) == 0 || !is.vector(states))
    #     stop("Must provide state vector")

    map.data = data.frame(x = data, state = tolower(states), stringsAsFactors = FALSE)
    if(any(states == "" | states == "--")){
        map.data = subset(map.data, !state %in% c("","--"))
        warning("Excluding data where state is not specified")
    }

    if(all(nchar(map.data$state) == 2)){
        i = match(map.data$state, tolower(state.abb))
        map.data$state = tolower(state.name)[i]
    }
    
    ggplot(data = map.data, aes(map_id = state)) +
        geom_map(aes(fill = x), map = fifty_states) +
        expand_limits(x = fifty_states$long, y = fifty_states$lat) +
        coord_map() +
        theme_bw() +
        fifty_states_inset_boxes() 
}
