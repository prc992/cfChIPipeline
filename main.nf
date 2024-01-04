 #! /usr/bin/env nextflow
nextflow.enable.dsl=2

include {mk_dir} from './modules/mk_dir'
include {lib_complex} from './modules/lib_complex'
include {mk_dir_samples} from './modules/mk_dir_samples'
include {fastqc} from './modules/fastqc'
include {align} from './modules/align'
include {sort_bam} from './modules/sort_bam'
include {unique_sam} from './modules/unique_sam'
include {enrichment} from './modules/enrichment'
include {index_sam} from './modules/index_sam'
include {dedup} from './modules/dedup'
include {dac_exclusion} from './modules/dac_exclusion'
include {fetch_chrom_sizes} from './modules/fetch_chrom_sizes'
include {peak_bed_graph} from './modules/peak_bed_graph'
include {bam_to_bed} from './modules/bam_to_bed'
include {unique_frags} from './modules/unique_frags'
include {trim} from './modules/trim'
include {snp_fingerprint} from './modules/snp_fingerprint'
include {bedGraphToBigWig} from './modules/bedGraphToBigWig'
include {lenght_fragment_dist_step1} from './modules/lenght_fragment_dist_step'
include {lenght_fragment_dist_step2} from './modules/lenght_fragment_dist_step'
include {pileups_report} from './modules/pileups_report'
include {uropa} from './modules/uropa'
include {json_uropa} from './modules/uropa'

workflow {

    chSampleInfo = Channel.fromPath(params.samples) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sampleId,row.path, row.read1, row.read2) }

    //Auxiliar code
    chEnrichmentScript= Channel.fromPath("$params.pathEnrichmentScript")
    chRfrag_plotFragDist = Channel.fromPath("$params.pathRfrag_plotFragDist")
    chRComparison = Channel.fromPath("$params.pathRComparison")
    chRPileups= Channel.fromPath("$params.pathRPileups")
    chJson_file = Channel.fromPath("$params.pathJson_file")


    //Assets
    chGTF_ref = Channel.fromPath("$params.gtf_ref")
    chPileUpBED = Channel.fromPath("$params.genes_pileup_report")
    //chFilesRef = Channel.fromPath("$params.files_ref_genome")

    //chSampleDir = mk_dir(chSampleInfo)
    //chSampleDirPileUps = mk_dir_pile_ups_comp(chSampleInfo)
    //chDirAnalysis = mk_dir_samples(chSampleInfo,chSampleDir)

    ch_fasta = Channel.fromPath("$params.align_ref",type: 'dir' )

    fastqc(chSampleInfo)
    chTrimFiles = trim(chSampleInfo)
    chAlignFiles = align(chTrimFiles,chSampleInfo,ch_fasta)
    /*chSortedFiles = sort_bam(chAlignFiles,chSampleInfo,chDirAnalysis)
    lib_complex(chSortedFiles,chSampleInfo,chDirAnalysis)
    chUniqueFiles = unique_sam(chSortedFiles,chSampleInfo,chDirAnalysis)
    chDedupFiles = dedup(chUniqueFiles,chSampleInfo,chDirAnalysis)
    chDACFiles = dac_exclusion(chDedupFiles,chSampleInfo,chDirAnalysis)

    chIndexFiles = index_sam(chDedupFiles,chSampleInfo,chDirAnalysis)
    chPeakFiles = peak_bed_graph(chDedupFiles,chSampleInfo,chDirAnalysis)
    chJson_file = json_uropa(chSampleInfo,chDirAnalysis)
    uropa(chPeakFiles,chJson_file,chGTF_ref,chSampleInfo,chDirAnalysis)

    chBedFiles = bam_to_bed(chDedupFiles,chSampleInfo,chDirAnalysis)
    unique_frags(chBedFiles,chSampleInfo,chDirAnalysis)
    chChromSizes = fetch_chrom_sizes(chSampleInfo,chDirAnalysis)
    snp_fingerprint(chDedupFiles,chSampleInfo,chDirAnalysis)

    enrichment(chEnrichmentScript,chDedupFiles,chSampleInfo,chDirAnalysis)
    chFragDis = lenght_fragment_dist_step1(chDedupFiles,chSampleInfo,chDirAnalysis)
    lenght_fragment_dist_step2(chRfrag_plotFragDist,chFragDis,chSampleInfo,chDirAnalysis)

    chBWFiles = bedGraphToBigWig(chChromSizes,chPeakFiles,chSampleInfo,chDirAnalysis)
    pileups_report(chSampleInfo,chDirAnalysis,chChromSizes,chBWFiles,chPileUpBED,chRPileups)*/

    //Collect all files output and the pass to me program that will merge then
    //chAllFiles = chBWFiles.collectFile()
    //pileups_report_comp(chSampleDirPileUps,chChromSizes,chAllFiles,chPileUpBED,chRComparison)
}

