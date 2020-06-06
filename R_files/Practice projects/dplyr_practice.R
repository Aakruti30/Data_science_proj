library(hflights)
str(hflights)
?hflights

# 'data.frame':	227496 obs. of  21 variables:
#   $ Year             : int  2011 2011 2011 2011 2011 2011 2011 2011 2011 2011 ...
# $ Month            : int  1 1 1 1 1 1 1 1 1 1 ...
# $ DayofMonth       : int  1 2 3 4 5 6 7 8 9 10 ...
# $ DayOfWeek        : int  6 7 1 2 3 4 5 6 7 1 ...
# $ DepTime          : int  1400 1401 1352 1403 1405 1359 1359 1355 1443 1443 ...
# $ ArrTime          : int  1500 1501 1502 1513 1507 1503 1509 1454 1554 1553 ...
# $ UniqueCarrier    : chr  "AA" "AA" "AA" "AA" ...
# $ FlightNum        : int  428 428 428 428 428 428 428 428 428 428 ...
# $ TailNum          : chr  "N576AA" "N557AA" "N541AA" "N403AA" ...
# $ ActualElapsedTime: int  60 60 70 70 62 64 70 59 71 70 ...
# $ AirTime          : int  40 45 48 39 44 45 43 40 41 45 ...
# $ ArrDelay         : int  -10 -9 -8 3 -3 -7 -1 -16 44 43 ...
# $ DepDelay         : int  0 1 -8 3 5 -1 -1 -5 43 43 ...
# $ Origin           : chr  "IAH" "IAH" "IAH" "IAH" ...
# $ Dest             : chr  "DFW" "DFW" "DFW" "DFW" ...
# $ Distance         : int  224 224 224 224 224 224 224 224 224 224 ...
# $ TaxiIn           : int  7 6 5 9 9 6 12 7 8 6 ...
# $ TaxiOut          : int  13 9 17 22 9 13 15 12 22 19 ...
# $ Cancelled        : int  0 0 0 0 0 0 0 0 0 0 ...
# $ CancellationCode : chr  "" "" "" "" ...
# $ Diverted         : int  0 0 0 0 0 0 0 0 0 0 ...

library(dplyr)
View(hflights)
hflights$UniqueCarrier <- as.factor(hflights$UniqueCarrier)
str(hflights)

hflights1 <- select(filter(hflights,UniqueCarrier == "AA"),UniqueCarrier,ArrDelay) 
hflights1

summarise(hflights1,mean_arrDelay = mean(hflights1$ArrDelay,na.rm = T))

#     mean_arrDelay
# 1     0.8917558

tbl_df(select(hflights, UniqueCarrier, ActualElapsedTime, ArrDelay, AirTime, DepDelay))

# # A tibble: 227,496 x 5
# UniqueCarrier ActualElapsedTime ArrDelay AirTime DepDelay
# <fct>                     <int>    <int>   <int>    <int>
#   1 AA                           60      -10      40        0
# 2 AA                           60       -9      45        1
# 3 AA                           70       -8      48       -8
# 4 AA                           70        3      39        3
# 5 AA                           62       -3      44        5
# 6 AA                           64       -7      45       -1
# 7 AA                           70       -1      43       -1
# 8 AA                           59      -16      40       -5
# 9 AA                           71       44      41       43
# 10 AA                           70       43      45       43
# ... with 227,486 more rows

tbl_df(select(hflights, Origin : Cancelled))

# A tibble: 227,496 x 6
# Origin Dest  Distance TaxiIn TaxiOut Cancelled
# <chr>  <chr>    <int>  <int>   <int>     <int>
#   1 IAH    DFW        224      7      13         0
# 2 IAH    DFW        224      6       9         0
# 3 IAH    DFW        224      5      17         0
# 4 IAH    DFW        224      9      22         0
# 5 IAH    DFW        224      9       9         0
# 6 IAH    DFW        224      6      13         0
# 7 IAH    DFW        224     12      15         0
# 8 IAH    DFW        224      7      12         0
# 9 IAH    DFW        224      8      22         0
# 10 IAH    DFW        224      6      19         0
# ... with 227,486 more rows

