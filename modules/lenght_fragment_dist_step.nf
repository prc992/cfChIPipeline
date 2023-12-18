process lenght_fragment_dist_step1{
  queue = "$params.queue"

  //Docker Image
  container ='quay.io/biocontainers/samtools:1.15.1--h1170115_0'

  tag "$sampleId" 
  publishDir "$path_sample_frag", mode : 'copy'

  input:
  tuple path (sampleBam), path(_)
  tuple val(sampleId), val(path),path(_), path(_)
  tuple val (_),val (_),val(path_sample_frag),val (_),val(_), val(_),val(_)

  output:
  path ('*.txt')

  exec:
  String strtxt = sampleId + '_fragment_lengths.txt'

  script:
  """
  samtools view $sampleBam | cut -f 9 | awk ' \$1 <= 1000 && \$1 > 0 ' > $strtxt
  """

}

process lenght_fragment_dist_step2{
  queue = "$params.queue"

  //Docker Image
  container ='pegi3s/r_data-analysis'

  tag "$sampleId" 
  publishDir "$path_sample_frag", mode : 'copy'

  output:
  path ('*.png')

  input:
  path (chRfrag_plotFragDist)
  path(fragLeng)
  tuple val(sampleId), val(path),path(_), path(_)
  tuple val (_),val (_),val(path_sample_frag),val (_),val(_), val(_),val(_)

  exec:
  String strPNG = sampleId + '_fragDist.png' 

  script:
  """
  Rscript $chRfrag_plotFragDist $fragLeng $strPNG $sampleId
  """

}