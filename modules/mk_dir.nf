process mk_dir{
  
  tag "creating dir for $sampleId"

  input:
  tuple val(sampleId), val(path_sample),val(read1), val(read2)
  
  output:
  val (path_sample)

  script:
  """
  mkdir -p $path_sample

  """
}