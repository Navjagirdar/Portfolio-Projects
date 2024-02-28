## Bellabeat Marketing Strategy Analysis
<p>
<h3><strong>Content:</strong></h3>
<li>Introduction </li>
<li>Summary of business task</li> 
<li>Description of Data Sources</li>
<li>Data Cleaning</li>
<li>Analysis</li>
<li>Recommendation</li></ul>

<h3><strong>Introduction:</strong></h3>
In this capstone project, I am assigned as a junior data analyst at the marketing team of Bellabeat to help them unlock new growth opportunities in the smart device market. 

<h3><strong>Bellabeat Overview:</strong></h3>
<ul>
<li><i>Manufacturer of health-focused smart products for Women</i></li>
<li><i>Some of their products includes Bellabeat app, Leaf (wellness tracker), smart watch, water bottle (hydration tracker), Bellabeat Membership subscriptions</i></li>
<li><i>Marketing wise the company has highly invested in digital marketing which includes Google search, Facebook and Instagram pages, Twitter, and YouTube ads</i></li></ul>

<h3><strong>Business Task:</strong></h3>
<ul>
<li>Find trends in the usage of smart devices to gain insight on non-Bellabeat users and how the marketing team at Bellabeat convert these users into customers</li>

<li>How these insights on the non-Bellabeat usage of smart devices will help market the Bella beat app to women</li></ul>

<h3><strong>Key Stakeholders:</strong></h3>
<ul>
<li>Urska Srsen: Bellabeat’s Cofounder and Chief Creative Officer</li>
<li>Sando Mur: Cofounder and Member of Executive team</li>
<li>Bellabeat Marketing analytics tea.: A team of data analyst responsible for collecting, analyzing, and reporting the data that helps coin the Bellabeat’s marketing strategy</li></ul>

<h3><strong>Data Source</strong></h3>
The public dataset Fitbit Fitness Tracker by Mobius is downloaded from Kaggle. It contains personal tracker data about thirty Fitbit users. It includes information about daily activity, steps, and heart rate that can be used to explore users’ habits. However, this dataset has limitation of small sample size and only 2 months of tracked data. 
Location: The data is available on Kaggle.com in a zip file containing 18 CSV files about daily user’s activities for 2 months in the year 2016. 

<h4>Listed are the CSV files used for this analysis: </h4>
<ul>
<li>dailyActivity_merged</li>
<li>sleepDay_merged </li>
<li>heartrate_seconds_merged</li>
<li>hourlySteps_merged</li>
<li>weightLogInfo_merge</li></ul>

<h3><strong>Data Cleaning</strong></h3>
Loaded the 7 CSV files in R studio by installing the readr package. 

</p>

```r
install.packages("tidyverse")
library(tidyverse)
install.packages("readr")
library(readr)
```
