process fastqc {
  queue = "$params.queue"
    
  //Docker Image
  container = 'quay.io/biocontainers/fastqc:0.11.9--0'

  tag "$sampleId" 
  publishDir "$path_sample_fastqc", mode : 'copy'
  
  input:
  tuple val(sampleId), val(path),path(read1), path(read2)

  exec:
  path_sample_fastqc = path + "/fastqc/" + sampleId

  output:
  path ('*_fastqc.html')
  path ('*_fastqc.zip')
  
  script:
  """
  fastqc $read1 $read2
  """
}