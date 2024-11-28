process snp_footprint_clustering{

  label 'process_medium'

  tag "Sample - $sampleId"   

  //Docker Image
  container ='prc992/snp_dendrogram:v1.0'
  publishDir "$path_sample_snp_footprint", mode : 'copy'

  input:
  tuple val(sampleId), val(path),path(_), path(_)
  each path (chRSNPFootprint)

  exec:
  path_sample_snp_footprint = path + "/snp_fingerprint" 

  output:
  path ('*.pdf')

  script:
  """
  Rscript $chRSNPFootprint
  """
}
