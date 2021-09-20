# usage.awk --- simple regex program
#TZ=UTC sacct --clusters macc --noconvert --parsable2 --allusers --format Jobid,CPUTimeRaw,State,ReqGres,Account,TRESUsageInTot --starttime yyyy-mm-dd --endtime yyyy-mm-dd

BEGIN { RS = "\n" ; FS = "|"; SUBSEP=","; OFS="|"} #"[\|\,\=]"
{
      empty=""
      job_id=$1
      CPUcore_sec=$2
      job_state=$3
      GPU_sec_aux=$4
      used_GPU=index(GPU_sec_aux, "gpu")
      if (used_GPU == 0)
            GPU_sec=empty
      else
            GPU_sec=CPUcore_sec;
      RNCA_proj_ID=$5
      sz_tres_usage=split($6, tres_usage ,",|=")
      RAM_GB=tres_usage[6]/(1024*1024)
      Disk_GB=tres_usage[8]/(1024*1024)
      printf "\n\t{\n\t\t\"job_id\": \"%s\",\n\t\t\"CPUcore_sec\": \"%s\",\n\t\t\"job_state\": \"%s\",\n\t\t\"GPU_sec\": \"%s\",\n\t\t\"RAM_GB\": \"%s\",\n\t\t\"RNCA_proj_ID\": \"%s\",\n\t\t\"Disk_GB\": \"%s\" \n\t },",
        job_id, CPUcore_sec, job_state, GPU_sec, RAM_GB, RNCA_proj_ID, Disk_GB
}
