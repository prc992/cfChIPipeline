process json_uropa{
  queue = "$params.queue"
  tag "$sampleId"

  input:
  tuple val(sampleId), val(_),path(_), path(_)
  tuple val (_),val (_),val(_),val (_),val(path_sample_peaks), val(_),val(_)

  output:
  path ('cfchip.json')

  exec:
  bed_file = sampleId + '_peaks.narrowPeak.bed'

  script:
  """
  echo '{"queries": [' >> cfchip.json
  echo '{"feature":"gene","distance":10000,"filter.attribute" : "gene_type","attribute.value" : "protein_coding","feature.anchor":"start"}],' >> cfchip.json
  echo '"show_attributes":["gene_id", "gene_name","gene_type"],   ' >> cfchip.json
  echo '"priority" : "True",' >> cfchip.json
  echo '"gtf": "gencode.v19.annotation.gtf",' >> cfchip.json
  echo '"bed": "$bed_file"}' >> cfchip.json
  """
}


process uropa {
  queue = "$params.queue"
  memory '8 GB'
  //Docker Image
  container = "quay.io/biocontainers/uropa:4.0.3--pyhdfd78af_0"

  tag "$sampleId" 
  publishDir "$path_sample_peaks", mode : 'copy'
  
  input:
  tuple path(narrowpeak),val(_)
  path (json_file)
  path (gtf_file)
  tuple val(sampleId), val(_),path(_), path(_)
  tuple val (_),val (_),val(_),val (_),val(path_sample_peaks), val(_),val(_)
  
  output:
  path ('*finalhits.bed')
  
  script:
  """
  uropa -i $json_file -t $params.threads --summary
  """
}