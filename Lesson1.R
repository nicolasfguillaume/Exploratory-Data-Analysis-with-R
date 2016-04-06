getwd()
setwd('C:/Users/Nicolas/Downloads')

statesInfo <- read.csv('stateData.csv')

statesInfo

stateSubset <- subset( statesInfo, state.region == 1)
head(stateSubset)
dim(stateSubset)

stateSubsetBracket <- statesInfo[ statesInfo$state.region == 1 ,    ]
head(stateSubsetBracket)
dim(stateSubsetBracket)