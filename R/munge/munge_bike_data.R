# Munging the data for bike fatalities
# FARS data
data_dir = "../../data/"
list.files(paste0(data_dir, "FARS2015/"))

#system2("pdftotext -f 412 -l 434 -layout ../data/FARS2015/USERGUIDE.pdf ../data/FARS2015/PBTYPE.txt")

doc = readLines(paste0(data_dir, "FARS2015/PBTYPE.txt"))

# Find the sections
sect_title = grep("SAS Name: ", doc)

sect_title = c(sect_title, length(doc))
sects = list(length(sect_title) - 1)

for(i in 1:(length(sect_title) - 1)){
    sects[[i]] = doc[sect_title[i]:sect_title[i+1]]
}

names(sects) = gsub("SAS Name: ", "", grep("SAS Name: ", doc, value = TRUE))

sects = lapply(sects, function(x){
    # Subset to just codes
    x = grep("^ +[0-9]", x, value = TRUE)
    x = grep("2014-Later", x, value = TRUE, invert = TRUE)
    x = gsub("^ +", "", x)
    #    browser()
    x = gsub("([0-9][abcd]?) +([A-Za-z])", "\\1####\\2", x)
    do.call(rbind, strsplit(x, "####"))
})

# Replace codes with character explanations
bike = read.csv(paste0(data_dir, "FARS2015/pbtype.csv"), stringsAsFactors = FALSE)

cc = colnames(bike)

replace_code = function(var, replace_tab)
{
    var = as.character(var)
    #browser()
    idx = match(var, replace_tab[,1])
    new_var = replace_tab[,2][idx]
    new_var[is.na(new_var)] = var[is.na(new_var)]
    new_var
}

bike2 = lapply(1:ncol(bike), function(i){
    if(cc[i] %in% names(sects)){
        replace_code(bike[,i], sects[[cc[i]]])
        
    } else {
        bike[,i]
    }
})

bike2 = as.data.frame(bike2, stringsAsFactors = FALSE)
colnames(bike2) = cc

################################################################################
# Pickup state names 

states = readLines(paste0(data_dir, "FARS2015/state_tab.txt"))
states = grep("[0-9]{2} [A-Z]", states, value = TRUE)
states = unlist(strsplit(states, " {6,}"))
states = gsub("^ ", "", states)
states = strsplit(gsub("([0-9]{2}) +", "\\1####", states), "####")
states = do.call(rbind, states)
states[,1] = gsub("0([0-9])", "\\1", states[,1])

bike2$STATE = replace_code(bike2$STATE, states)

bike = bike2
save(bike, file = paste0(data_dir, "bike_FARS.Rda"))

################################################################################
# Distracted drving data


distracted = read.csv(paste0(data_dir, "FARS2015/distract.csv"), stringsAsFactors = FALSE)

doc = readLines(paste0(data_dir, "FARS2015/distracted_tab.txt"))

dist_tab = grep(" +[0-9]+ +", doc, value = TRUE)

dist_tab = gsub("^ +", "", dist_tab)

dist_tab = gsub("([0-9-]+) +", "\\1####", dist_tab[ -1])

dist_tab = do.call(rbind, strsplit(dist_tab, "####"))[,2:3]
dist_tab[,1] = gsub("0([0-9])", "\\1", dist_tab[,1])
# replace the codes

distracted$MDRDSTRD = replace_code(distracted$MDRDSTRD, dist_tab)
distracted$STATE = replace_code(distracted$STATE, states)

################################################################################

disabled = read.csv(paste0(data_dir, "FARS2015/drimpair.csv"), stringsAsFactors = FALSE)

doc = readLines(paste0(data_dir, "FARS2015/disable_tab.txt"))

disable_tab = grep(" +[0-9]+ +", doc, value = TRUE)

disable_tab = gsub("^ +", "", disable_tab)

disable_tab = gsub("([0-9-]+) +", "\\1####", disable_tab[ -1])

disable_tab = do.call(rbind, strsplit(disable_tab, "####"))[,3:4]
disable_tab[,1] = gsub("0([0-9])", "\\1", disable_tab[,1])

disabled$DRIMPAIR = replace_code(disabled$DRIMPAIR, disable_tab)

## There is an issue in the data - records don't line up
# no time to fix
idx = match(distracted$ST_CASE, disabled$ST_CASE)
distracted$DRIMPAIR = disabled$DRIMPAIR[idx]

save(distracted, file = paste0(data_dir, "distracted.Rda"))

# # Want to 

# library(ggplot2)

# ggplot(distracted, aes(x = MDRDSTRD, group = MDRDSTRD == "Not Distracted" )) +
#     geom_bar() +
#     labs(x = "blag", title = "dumb") +
#     theme(plot.title=element_text(hjust=0.5))



