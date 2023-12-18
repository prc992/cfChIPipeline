process pileups_report{
  errorStrategy { sleep(Math.pow(2, task.attempt) * 200 as long); return 'retry' }
  maxRetries 5
  memory '8 GB'

  tag "$sampleId" 

  //Docker Image
  container ='prc992/pileups-report:v1.1'
  publishDir "$path_sample_pile_ups", mode : 'copy'

  input:
  tuple val(sampleId), val(_),val(_), val(_)
  tuple val (_),val(_),val(_),val (_),val(_), val(_),val(path_sample_pile_ups)
  path (chChromSizes)
  tuple path (_),path (treat_pileup_bw)
  path (chBED)
  path (chRPileups)

  exec:
  //Here we extract the reference genome from the param align_ref
  //using string manipulation
  int inicio = params.align_ref.lastIndexOf('/')
  int fim = params.align_ref.indexOf('.fa')
  String refGenome = params.align_ref.substring(inicio+1,fim)

  output:
  path ('*.pdf')

  script:
  """
  Rscript $chRPileups $treat_pileup_bw $chBED $chChromSizes $refGenome
  """
}
