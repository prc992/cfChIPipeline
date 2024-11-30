process json_uropa{
  label 'low_cpu_low_mem'
  tag "Sample - $sampleId"  
  publishDir "$path_sample_peaks", mode : 'copy'

  container = "ubuntu:noble-20231221"

  input:
  tuple val(sampleId), val(path),path(_), path(_)

  output:
  path ('cfchip.json')

  exec:
  path_sample_peaks = path + "/peaks/" + sampleId

  script:
  """
  # Find the .narrowPeak file in the current directory
  BED_FILE=\$(find -L ./ -name "*.narrowPeak")

  # Write the JSON configuration file for UROPA
  echo '{
      "queries": [{
          "feature": "gene",
          "distance": 10000,
          "filter.attribute": "gene_type",
          "attribute.value": "protein_coding",
          "feature.anchor": "start"
      }],
      "show_attributes": ["gene_id", "gene_name", "gene_type"],
      "priority": true,
      "gtf": "gencode.v19.annotation.gtf",
      "bed": "\$BED_FILE"
    }' > cfchip.json
    """
}




process uropa {
  label 'process_medium'
  //Docker Image
  container = "quay.io/biocontainers/uropa:4.0.3--pyhdfd78af_0"

  tag "Sample - $sampleId"  
  publishDir "$path_sample_peaks", mode : 'copy'
  
  input:
  tuple path(narrowpeak),val(_)
  path (json_file)
  each path (gtf_file)
  tuple val(sampleId), val(path),path(_), path(_)

  exec:
  path_sample_peaks = path + "/peaks/" + sampleId
  
  output:
  path ('*finalhits.bed')
  
  script:
  """
  uropa -i $json_file -t $task.cpus --summary
  """
}
