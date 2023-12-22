// Declare syntax version
nextflow.enable.dsl=2

process FASTQC{

    container = "${projectDir}/../singularity-images/depot.galaxyproject.org-singularity-fastqc-0.12.1--hdfd78af_0.img"

    input:
    path reads

    output:
    path "*.html"
    path "*.zip"

    script:
    """
    fastqc -t ${params.threads_num} $reads
    cp *.html ${launchDir}/${params.outdir}/
    cp *.zip ${launchDir}/${params.outdir}/
    """
}

workflow{
    reads = Channel.of(params.reads).collect()
    FASTQC(reads)
}
