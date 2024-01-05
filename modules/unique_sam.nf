process unique_sam {
  queue = "$params.queue"

  //Docker Image
  container ='quay.io/biocontainers/samtools:1.15.1--h1170115_0'

  tag "$sampleId - 1" 
  publishDir "$path_sample_align", mode : 'copy'
  
  input:
  path sampleBam
  tuple val(sampleId), val(path),path(_), path(_)

  exec:
  String strBam = sampleId + '.unique.sorted.bam'
  path_sample_align = path + "/align/" + sampleId

  output:
  path("*.bam")

  script:
  """
  samtools view -b -q 1 $sampleBam > $strBam
  """
}
