process unique_sam {
  queue = "$params.queue"

  //Docker Image
  container ='quay.io/biocontainers/samtools:1.15.1--h1170115_0'

  tag "$sampleId" 
  publishDir "$path_sample_align", mode : 'copy'
  
  input:
  path sampleBam
  tuple val(sampleId), val(_),path(_), path(_)
  tuple val (path_sample_align),val (_),val(_),val (_),val(_), val(_),val(_)

  exec:
  String strBam = sampleId + '.unique.sorted.bam'

  output:
  path("*.bam")

  script:
  """
  samtools view -b -q 1 $sampleBam > $strBam
  """
}