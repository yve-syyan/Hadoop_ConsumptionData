# CSCI 5751 Project 2 - Team Tin

Team name: Tin

Slack channel name: pro1groupabc

Team member: Fei Gao, Songyu Yan, Xinyu Jiang, Yifan Hu

This project aimed to prepare data for analysis and consumption. 

## Table of Contents
- [Background](#background)
- [Raw Data Description](#DataDescription)
- [Feature](#Feature) 
- [Install](#Install)
- [Usage](#Usage)

## Background 

As data engineers at a product sales organization, we ingest the sales data from the data warehouse into data lake and get it prepared for analysis and consumption using Hadoop.

## Data Description
### Quality Analysis

## Install

Download and unzip [Cloudera VM](https://drive.google.com/drive/u/1/folders/1V8aD1qHnJyuC6Hg1tL8SvKtEzrAyNlD6). 

This project should be run on [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Download the according packages and install. 

### VM Settings

In `Tools`, click `Import` and import the [Cloudera VM](https://drive.google.com/drive/u/1/folders/1V8aD1qHnJyuC6Hg1tL8SvKtEzrAyNlD6) just downloaded.

In `Settings`, Adjust the `System` of VM to at least 8192 MB Base Memory and 2 Processors. 

`Start` the VM, click `Launch Cloudera Express` and wait for complete. The default username and password for Cloudera are both `cloudera`.

Open broswer and click `Cloudera Maneger` in Bookmark. Click on the  `Cloudera Quickstart` arrow then select `Restart every time VM get restarted. Green icons should be shown when service is running.

### Git Clone

Clone the current git repository to run script. In VirtualBox broswer, Click the green button `Clone or Downloads` to download the [current repository](https://github.umn.edu/huxxx988/5751_proj2).

## Usage

### To Run the script

In VirtualBox terminal, go to the repo which you just downloaded
```
$ cd codes
$ chmod +x bin.sh
```
Run `./bin.sh -h ` and the script will tell you what to do.


### (Deliverable 2) raw data issues:
##### Duplicatation: 
In `Customers`, there are two customer with same ID 17829.

##### Zero-Price:
In 'Products', there are 48 items' sell price equals 0.

The raw data set except 'Employees' is not represented as general csv data that each fields are seperated by ','. Instead, each fields are seperated by '|' and most of them are placed in a single column shown by excel. In addition, some 'middle name' values of 'Customers' data are null. But it is not a big deal.

### (Deliverable 2) Data Load
Data must be gotton and loaded before running the tables and views. 
1. Run `./bin.sh -g` to collect the data from the Internet
2. Run `./bin.sh -l` to load the data the hdfs

### (Deliverable 2) Table and Views of Raw Data 
After the data is loaded to the hdfs, we can create our databases and views. Code can be found here: [create_raw.sql](/codes/create_raw.sql) [create_parquets.sql](/codes/create_parquets.sql) and [create_view.sql](/codes/create_view.sql)

3. Run `./bin.sh -cr` to create the raw sales database from csv files
4. Run `./bin.sh -cq` to create the sales database from raw data
5. Run `./bin.sh -cv` to create the sales database from raw data
### 