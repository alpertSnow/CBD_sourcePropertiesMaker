# Input release location
release.loc <- c(634686,3926036,0)
# Input receptors' locations (transposed)
receptor.n <- 19
receptor.loc <- matrix(c(634634.9, 3925912.0, 0,
                         634803.1, 3925908.4, 0,
                         634340.2, 3926151.7, 0,
                         634480.0, 3926150.7, 0,
                         634618.6, 3926149.0, 0,
                         634697.4, 3926148.5, 0,
                         634804.0, 3926146.8, 0,
                         634460.1, 3926285.3, 0,
                         634600.6, 3926281.2, 0,
                         634695.4, 3926281.7, 0,
                         634780.4, 3926259.9, 0,
                         634480.9, 3926381.4, 0,
                         634621.8, 3926383.4, 0,
                         634804.2, 3926373.6, 0,
                         634464.6, 3926520.0, 0,
                         634622.8, 3926495.2, 0,
                         634780.6, 3926490.1, 0,
                         634602.9, 3926630.6, 0,
                         634777.1, 3926630.1, 0), nrow = 3, ncol = receptor.n)
# Input location mapping info
init.loc <- c(634614.5,3925939.8,0)
target.loc <- c(1900,1400,0)

# Calc translate vector, with vertical modification
transVec <- target.loc - init.loc + c(0,0,0.2)

# Translate and modify the vertical distance
releaseLocation <- round(release.loc + transVec,2)
receptorLocation <- round(t(receptor.loc + transVec),2)

# read head, tail and repeatPart
head <- readLines('sourcesProperties-head')
tail <- readLines('sourcesProperties-tail')
repeatPart <- readLines('sourcesProperties-repeatPart')

# write
write(head, 'sourcesProperties')

## write T for release
repeatTemp <- repeatPart
repeatTemp <- gsub('fieldSource', 'TSource', repeatTemp)
locStr <- paste0('(', paste(releaseLocation, collapse = " "), ')')
repeatTemp <- gsub('sourceLocation', locStr, repeatTemp)
repeatTemp <- gsub('fieldName', 'T', repeatTemp)
write(repeatTemp, 'sourcesProperties', append = TRUE)

## write Tr* for receptors
for (i in 1:receptor.n){
        repeatTemp <- repeatPart
        TrName <- paste0("Tr", sprintf("%02d", i))
        repeatTemp <- gsub('fieldSource', paste0(TrName,'Source'), repeatTemp)
        locStr <- paste0('(', paste(receptorLocation[i,], collapse = " "), ')')
        repeatTemp <- gsub('sourceLocation', locStr, repeatTemp)
        repeatTemp <- gsub('fieldName', TrName, repeatTemp)
        write(repeatTemp, 'sourcesProperties', append = TRUE)
}

## write tail
write(tail, 'sourcesProperties', append = TRUE)