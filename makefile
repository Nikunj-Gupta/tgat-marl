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
