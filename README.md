# Data Preprocessing on Hadoop

This project ingest the sales data from the data warehouse into the data lake and prepare it for analysis and consumption using Hadoop. Raw data has been stored in an S3 bucket.

## Table of Contents
- [Background](#background)
- [Install](#Install)
- [Usage](#Usage)


## Install

Download and unzip [Cloudera VM](https://drive.google.com/drive/u/1/folders/1V8aD1qHnJyuC6Hg1tL8SvKtEzrAyNlD6). 

This project should be run on [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Download the according packages and install. 

### VM Settings

In `Tools`, click `Import` and import the [Cloudera VM](https://drive.google.com/drive/u/1/folders/1V8aD1qHnJyuC6Hg1tL8SvKtEzrAyNlD6) just downloaded.

In `Settings`, Adjust the `System` of VM to at least 8192 MB Base Memory and 2 Processors. 

`Start` the VM, click `Launch Cloudera Express` and wait for complete. The default username and password for Cloudera are both `cloudera`.

Open broswer and click `Cloudera Maneger` in Bookmark. Click on the  `Cloudera Quickstart` arrow then select `Restart every time VM get restarted. Green icons should be shown when service is running.

## Usage

### To Run the script

In VirtualBox terminal, go to the repo which you just downloaded
```
$ cd codes
$ chmod +x bin.sh
```
Run `./bin.sh -h ` please follow the help instructions.

### Data Load
Data must be gotton and loaded before running the tables and views. 
1. Run `./bin.sh -g` to collect the data from the Internet
2. Run `./bin.sh -l` to load the data to HDFS

### Generate Views 
After the data is loaded to the hdfs, we can create our databases and views. Code can be found here: [create_raw.sql](/codes/create_raw.sql) [create_parquets.sql](/codes/create_parquets.sql) and [create_view.sql](/codes/create_view.sql)

3. Run `./bin.sh -cr` to create the raw sales database from csv files
4. Run `./bin.sh -cq` to create the sales database from raw data
5. Run `./bin.sh -cv` to create the sales database from raw data

### Data Partition
Next step is to try using partition. Code can be found here: [create_monthly_partition.sql](/codes/create_monthly_partition.sql)  and [create_region_partition.sql](/codes/create_region_partition.sql). We do realize the region partition requires a lot of memory, so it is recommand to add `LIMIT (some num)` in the end of `create_region_partition.sql`.

6. Run `./bin.sh -cmp` to create partitioned views and parquets on sales and products
7. Run `./bin.sh -rpr` to create partitioned parquets on region
8. Run `./bin.sh -dc` to drop raw sales database cascade
9. Run `./bin.sh -d2c` to drop sales database cascade
10. Run `./bin.sh -dh` to delete all sales data in hdfs
