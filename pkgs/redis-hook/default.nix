{ makeSetupHook, redis }:

makeSetupHook { deps = [ redis ]; } ./setup-hook.sh
