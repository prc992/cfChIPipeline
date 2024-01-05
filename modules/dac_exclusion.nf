process dac_exclusion {
  queue = "$params.queue"

  //Docker Image
  container ='quay.io/biocontainers/bedtools:2.30.0--hc088bd4_0'

  tag "$sampleId - 1" 
  publishDir "$path_sample_align", mode : 'copy'

  input:
  tuple path(sampleBam),path(_)
  tuple val(sampleId), val(path),path(_), path(_)

  exec:
  path_sample_align = path + "/align/" + sampleId
  strBam = sampleId + 'dac_filtered.dedup.unique.sorted.bam'

  output:
  path("*.bam")

  script:
  """
  bedtools intersect -v -abam $sampleBam -b $params.DAC_Exclusion > $strBam
	"""
}
