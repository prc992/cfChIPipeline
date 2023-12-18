process fetch_chrom_sizes{
  queue = "$params.queue"
  
  //Docker Image
  container = 'quay.io/biocontainers/ucsc-fetchchromsizes:377--ha8a8165_3'

  tag "$sampleId" 
  publishDir "$path_sample_peaks", mode : 'copy'

  input:
  tuple val(sampleId), val(_),path(_), path(_)
  tuple val (_),val (_),val(_),val (_),val(path_sample_peaks), val(_),val(_)

  exec:
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