tbl_df(select(hflights, Year : DayOfWeek, ArrDelay : Diverted))

# A tibble: 227,496 x 14
# Year Month DayofMonth DayOfWeek ArrDelay DepDelay Origin Dest  Distance TaxiIn TaxiOut Cancelled CancellationCode
# <int> <int>      <int>     <int>    <int>    <int> <chr>  <chr>    <int>  <int>   <int>     <int> <chr>           
#   1  2011     1          1         6      -10        0 IAH    DFW        224      7      13         0 ""              
# 2  2011     1          2         7       -9        1 IAH    DFW        224      6       9         0 ""              
# 3  2011     1          3         1       -8       -8 IAH    DFW        224      5      17         0 ""              
# 4  2011     1          4         2        3        3 IAH    DFW        224      9      22         0 ""              
# 5  2011     1          5         3       -3        5 IAH    DFW        224      9       9         0 ""              
# 6  2011     1          6         4       -7       -1 IAH    DFW        224      6      13         0 ""              
# 7  2011     1          7         5       -1       -1 IAH    DFW        224     12      15         0 ""              
# 8  2011     1          8         6      -16       -5 IAH    DFW        224      7      12         0 ""              
# 9  2011     1          9         7       44       43 IAH    DFW        224      8      22         0 ""              
# 10  2011     1         10         1       43       43 IAH    DFW        224      6      19         0 ""              
# ... with 227,486 more rows, and 1 more variable: Diverted <int>

tbl_df(select(hflights, ends_with("Delay")))

# A tibble: 227,496 x 2
# ArrDelay DepDelay
# <int>    <int>
#   1      -10        0
# 2       -9        1
# 3       -8       -8
# 4        3        3
# 5       -3        5
# 6       -7       -1
# 7       -1       -1
# 8      -16       -5
# 9       44       43
# 10       43       43
# ... with 227,486 more rows

tbl_df(select(hflights,one_of("UniqueCarrier", "FlightNum", "TailNum", "Cancelled", "CancellationCode")))

# A tibble: 227,496 x 5
# UniqueCarrier FlightNum TailNum Cancelled CancellationCode
# <fct>             <int> <chr>       <int> <chr>           
#   1 AA                  428 N576AA          0 ""              
# 2 AA                  428 N557AA          0 ""              
# 3 AA                  428 N541AA          0 ""              
# 4 AA                  428 N403AA          0 ""              
# 5 AA                  428 N492AA          0 ""              
# 6 AA                  428 N262AA          0 ""              
# 7 AA                  428 N493AA          0 ""              
# 8 AA                  428 N477AA          0 ""              
# 9 AA                  428 N476AA          0 ""              
# 10 AA                  428 N504AA          0 ""              
# ... with 227,486 more rows

tbl_df(mutate(hflights,g = ActualElapsedTime - AirTime))

# A tibble: 227,496 x 22
# Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin Dest  Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted     g
# <int> <int>      <int>     <int>   <int>   <int> <fct>             <int> <chr>               <int>   <int>    <int>    <int> <chr>  <chr>    <int>  <int>   <int>     <int> <chr>               <int> <int>
#   1  2011     1          1         6    1400    1500 AA                  428 N576AA                 60      40      -10        0 IAH    DFW        224      7      13         0 ""                      0    20
# 2  2011     1          2         7    1401    1501 AA                  428 N557AA                 60      45       -9        1 IAH    DFW        224      6       9         0 ""                      0    15
# 3  2011     1          3         1    1352    1502 AA                  428 N541AA                 70      48       -8       -8 IAH    DFW        224      5      17         0 ""                      0    22
# 4  2011     1          4         2    1403    1513 AA                  428 N403AA                 70      39        3        3 IAH    DFW        224      9      22         0 ""                      0    31
# 5  2011     1          5         3    1405    1507 AA                  428 N492AA                 62      44       -3        5 IAH    DFW        224      9       9         0 ""                      0    18
# 6  2011     1          6         4    1359    1503 AA                  428 N262AA                 64      45       -7       -1 IAH    DFW        224      6      13         0 ""                      0    19
# 7  2011     1          7         5    1359    1509 AA                  428 N493AA                 70      43       -1       -1 IAH    DFW        224     12      15         0 ""                      0    27
# 8  2011     1          8         6    1355    1454 AA                  428 N477AA                 59      40      -16       -5 IAH    DFW        224      7      12         0 ""                      0    19
# 9  2011     1          9         7    1443    1554 AA                  428 N476AA                 71      41       44       43 IAH    DFW        224      8      22         0 ""                      0    30
# 10  2011     1         10         1    1443    1553 AA                  428 N504AA                 70      45       43       43 IAH    DFW        224      6      19         0 ""                      0    25
# ... with 227,486 more rows

