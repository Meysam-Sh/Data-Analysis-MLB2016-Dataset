# At first, we need to install the required packages and load the MLB2016 dataset 
install.packages("pinnacle.data")
install.packages("odds.converter")

library(pinnacle.data)
library(odds.converter)
library(tidyverse)
library(stringr)
install.packages("dplyr")                # Install dplyr package
library("dplyr")                         # Load dplyr package
data("MLB2016")
?MLB2016

clean_pitcher_names <- function(Pitcher){
  
  Pitcher <- tolower(str_replace_all(Pitcher, ' ', ''))
  InitialLetterPitcher = str_sub(Pitcher, end = 1)
  Pitcher = str_sub(Pitcher, start = 2)
  Pitcher = str_c(InitialLetterPitcher, Pitcher, sep = ' ')
  
  return(Pitcher)
}

# Clean pitching columns
MLB2016 <- MLB2016 %>% 
  mutate(
    AwayStartingPitcher = clean_pitcher_names(AwayStartingPitcher),
    HomeStartingPitcher = clean_pitcher_names(HomeStartingPicher)
  ) %>%
  select(-HomeStartingPicher)


# The final win percentage of the Chicago Cubs at the end of 2016
homeWin <- nrow(MLB2016[MLB2016$HomeTeam == 'Chicago Cubs' & MLB2016$FinalScoreHome > MLB2016$FinalScoreAway, ])
awayWin <- nrow(MLB2016[MLB2016$AwayTeam == 'Chicago Cubs' & MLB2016$FinalScoreHome < MLB2016$FinalScoreAway,])
games <- nrow(MLB2016[MLB2016$HomeTeam == 'Chicago Cubs' | MLB2016$AwayTeam == 'Chicago Cubs',])
games
finalWinPrecentage <- (homeWin+awayWin)/games
print(round(finalWinPrecentage*100,2))


# An object that counts the number of games each pitcher started and the number of wins
PitchersHome <- unique(MLB2016$HomeStartingPitcher)
PitchersAway <- unique(MLB2016$AwayStartingPitcher)
Pitchers <- unique(append(PitchersHome, PitchersAway))
Pitchers
library(tibble)
df<- tibble(Pitcher = character(), Games = double(), Wins=double())
for(i in Pitchers){
  homeWin <- nrow(MLB2016[MLB2016$HomeStartingPitcher == i & MLB2016$FinalScoreHome > MLB2016$FinalScoreAway, ])
  awayWin <- nrow(MLB2016[MLB2016$AwayStartingPitcher == i & MLB2016$FinalScoreHome < MLB2016$FinalScoreAway,])
  games <- nrow(MLB2016[MLB2016$HomeStartingPitcher == i| MLB2016$AwayStartingPitcher == i,])
  print(games)
  df <- df %>% add_case(Pitcher = i,  Games = games, Wins = homeWin+awayWin)
}
df[order(df$Pitcher),]

'''Now, for each game we extract the first and last MoneyUS2 recorded that aren’t NA’s.
Also, we create a binary column indicating if Home Team won or not.
'''
# x<- MLB2016[1,"Lines"]
df<- data.frame(GameID = character(), First_MoneyUS2 = double(), Last_MoneyUS2=double(), WinHomeTeam=numeric())

for(i in 1:nrow(MLB2016)){
  row <- MLB2016[i,]
  x <- row$Lines
  y <- x[[1]]
  z <- y$MoneyUS2
  df <- df %>% add_row(GameID = row$GameID, First_MoneyUS2 = first(na.omit(z)),
                       Last_MoneyUS2=last(na.omit(z)), WinHomeTeam=as.numeric(row$FinalScoreHome>row$FinalScoreAway))
}
















