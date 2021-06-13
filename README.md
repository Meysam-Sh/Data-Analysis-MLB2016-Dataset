This a simple data analysis of MLB2016 dataset in R using the pinnacle.data package from CRAN. pinnacle.data contains a snapshot of odds over time in a subset of Pinnacle’s sports betting markets. The MLB2016 dataset is part of this package. I explore the MLB2016 as follows by:

1. computing the final win percentage of the Chicago Cubs at the end of 2016

2. creating an object that counts the number of games each pitcher started and the number of wins

3. for each game, I extract the first and last MoneyUS2 recorded that aren’t NA’s. Also, I create a binary column indicating if Home Team won or not.


