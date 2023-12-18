process mk_dir_samples{
  
  tag "creating dir for $sampleId"

  input:
  tuple val(sampleId), val(path),val(read1), val(read2)
  val(pa)
  
  exec:
  path_sample_align = path + "/align" + "/" + sampleId
  path_sample_trim = path + "/trim" + "/" + sampleId
  path_sample_frag = path + "/frag" + "/" + sampleId
  path_sample_fastqc = path + "/fastqc" + "/" + sampleId
  path_sample_peaks = path + "/peaks" + "/" + sampleId
  path_sample_snp_fingerprint = path + "/snp_fingerprint" + "/" + sampleId
  path_sample_pile_ups = path + "/pile_ups" + "/" + sampleId

  output:
  tuple val (path_sample_align),val (path_sample_trim),val(path_sample_frag),
        val (path_sample_fastqc),val(path_sample_peaks),val(path_sample_snp_fingerprint),
        val(path_sample_pile_ups)

  script:
  """
  mkdir -p $path_sample_trim &&
  mkdir -p $path_sample_align &&
  mkdir -p $path_sample_frag &&
  mkdir -p $path_sample_fastqc &&
  mkdir -p $path_sample_peaks &&
  mkdir -p $path_sample_snp_fingerprint &&
  mkdir -p $path_sample_pile_ups
  """
}