process snp_fingerprint {
  queue = "$params.queue"
  
  //Docker Image
  container = 'quay.io/mcrotti1/bcftools'

  tag "$sampleId" 
  publishDir "$path_sample_snp_fingerprint", mode : 'copy'

  input:
  tuple path (sampleBam), val (_)
  tuple val(sampleId), val(path),path(_), path(_)

  exec:
  path_sample_snp_fingerprint = path + "/snp_fingerprint/" + sampleId
  strVCFgz = sampleId + '.vcf.gz'
  
  output:
  path ("*.vcf.gz")

  script:
  """
  samtools index $sampleBam &&
  bcftools mpileup -Ou -R $params.snps_ref -f $params.align_ref $sampleBam | bcftools call -c | bgzip > $strVCFgz
  """

}
