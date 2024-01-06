process fetch_chrom_sizes{
  queue = "$params.queue"
  
  //Docker Image
  container = 'quay.io/biocontainers/ucsc-fetchchromsizes:377--ha8a8165_3'

  tag "$sampleId" 
  publishDir "$path_sample_peaks", mode : 'copy'

  input:
  tuple val(sampleId), val(path),path(_), path(_)

  exec:
  path_sample_peaks = path + "/peaks/" + sampleId
  //Here we extract the reference genome from the param align_ref
  //using string manipulation
  int inicio = params.align_ref.lastIndexOf('/');
  int fim = params.align_ref.indexOf('.fa'); 
  String refGenome = params.align_ref.substring(inicio+1,fim);
  String refGenomeFile = refGenome + '.chrom.sizes'

  output:
  path ('*.sizes')
  
  script:
  """
  fetchChromSizes $refGenome > $refGenomeFile
  """
}
