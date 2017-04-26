# Simple function to sort the levels of a factor by frequency
sort_factor = function(x, ...)
{
    tmp = sort(table(x), ...)
    factor(x, levels = names(tmp))
}
