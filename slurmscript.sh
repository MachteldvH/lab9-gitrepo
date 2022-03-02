#!/bin/bash -login
#SBATCH -p med2                # use 'med2' partition for medium priority
#SBATCH -J myjob               # name for job
#SBATCH -c 1                   # 1 core
#SBATCH -t 1:00:00             # ask for an hour, max
#SBATCH --mem=2000             # memory (2000 mb = 2gb)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mvanheule@ucdavis.edu

# initialize conda
. ~/mambaforge/etc/profile.d/conda.sh

# activate your desired conda environment
conda activate smash

# fail on weird errors
set -e
set -x

### YOUR COMMANDS GO HERE ###
# for example,
snakemake -j 2
### YOUR COMMANDS GO HERE ###

# Print out values of the current jobs SLURM environment variables
env | grep SLURM

# Print out final statistics about resource use before job exits
scontrol show job ${SLURM_JOB_ID}

sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
