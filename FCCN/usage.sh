#!/bin/bash

function parse {
  TZ=UTC sacct --clusters macc --parsable2 --allusers --noconvert --format Jobid,CPUTimeRaw,State,ReqGres,Account,TRESUsageInTot --starttime $1 --endtime $2
}

function main {
    echo "
{
    \"report_type\": \"Resource_Usage_HPC\",
    \"report_version\": \"1.0\",
    \"report_date\": \"$2\",
    \"RNCA_resource_id\": \"_sample_\",
    \"items\": ["
        parse $@ | awk -f /home/macc/usage/JSON/usage.awk | sed '$s/,$//'
    echo "
    ]
}"

}

if [[ $# == 0 ]]; then
  start=$(date  '+%Y-%m-%dT00:00:00' -d "-2 week")
  end=$(date  '+%Y-%m-%dT23:59:59')
  main $start $end
elif [[ $# == 2 ]]; then
  start_aux=$(date '+%Y-%m-%d' -d "$1-2 week")
  start=$start_aux"T00:00:00"
  end="$1T23:59:59"
  main $start $end
else
  echo "
  Invalid number of arguments.

Options:
	  a) Empty: Request will gather data usage report from 2 weeks
  prior to today;
	  b) date (YYYY-MM-DD): Request will gather data usage report from 2 weeks
  prior to this date;
   "
fi
