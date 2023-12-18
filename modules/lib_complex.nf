process lib_complex {
  queue = "$params.queue"

  //Docker Image
  container = "quay.io/biocontainers/picard:2.27.4--hdfd78af_0"

  tag "$sampleId"
  publishDir "$path_sample_align", mode : 'copy'

  input:
  path sampleBam
  tuple val(sampleId), val(_),path(_), path(_)
  tuple val (path_sample_align),val (_),val(_),val (_), val(_), val(_),val(_)

  output:
  path("*.csv")

  exec:
  String strBam = sampleId + '_lib_complexity.csv'

  script:
  """
  picard EstimateLibraryComplexity I=$sampleBam  O=$strBam
  """
}
