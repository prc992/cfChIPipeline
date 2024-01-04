process align {
  queue = "$params.queue"
  //label 'process_low'

  memory '16 GB'
  
  //Docker Image
  container = 'quay.io/biocontainers/mulled-v2-fe8faa35dbf6dc65a0f7f5d4ea12e31a79f73e40:8110a70be2bfe7f75a2ea7f2a89cda4cc7732095-0'

  tag "$sampleId" 
  publishDir "$path_sample_align", mode : 'copy'
  
  input:
  tuple path(file1),path(file2)
  tuple val(sampleId), val(path),path(_), path(_)
  
  output:
  path("*.bam")

  exec:
  String strBam = sampleId + '.bam'
  path_sample_align = path + "/align/" + sampleId

  
  script:
  """
  bwa mem -v 0 $params.align_ref $file1 $file2 | samtools view -Sb -u > $strBam
  """
}
