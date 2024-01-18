process sort_bam {
  label 'process_medium'

  //Docker Image
  container ='quay.io/biocontainers/samtools:1.15.1--h1170115_0'

  tag "$sampleId-1" 
  publishDir "$path_sample_align", mode : 'copy'
  
  input:
  path(sampleBam)
  tuple val(sampleId), val(path),path(_), path(_)
  
  output:
  path("*.bam")

  exec:
  String strBam = sampleId + '.sorted.bam'
  path_sample_align = path + "/align/" + sampleId

  script:
  """
  samtools sort $sampleBam -o $strBam
  """
}
