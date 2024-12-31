from functools import partial
import sys
import os

from .multiagentenv import MultiAgentEnv

from smacv2.env import MultiAgentEnv, StarCraftCapabilityEnvWrapper
from .matrix_game import OneStepMatrixGame
from .stag_hunt import StagHunt
from .pogema import PyMarlPogema

try:
    gfootball = True
    from .gfootball import GoogleFootballEnv
except Exception as e:
    gfootball = False
    print(e)

def env_fn(env, **kwargs) -> MultiAgentEnv:
    return env(**kwargs)

REGISTRY = {}
REGISTRY["sc2wrapped"] = partial(env_fn, env=StarCraftCapabilityEnvWrapper)
REGISTRY["stag_hunt"] = partial(env_fn, env=StagHunt)
REGISTRY["one_step_matrix_game"] = partial(env_fn, env=OneStepMatrixGame)
REGISTRY["pogema"] = partial(env_fn, env=PyMarlPogema) 

if gfootball:
    REGISTRY["gfootball"] = partial(env_fn, env=GoogleFootballEnv)

if sys.platform == "linux":
    os.environ.setdefault("SC2PATH", "~/StarCraftII")
