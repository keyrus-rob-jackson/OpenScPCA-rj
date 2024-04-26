profiles{
  standard {
    process.executor = 'local'
    docker.enabled = true
  }

  batch {
    bucketDir = 's3://232123435055-batch/work'
    aws{
      region = 'us-east-1'
      batch.cliPath = '/usr/local/bin/aws'
    }
    process{
      executor = 'awsbatch'
      queue = 'nextflow-batch-default-queue'
      errorStrategy = { task.attempt < 2 ? 'retry' : 'finish' }
      maxRetries = 1
      maxErrors = '-1'
      memory = { 4.GB * task.attempt}
      
      withLabel: cpus_8 {
        cpus = 8
        memory = { 28.GB * task.attempt}
      }
      withLabel: bigdisk {
        queue = 'nextflow-batch-bigdisk-queue'
      }
    }
  }
}
