bucket_cal_new.R:
Functions to use trade volume and money through a period of time to get the bucket information(e.g. bucket border).

Class_norm.R:
Functions to classify each trade and put it into different bucket.

get_position_data.R:
Get the bucket position data by calling the functions in bucket_cal_new.R and Class_norm.R.
This file calculates each bucket's position for IF1506 from 20150515 to 20150619.
For example:
SUM_money_class("IF1505","20140417","20140514",5,1)
Get the buckets information by calculate the data from 20140417 to 20140514 for IF1505 which is the time period when IF1505 is the main contract.
5 means to separate into 5 buckets, 1 means 1 buy and 1 sell are counting once.