f1 <- tbl_df(filter(hflights, Distance >= 3000))
f1
# A tibble: 527 x 21
# Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum TailNum ActualElapsedTi~ AirTime ArrDelay DepDelay Origin Dest  Distance TaxiIn TaxiOut Cancelled CancellationCode
# <int> <int>      <int>     <int>   <int>   <int> <fct>             <int> <chr>              <int>   <int>    <int>    <int> <chr>  <chr>    <int>  <int>   <int>     <int> <chr>           
#   1  2011     1         31         1     924    1413 CO                    1 N69063               529     492       23       -1 IAH    HNL       3904      6      31         0 ""              
# 2  2011     1         30         7     925    1410 CO                    1 N76064               525     493       20        0 IAH    HNL       3904     13      19         0 ""              
# 3  2011     1         29         6    1045    1445 CO                    1 N69063               480     459       55       80 IAH    HNL       3904      4      17         0 ""              
# 4  2011     1         28         5    1516    1916 CO                    1 N77066               480     463      326      351 IAH    HNL       3904      7      10         0 ""              
# 5  2011     1         27         4     950    1344 CO                    1 N76055               474     455       -6       25 IAH    HNL       3904      4      15         0 ""              
# 6  2011     1         26         3     944    1350 CO                    1 N76065               486     471        0       19 IAH    HNL       3904      5      10         0 ""              
# 7  2011     1         25         2     924    1337 CO                    1 N68061               493     473      -13       -1 IAH    HNL       3904      5      15         0 ""              
# 8  2011     1         24         1    1144    1605 CO                    1 N76064               501     464      135      139 IAH    HNL       3904      7      30         0 ""              
# 9  2011     1         23         7     926    1335 CO                    1 N76065               489     466      -15        1 IAH    HNL       3904      6      17         0 ""              
# 10  2011     1         22         6     942    1340 CO                    1 N69063               478     465      -10       17 IAH    HNL       3904      3      10         0 ""              
# ... with 517 more rows, and 1 more variable: Diverted <int>

f3 <- tbl_Df(filter(hflights, (TaxiIn + TaxiOut) > AirTime))
f3

# Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin Dest Distance TaxiIn TaxiOut Cancelled
# 1  2011     1         24         1     731     904            AA       460  N545AA                93      42       29       11    IAH  DFW      224     14      37         0
# 2  2011     1         30         7    1959    2132            AA       533  N455AA                93      43       12       -6    IAH  DFW      224     10      40         0
# 3  2011     1         24         1    1621    1749            AA      1121  N484AA                88      43        4       -9    IAH  DFW      224     10      35         0
# 4  2011     1         10         1     941    1113            AA      1436  N591AA                92      45       48       31    IAH  DFW      224     27      20         0
# 5  2011     1         31         1    1301    1356            CO       241  N14629                55      27       -2       -4    IAH  AUS      140      5      23         0
# 6  2011     1         31         1    2113    2215            CO      1533  N72405                62      30       20       13    IAH  AUS      140      7      25         0
# 7  2011     1         31         1    1434    1539            CO      1541  N16646                65      30       15        4    IAH  AUS      140      5      30         0
# 8  2011     1         31         1     900    1006            CO      1583  N36207                66      32       10        0    IAH  AUS      140      5      29         0
# 9  2011     1         30         7    1304    1408            CO       241  N14645                64      31       10       -1    IAH  AUS      140      6      27         0
# 10 2011     1         30         7    2004    2128            CO       423  N16632                84      40       54       39    IAH  MSY      305     10      34         0
# 11 2011     1         30         7    1912    2032            CO       479  N73276                80      37       16        2    IAH  SAT      191      6      37         0
# 12 2011     1         30         7    1141    1251            CO       741  N76523                70      30       15       -4    IAH  AUS      140      4      36         0
# 13 2011     1         30         7    1922    2032            CO      1411  N38268                70      30       30       17    IAH  AUS      140      6      34         0
# 14 2011     1         30         7    1813    1914            CO      1558  N77295                61      30       23       18    IAH  AUS      140      6      25         0
# 15 2011     1         30         7    1038    1214            CO      1823  N14653                96      44       35        3    IAH  MSY      305      3      49         0
# 16 2011     1         26         3    1533    1629            CO        35  N19638                56      27        1       -2    IAH  AUS      140     12      17         0
# 17 2011     1         26         3    1910    2012            CO      1411  N33266                62      29       10        5    IAH  AUS      140      8      25         0
# 18 2011     1         25         2    1259    1401            CO       241  N32626                62      29        3       -6    IAH  AUS      140      6      27         0
# 19 2011     1         25         2    2101    2158            CO      1533  N32404                57      28        3        1    IAH  AUS      140      7      22         0
# 20 2011     1         25         2    1427    1530            CO      1541  N16617                63      29        6       -3    IAH  AUS      140      5      29         0
# 21 2011     1         24         1    1322    1428            CO       241  N24633                66      28       30       17    IAH  AUS      140      5      33         0
# 22 2011     1         24         1    1153    1253            CO       741  N36207                60      29       12        8    IAH  AUS      140      5      26         0
# 23 2011     1         24         1    1939    2059            CO      1411  N73275                80      28       57       34    IAH  AUS      140      6      46         0
# 24 2011     1         24         1    1429    1531            CO      1541  N32626                62      28        7       -1    IAH  AUS      140      7      27         0
# 25 2011     1         24         1     930    1044            CO      1583  N53441                74      28       48       30    IAH  AUS      140      8      38         0
# 26 2011     1         23         7    1301    1409            CO       241  N46625                68      30       11       -4    IAH  AUS      140      8      30         0
# 27 2011     1         23         7    1551    1725            CO      1787  N59630                94      42       18       -4    IAH  DFW      224      9      43         0
# 28 2011     1         22         6     854     958            CO      1583  N14242                64      29        7       -6    IAH  AUS      140      5      30         0
# 29 2011     1         21         5    1301    1402            CO       241  N14639                61      28        4       -4    IAH  AUS      140      7      26         0
# 30 2011     1         20         4    1835    2007            CO         5  N24212                92      44       33       10    IAH  MSY      305      4      44         0
# 31 2011     1         20         4    1600    1736            CO         6  N78285                96      38       41        5    IAH  SAT      191      6      52         0
# 32 2011     1         20         4    1304    1421            CO       241  N27610                77      29       23       -1    IAH  AUS      140      7      41         0
# 33 2011     1         20         4    1928    2109            CO       423  N35271               101      44       35        3    IAH  MSY      305      5      52         0
# 34 2011     1         20         4    1934    2101            CO       479  N76504                87      35       45       24    IAH  SAT      191      5      47         0
# 35 2011     1         20         4    1434    1607            CO       623  N75851                93      44       30        4    IAH  MSY      305      4      45         0
# 36 2011     1         20         4    1158    1304            CO       741  N26215                66      30       23       13    IAH  AUS      140      5      31         0
# 37 2011     1         20         4    1509    1631            CO      1079  N73259                82      37       44       24    IAH  SAT      191      5      40         0
# 38 2011     1         20         4    1911    2024            CO      1411  N76516                73      31       22        6    IAH  AUS      140      5      37         0
# 39 2011     1         20         4    1429    1538            CO      1541  N17627                69      31       14       -1    IAH  AUS      140      6      32         0
# 40 2011     1         20         4    1417    1623            CO      1621  N17620               126      62       43       -3    IAH  MFE      316      4      60         0
# 41 2011     1         19         3    1906    2003            CO      1411  N33264                57      28        1        1    IAH  AUS      140      5      24         0
# 42 2011     1         18         2    1544    1646            CO        35  N38257                62      30       18        9    IAH  AUS      140      4      28         0
# 43 2011     1         18         2    1430    1537            CO      1541  N16646                67      29       13        0    IAH  AUS      140      5      33         0
# 44 2011     1         18         2     900    1015            CO      1583  N39416                75      32       19        0    IAH  AUS      140      5      38         0
# 45 2011     1         18         2     930    1055            CO      1679  N16732                85      41       25        5    IAH  SAT      191      4      40         0
# 46 2011     1         17         1    1309    1412            CO       241  N14604                63      28       14        4    IAH  AUS      140      6      29         0
# 47 2011     1         17         1    1432    1539            CO      1541  N24633                67      30       15        2    IAH  AUS      140     12      25         0

