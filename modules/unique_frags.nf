process unique_frags {
  queue = "$params.queue"
  container ='ubuntu:noble-20231221'

  tag "#$sampleId" 
  publishDir "$path_sample_peaks", mode : 'copy'

  input:
  path (sampleBed)
  tuple val(sampleId), val(path),path(_), path(_)

  output:
  path ('*.csv')

  exec:
  path_sample_peaks = path + "/peaks/" + sampleId
  strCSV = sampleId + '_unique_frags.csv'
  
  script:
  """
  echo $sampleId && wc -l $sampleBed | cut -f1 -d' '  >> $strCSV
  """

}
