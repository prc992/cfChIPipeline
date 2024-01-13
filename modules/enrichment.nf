process enrichment {
  queue = "$params.queue"

  //Docker Image
  container ='quay.io/biocontainers/samtools:1.15.1--h1170115_0'

  tag "On/Off Enrichment #$sampleId" 
  publishDir "$path_sample_peaks", mode : 'copy'

  input:
  each path (chEnrichmentScript)
  tuple path (sampleBam), val(_)
  tuple val(sampleId), val(path),path(_), path(_)

  exec:
  path_sample_peaks = path + "/peaks/" + sampleId
  strCSV = sampleId + '_total_enrichment.csv'

  output:
  path("*.csv")

  script:
  """
  sh $chEnrichmentScript $sampleBam $params.states_ref $sampleId >> $strCSV
  """
}
