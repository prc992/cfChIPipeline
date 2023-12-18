process bedGraphToBigWig {
  queue = "$params.queue"

  //Docker Image
  container = "quay.io/biocontainers/ucsc-bedgraphtobigwig:377--h446ed27_1"

  tag "$sampleId" 
  publishDir "$path_sample_peaks", mode : 'copy'

  input:
  path (RefGenSizes)
  tuple val (_), path (bdgFiles)
  tuple val(sampleId), val(_),path(_), path(_)
  tuple val (_),val (_),val(_),val (_),val(path_sample_peaks), val(_),val(_)

  exec:
  bdgFile1 = bdgFiles.first()
  bdgFile2 = bdgFiles.last()
  bdgFile1_out = bdgFile1 + ".bw"
  bdgFile2_out = bdgFile2 + ".bw"
  fileNameOutput = sampleId + "_treat_pileup.bdg.bw"

  output:
  tuple path (_),path ("$fileNameOutput")


  script:
  """
  bedGraphToBigWig $bdgFile1 $RefGenSizes $bdgFile1_out &&
  bedGraphToBigWig $bdgFile2 $RefGenSizes $bdgFile2_out
  """

}