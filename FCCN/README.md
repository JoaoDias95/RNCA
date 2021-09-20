# RNCA_usage_report

Two parsing options:
- Python
- Awk/Bash

Changes in SLURM query:

#TZ=UTC sacct --clusters macc --noconvert --parsable2 --allusers --format Jobid,CPUTimeRaw,State,ReqGres,Account,TRESUsageInTot --starttime yyyy-mm-dd --endtime yyyy-mm-dd


------------------------------------------- files
 
 FCCN/R01_converter.py
     Script to convert a Slurm CSV output to JSON format

 FCCN/usage.awk
     Awk script to convert a Slurm output to JSON format

 FCCN/usage.sh
     Bash script to call AWK script