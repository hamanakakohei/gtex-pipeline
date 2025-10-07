import "<absolute_path_to>/workflows/tasks/star.edit.wdl" as star_wdl
import "<absolute_path_to>/workflows/tasks/markduplicates.edit.wdl" as markduplicates_wdl
import "<absolute_path_to>/workflows/tasks/rsem.edit.wdl" as rsem_wdl
import "<absolute_path_to>/workflows/tasks/rnaseqc2.edit.wdl" as rnaseqc_wdl


workflow rnaseq_pipeline_fastq_workflow {

    String prefix

    #call fastqc_wdl.fastqc {}

    call star_wdl.star {
        input: prefix=prefix
    }

    call markduplicates_wdl.markduplicates {
        input: input_bam=star.bam_file, prefix=prefix
    }

    call rsem_wdl.rsem {
        input: transcriptome_bam=star.transcriptome_bam, prefix=prefix
    }

    call rnaseqc_wdl.rnaseqc2 {
        input: bam_file=markduplicates.bam_file, sample_id=prefix
    }
}