tbl_df(filter(hflights, Cancelled == 1 & (DayOfWeek == 6 | DayOfWeek == 7)))

# A tibble: 585 x 21
# Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum TailNum ActualElapsedTi~ AirTime ArrDelay DepDelay Origin Dest  Distance TaxiIn TaxiOut Cancelled
# <int> <int>      <int>     <int>   <int>   <int> <fct>             <int> <chr>              <int>   <int>    <int>    <int> <chr>  <chr>    <int>  <int>   <int>     <int>
#   1  2011     1          9         7      NA      NA AA                 1820 "N4XCA~               NA      NA       NA       NA IAH    DFW        224     NA      NA         1
#  2  2011     1         29         6      NA      NA CO                  408 ""                    NA      NA       NA       NA IAH    EWR       1400     NA      NA         1
#  3  2011     1          9         7      NA      NA CO                  755 ""                    NA      NA       NA       NA IAH    ATL        689     NA      NA         1
#  4  2011     1          9         7      NA      NA DL                    8 "N933D~               NA      NA       NA       NA IAH    ATL        689     NA      NA         1
# 5  2011     1          9         7      NA      NA OO                 6726 "N779S~               NA      NA       NA       NA IAH    ASE        914     NA      NA         1
#  6  2011     1          2         7      NA      NA WN                 1629 "N749S~               NA      NA       NA       NA HOU    DAL        239     NA      NA         1
# 7  2011     1         29         6      NA      NA DL                 1590 "N764N~               NA      NA       NA       NA IAH    ATL        689     NA      NA         1
#  8  2011     1          9         7      NA      NA EV                 5229 "N901E~               NA      NA       NA       NA IAH    MEM        469     NA      NA         1
# 9  2011     1          1         6      NA      NA FL                  298 "N169A~               NA      NA       NA       NA HOU    ATL        696     NA      NA         1
# 10  2011     1          9         7      NA      NA FL                  292 "N925A~               NA      NA       NA       NA HOU    ATL        696     NA      NA         1
# ... with 575 more rows, and 2 more variables: CancellationCode <chr>, Diverted <int>

tbl_df(arrange(hflights,UniqueCarrier,desc(DepDelay)))

