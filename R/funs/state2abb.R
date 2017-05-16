state2abb = function(stateName)
{
    state.abb[match(tolower(stateName), tolower(state.name))]
}

abb2state = function(stateAbb)
{
    state.abb[match(tolower(stateAbb), tolower(state.abb))]
}
