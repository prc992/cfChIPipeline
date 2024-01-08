process snp_fingerprint {
  queue = "$params.queue"
  
  //Docker Image
  container = 'quay.io/mcrotti1/bcftools'

  tag "$sampleId" 
  publishDir "$path_sample_snp_fingerprint", mode : 'copy'

  input:
  tuple path (sampleBam), val (_)
  path (snps_ref)
  path (file_fa)
  tuple val(sampleId), val(path),path(_), path(_)
  path (indexFiles)

  exec:
  path_sample_snp_fingerprint = path + "/snp_fingerprint/" + sampleId
  strVCFgz = sampleId + '.vcf.gz'
  
  output:
  path ("*.vcf.gz")

  script:
  """
  FASTA=`find -L ./ -name "*.fa"`
  bcftools mpileup -Ou -R $snps_ref -f \$FASTA $sampleBam | bcftools call -c | bgzip > $strVCFgz
  """

}