# A tibble: 227,496 x 21
# Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum TailNum ActualElapsedTi~ AirTime ArrDelay DepDelay Origin Dest  Distance
# <int> <int>      <int>     <int>   <int>   <int> <fct>             <int> <chr>              <int>   <int>    <int>    <int> <chr>  <chr>    <int>
#   1  2011    12         12         1     650     808 AA                 1740 N473AA                78      49      978      970 IAH    DFW        224
# 2  2011    11         19         6    1752    1910 AA                 1903 N495AA                78      40      685      677 IAH    DFW        224
# 3  2011    12         22         4    1728    1848 AA                 1903 N580AA                80      40      663      653 IAH    DFW        224
# 4  2011    10         23         7    2305       2 AA                  742 N548AA                57      39      507      525 IAH    DFW        224
# 5  2011     9         27         2    1206    1300 AA                 1948 N4YUAA                54      37      265      286 IAH    DFW        224
# 6  2011     3         17         4    1647    1747 AA                 1505 N584AA                60      41      262      277 IAH    DFW        224
# 7  2011     6         21         2     955    1315 AA                  466 N3FTAA               140     120      230      235 IAH    MIA        964
# 8  2011     5         20         5    2359     130 AA                  426 N565AA                91      70      255      234 IAH    DFW        224
# 9  2011     4         19         2    2023    2142 AA                 1925 N467AA                79      50      242      233 IAH    DFW        224
# 10  2011     5         12         4    2133      53 AA                 1294 N3AYAA               140     121      223      228 IAH    MIA        964
# ... with 227,486 more rows, and 5 more variables: TaxiIn <int>, TaxiOut <int>, Cancelled <int>, CancellationCode <chr>, Diverted <int>

hf1 <- tbl_df(mutate(hflights,TotalDelay = ArrDelay + DepDelay))

hf1 <- tbl_df(arrange(hf1, TotalDelay))       
hf1

# A tibble: 227,496 x 22
# Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin Dest  Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted TotalDelay
# <int> <int>      <int>     <int>   <int>   <int> <fct>             <int> <chr>               <int>   <int>    <int>    <int> <chr>  <chr>    <int>  <int>   <int>     <int> <chr>               <int>      <int>
#   1  2011     7          3         7    1914    2039 XE                 2804 N12157                 85      66      -70       -1 IAH    MEM        468      4      15         0 ""                      0        -71
# 2  2011     8         31         3     934    1039 OO                 2040 N783SK                185     172      -56      -11 IAH    BFL       1428      3      10         0 ""                      0        -67
# 3  2011     8         21         7     935    1039 OO                 2001 N767SK                184     171      -56      -10 IAH    BFL       1428      3      10         0 ""                      0        -66
# 4  2011     8         28         7    2059    2206 OO                 2003 N783SK                187     171      -54      -11 IAH    BFL       1428      5      11         0 ""                      0        -65
# 5  2011     8         29         1     935    1041 OO                 2040 N767SK                186     169      -54      -10 IAH    BFL       1428      4      13         0 ""                      0        -64
# 6  2011    12         25         7     741     926 OO                 4591 N814SK                165     147      -57       -4 IAH    SLC       1195      4      14         0 ""                      0        -61
# 7  2011     1         30         7     620     812 OO                 4461 N804SK                172     156      -49      -10 IAH    SLC       1195      5      11         0 ""                      0        -59
# 8  2011     8          3         3    1741    1810 XE                 2603 N11107                 89      73      -40      -19 IAH    HOB        501      5      11         0 ""                      0        -59
# 9  2011     8          4         4     930    1041 OO                 1171 N715SK                191     177      -49      -10 IAH    BFL       1428      4      10         0 ""                      0        -59
# 10  2011     8         18         4     939    1043 OO                 2001 N783SK                184     172      -52       -6 IAH    BFL       1428      4       8         0 ""                      0        -58
# ... with 227,486 more rows

tbl_df(filter(hflights,Dest == "DFW" & DepTime < 800))

# Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum TailNum ActualElapsedTi~ AirTime ArrDelay DepDelay
# <int> <int>      <int>     <int>   <int>   <int> <fct>             <int> <chr>              <int>   <int>    <int>    <int>
#   1  2011     1          1         6     728     840 AA                  460 N520AA                72      41        5        8
# 2  2011     1          2         7     719     821 AA                  460 N537AA                62      43      -14       -1
# 3  2011     1          3         1     717     834 AA                  460 N512AA                77      46       -1       -3
# 4  2011     1          4         2     714     821 AA                  460 N478AA                67      46      -14       -6
# 5  2011     1          5         3     718     822 AA                  460 N551AA                64      44      -13       -2
# 6  2011     1          6         4     719     821 AA                  460 N251AA                62      44      -14       -1
# 7  2011     1          7         5     711     827 AA                  460 N478AA                76      42       -8       -9
# 8  2011     1          8         6     713     805 AA                  460 N550AA                52      40      -30       -7
# 9  2011     1          9         7     714     829 AA                  460 N586AA                75      51       -6       -6
# 10  2011     1         10         1     715     818 AA                  460 N587AA                63      44      -17       -5
# ... with 789 more rows, and 8 more variables: Origin <chr>, Dest <chr>, Distance <int>, TaxiIn <int>, TaxiOut <int>,
#   Cancelled <int>, CancellationCode <chr>, Diverted <int>

