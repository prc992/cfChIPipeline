process index_sam {
  queue = "$params.queue"

  //Docker Image
  container ='quay.io/biocontainers/samtools:1.15.1--h1170115_0'

  tag "$sampleId" 
  publishDir "$path_sample_align", mode : 'copy'
  
  input:
  tuple path (sampleBam), path(_)
  tuple val (sampleId), val(_),path(_), path(_)
  tuple val (path_sample_align),val (_),val(_),val (_),val(_), val(_),val(_)

  output:
  path ('*.bai')

  script:
  """
  samtools index $sampleBam
  """
}
