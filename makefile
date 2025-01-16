all: 
	clear 

pogema_exps: 
	for s in 0 1 2 3 4 ; do \
		CUDA_VISIBLE_DEVICES=7 python3 src/main.py --config=qmix --env-config=pogema with env_args.size=10 env_args.density=0 seed=$$s ; \
	done 

smacv2_exps: 
	for s in 0 1 2 3 4 ; do \
		CUDA_VISIBLE_DEVICES=7 python3 src/main.py --config=qmix --env-config=sc2_gen_protoss with env_args.capability_config.n_units=5 env_args.capability_config.n_enemies=5 seed=$$s ; \
	done 

pogema_exps_v1: 

    threads=$5 # 2
    gpus=$6    # 0,1

    gpus=(${gpus//,/ })

    if [ ! $threads ]; then
    threads=1
    fi

    if [ ! $gpus ]; then
    gpus=(0)
    fi


    echo "SIZE LIST:" ${sizes[@]}
    echo "DENSITY LIST:" ${densities[@]}
    echo "SEED LIST:" $seeds
    echo "GPU LIST:" ${gpus[@]}
    echo "THREADS:" $threads

    count=0

    for size in "${sizes[@]}"; do
        for density in "${densities[@]}"; do
            for((i=0;i<seeds;i++)); do

                gpu=${gpus[$(($count % ${#gpus[@]}))]}  
                CUDA_VISIBLE_DEVICES="$gpu" python3 src/main.py --config=qmix --env-config=pogema with env_args.size="$size" env_args.density="density" seed="seed" &

                count=$(($count + 1))     
                if [ $(($count % $threads)) -eq 0 ]; then
                    wait
                fi
                # for random seeds
                sleep $((RANDOM % 60 + 60))

            done
        done
    done
