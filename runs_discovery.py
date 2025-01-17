import os

RUNS_DIRECTORY = "runs_discovery_pogema_baselines/" 
PARTITION = "main"

# We'll just create ONE job file, e.g. "parallel_runs.job".
ONE_JOB_FILE_NAME = "parallel_runs.job"

def write_run_file(content, filename):
    os.makedirs(RUNS_DIRECTORY, exist_ok=True)
    with open(os.path.join(RUNS_DIRECTORY, filename), "w") as f:
        f.write(content)

# 1. SLURM header for the single script:
slurm_header = f"""#!/bin/bash
#SBATCH --account=prasanna_1363
#SBATCH --partition={PARTITION}
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128G
#SBATCH --time=10:00:00

conda activate dcg
module load gcc/11.3.0 git/2.36.1

echo "Starting parallel job script"
"""

threads=5 
gpu_input=6 

gpus_list = gpu_input.split(",")

DENSITIES = ["0", "0.1", "0.2", "0.3"] 
SIZES = ["10", "40", "80"] 
SEEDS = 5 

"""
Baselines 
"""
commands = []
count = 0 
for s in range(SEEDS): 
    for sz in SIZES:
        for d in DENSITIES: 
                gpu = gpus_list[count % len(gpus_list)]
                cmd = f""" CUDA_VISIBLE_DEVICES={gpu} python3 src/main.py --config=qmix --env-config=pogema with env_args.size={sz} env_args.density={d} seed={s}""" 
                commands.append(cmd)
                count+=1
                if count % threads == 0: wait