summarise(hflights, min_dist = min(Distance), max_dist = max(Distance))

# min_dist max_dist
# 1       79     3904

hflights %>% filter(Diverted == 1) %>% summarise(max_div = max(Distance))

# max_div
# 1    3904

n_obv <- hflights %>% summarise(n_obv = n())

#    n_obv
# 1 227496

n_carrier <- n_distinct(hflights$UniqueCarrier)
n_carrier

# > n_carrier
# [1] 15

n_dest <- n_distinct(hflights$Dest)
n_dest

# > n_dest
# [1] 116

dest100 <-  nth(hflights$Dest,100)
dest100

# > dest100
# [1] "DFW"

table(c(n_carrier, n_obv, n_dest, dest100))

hflights %>% mutate(diff = TaxiIn - TaxiOut) %>% filter(diff != "NA") %>% summarise(avg = mean(diff))

# avg
# 1 -8.992064

d <- tbl_df(hflights %>% select(Dest, UniqueCarrier, Distance, ActualElapsedTime) %>% mutate(RealTime = ActualElapsedTime + 100 ))
d

# A tibble: 227,496 x 5
# Dest  UniqueCarrier Distance ActualElapsedTime RealTime
# <chr> <fct>            <int>             <int>    <dbl>
#   1 DFW   AA                 224                60      160
# 2 DFW   AA                 224                60      160
# 3 DFW   AA                 224                70      170
# 4 DFW   AA                 224                70      170
# 5 DFW   AA                 224                62      162
# 6 DFW   AA                 224                64      164
# 7 DFW   AA                 224                70      170
# 8 DFW   AA                 224                59      159
# 9 DFW   AA                 224                71      171
# 10 DFW   AA                 224                70      170
# ... with 227,486 more rows

hflights %>% group_by(UniqueCarrier) %>% filter(Cancelled == 0) %>% summarise(nflights = n() )

# UniqueCarrier nflights
# <fct>            <int>
#   1 AA                3184
# 2 AS                 365
# 3 B6                 677
# 4 CO               69557
# 5 DL                2599
# 6 EV                2128
# 7 F9                 832
# 8 FL                2118
# 9 MQ                4513
# 10 OO               15837
# 11 UA                2038
# 12 US                4036
# 13 WN               44640
# 14 XE               71921
# 15 YV                  78

 hflights %>% group_by(UniqueCarrier) %>% filter(Cancelled == 1) %>% summarise(n_canc = n())

 # UniqueCarrier n_canc
 # <fct>          <int>
 #   1 AA                60
 # 2 B6                18
 # 3 CO               475
 # 4 DL                42
 # 5 EV                76
 # 6 F9                 6
 # 7 FL                21
 # 8 MQ               135
 # 9 OO               224
 # 10 UA                34
 # 11 US                46
 # 12 WN               703
 # 13 XE              1132
 # 14 YV                 1

hflights %>% group_by(UniqueCarrier) %>% summarise(avg_delay = mean(ArrDelay, na.rm = T)) %>% arrange(avg_delay)

# UniqueCarrier avg_delay
# <fct>             <dbl>
#   1 US               -0.631
# 2 AA                0.892
# 3 FL                1.85 
# 4 AS                3.19 
# 5 YV                4.01 
# 6 DL                6.08 
# 7 CO                6.10 
# 8 MQ                7.15 
# 9 EV                7.26 
# 10 WN                7.59 
# 11 F9                7.67 
# 12 XE                8.19 
# 13 OO                8.69 
# 14 B6                9.86 
# 15 UA               10.5  


