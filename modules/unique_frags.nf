process unique_frags {
  queue = "$params.queue"

  tag "#$sampleId" 
  publishDir "$path_sample_peaks", mode : 'copy'

  input:
  path (sampleBed)
  tuple val(sampleId), val(_),path(_), path(_)
  tuple val (_),val (_),val(_),val (_),val(path_sample_peaks), val(_),val(_)

  output:
  path ('*.csv')

  exec:
  String strCSV = sampleId + '_unique_frags.csv'
  
  script:
  """
  echo $sampleId && wc -l $sampleBed | cut -f1 -d' '  >> $strCSV
  """

}