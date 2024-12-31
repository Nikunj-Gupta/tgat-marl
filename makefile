all: 
	clear 
	python3 src/main.py --config=qmix --env-config=pogema with env_args.size=10 env_args.density=0 seed=0 
	python3 src/main.py --config=qmix --env-config=pogema with env_args.size=10 env_args.density=0 seed=1 
	python3 src/main.py --config=qmix --env-config=pogema with env_args.size=10 env_args.density=0 seed=2 
	python3 src/main.py --config=qmix --env-config=pogema with env_args.size=10 env_args.density=0 seed=3 