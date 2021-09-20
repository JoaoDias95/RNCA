# -*- coding: utf-8 -*-
import csv
import sys
import json
import re

#columns of the CSV file:
#Jobid|CPUTimeRaw|State,ReqGres|Account|TRESUsageInTot

#TZ=UTC sacct --clusters macc --noconvert --parsable2 --allusers --format Jobid,CPUTimeRaw,State,ReqGres,Account,TRESUsageInTot --starttime yyyy-mm-dd --endtime yyyy-mm-dd

# 0 JobIDRaw
# 1 CPUTimeRaw
# 3 State
# 4 ReqGres
# 5 Account
# 6 TRESUsageInTot

sample_data_HPC ={
    "report_type": "Resource_Usage_HPC",
    "report_version": "1.0",
    "report_date": "_sample_",
    "RNCA_resource_id": "_sample_",
    "items": []
} 
filen="R01_slurm_sample.csv"
with open(filen) as csvfile:
  readCSV = csv.reader(csvfile, delimiter='|')
  lineno=0
  for row in readCSV:
    item={
        "RNCA_proj_ID": "",
        "job_id": "",
        "job_state": "",
        "CPUcore_sec": "",
        "GPU_sec": "",
        "RAM_GB": "",
        "Disk_GB": "",
    }
    item["job_id"]=row[0]
    item["CPUcore_sec"]=row[1]
    item["job_state"]=row[2]       
    if ("gpu" in row[3]):
      item["GPU_sec"]=row[1]
    tres=re.split('=|,',row[5])
    if len(tres)!=1:
      item["RAM_GB"]=float(tres[5])/1024/1024**2  #Bytes to GB
      item["Disk_GB"]=float(tres[7])/1024/1024**2 #Bytes to GB
    item["RNCA_proj_ID"]=row[4]
    sample_data_HPC["items"].append(item.copy())


json_object = json.dumps(sample_data_HPC, indent = 4)
print(json_object)
