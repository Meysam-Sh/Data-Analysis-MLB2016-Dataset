This a simple data analysis of MLB2016 dataset in R using the pinnacle.data package from CRAN. pinnacle.data contains a snapshot of odds over time in a subset of Pinnacle’s sports betting markets. The MLB2016 dataset is part of this package. I explore as follows by:

Computing the final win percentage of the Chicago Cubs at the end of 2016

Creating an object that counts the number of games each pitcher started and the number of wins

For each game, I extract the first and last MoneyUS2 recorded that aren’t NA’s. Also, I create a binary column indicating if Home Team won or not.


