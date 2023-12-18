process bam_to_bed {
  queue = "$params.queue"

  //Docker Image
  container ='quay.io/biocontainers/bedtools:2.30.0--hc088bd4_0'

  tag "$sampleId" 
  publishDir "$path_sample_peaks", mode : 'copy'
  
  input:
  tuple path (sampleBam), path(_)
  tuple val(sampleId), val(_),path(_), path(_)
  tuple val (_),val (_),val(_),val (_),val(path_sample_peaks), val(_),val(_)

  exec:
  String strBed = sampleId + '.bed'

  output:
  path ('*.bed')

  script:
  """
  bedtools bamtobed -i \\
  $sampleBam -bedpe 2> /dev/null | \\
  awk 'BEGIN{{OFS="\t";FS="\t"}}(\$1==\$4){{print \$1, \$2, \$6}}' > $strBed
  """
}