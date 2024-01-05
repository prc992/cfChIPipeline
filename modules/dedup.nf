process dedup {
  queue = "$params.queue"

  //Docker Image
  container = 'quay.io/biocontainers/picard:2.27.4--hdfd78af_0'

  tag "$sampleId - 1" 
  publishDir "$path_sample_align", mode : 'copy'

  input:
  path sampleBam
  tuple val(sampleId), val(path),path(_), path(_)

  exec:
  path_sample_align = path + "/align/" + sampleId
  String strBam = sampleId + '.dedup.unique.sorted.bam'
  String strTxt = sampleId + '-MarkDuplicates.metrics.txt'

  output:
  tuple path("*.bam"),path("*.txt")

  script:
  """
  picard MarkDuplicates \\
  I=$sampleBam \\
  O=$strBam \\
  REMOVE_DUPLICATES=true \\
  ASSUME_SORT_ORDER=coordinate \\
  VALIDATION_STRINGENCY=LENIENT \\
  METRICS_FILE=$strTxt
	"""
}
