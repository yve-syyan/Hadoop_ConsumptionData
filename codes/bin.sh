#!/usr/bin/env bash

# check for 1 argument
#if [ $# -lt 1 ]
#then
#        echo "Usage : $0 please declare an variable option"
#        echo "for help -h or --help"
#        exit
#fi
########################################################
# Declared Variables
########################################################

counter=0
option=$1
sales_directory=~/salesdb
hdfs_directory=/salesdb
path_to_files=$(pwd)

########################################################
# Functions
########################################################

display_help() {
    echo "Usage: $) [option...] " >&2
    echo
    echo "  -h, --help          display help contents"
    echo "  -g, --get_data           get data from url"
    echo "  -l, --load          load data to hdfs"
    echo "  -cr, --create_sales_raw_tables      create tables for deliverable 2 step 1"
    echo "  -cq, --create_sales_tables    create tables for deliverable 2 step 2.2"
    echo "  -cv, --create_sales_view     create views for deliverable 2, step 2.4"
    echo "  -cmp, --create_monthly_partition     create partitioned views and parquets on sales and products, step 3.1, 3.2"
    echo "  -rpr, --create_product_region_partition     create partitioned parquets on region, step 3.3"
    echo "  -dc, --drop_raw_cascade      drop raw sales database cascade"
    echo "  -d2c, --drop_sales_cascade      drop sales database cascade"
    echo "  -dh, --delete-hdfs       delete all sales data in hdfs"
    exit 1
}

get_data() {
    echo "getting data from https://csci5751-2020sp.s3-us-west-2.amazonaws.com/sales-data/salesdata.tar.gz"
    wget https://csci5751-2020sp.s3-us-west-2.amazonaws.com/sales-data/salesdata.tar.gz
    echo "unzipping sales data"
    tar -xvzf salesdata.tar.gz
    mv salesdb $sales_directory
}

do_hdfs() {
  echo creating hdfs directory $hdfs_directory
  sudo -u hdfs hdfs dfs -mkdir $hdfs_directory

  for file in "$sales_directory"/*
     do
     echo processing "$file"
     filename=$(basename -- "$file")
     echo creating hdfs directory: $hdfs_directory/"${filename%.*}"
     sudo -u hdfs hdfs dfs -mkdir $hdfs_directory/"${filename%.*}"
     echo puting file $sales_directory/$filename to hdfs directory: $hdfs_directory/"${filename%.*}"
     sudo -u hdfs hdfs dfs -put $sales_directory/$filename $hdfs_directory/"${filename%.*}"/
   done
   echo Changing owner of hdfs directory to hive
   sudo -u hdfs hdfs dfs -chown -R hive:hive $hdfs_directory
}

create_raw() {
   echo creating raw tables on csv files
   impala-shell -f "$path_to_files"/create_raw.sql

}

create_parquets() {
   echo creating parquet tables as Select
   impala-shell -f "$path_to_files"/create_parquets.sql

}

create_sales_views() {
   echo creating sales views on parquet tables
   impala-shell -f "$path_to_files"/create_view.sql
}

create_mp() {
   echo Creating monthly partitioned views and parquets on sales and products
   impala-shell -f "$path_to_files"/create_monthly_partition.sql
}

create_rpr() {
echo Creating partitioned on regions
   impala-shell -f "$path_to_files"/create_region_partition.sql
}

drop_raw_database() {
   echo Dropping databse and cascade tables
   impala-shell -q "DROP DATABASE IF EXISTS tin_sales_raw CASCADE;"

}

drop_sales_database() {
   echo Dropping databse and cascade tables
   impala-shell -q "DROP DATABASE IF EXISTS tin_sales CASCADE;"

}

delete_hdfs_raw() {
    echo Removing raw trains data from HDFS
    sudo -u hdfs hdfs dfs -rmr $hdfs_directory
}


########################################################
# Run Time Commands
########################################################

while [ $counter -eq 0 ]; do
    counter=$(( counter + 1 ))

    case $option in
      -h | --help)
          display_help
          ;;

      -g | --get_data)
          echo "Geting data and unzipping file"
          get_data
          ;;

      -l | --load)
          echo "Loading data to HDFS"
          do_hdfs
          ;;

      -cr | --create_sales_raw_tables )
          echo "Creating raw external tables"
          create_raw
          ;;

      -cq | --create_sales_tables)
          echo "Creating raw external tables"
          create_parquets
          ;;

      -cv | --create_sales_view )
          echo "Creating sales views"
          create_sales_views
          ;;
      
      -cmp | --create_monthly_partition )
          echo "Creating partitioned view and parquets on sales and products"
          create_mp
          ;;     

      -rpr |  --create_product_region_partition )
          echo "Creating partitioned on regions"
          create_rpr
          ;;    

      -dc | --drop_raw_cascade)
          echo "Dropping DATABASE CASCADE"
          drop_raw_database
          ;;

      -d2c | --drop_trains_cascade)
          echo "Dropping DATABASE CASCADE"
          drop_trains_database
          ;;


      -dh | --delete_hdfs_raw)
          echo "Removing Data from HDFS"
          delete_hdfs_raw
          ;;
      --) # End of all options
          shift
          break
          ;;

      -*)
          echo "Error: Unknown option: $1" >&2
          display_help
          exit 1
          ;;

      *)  # No more options
          break
          ;;

    esac
done
