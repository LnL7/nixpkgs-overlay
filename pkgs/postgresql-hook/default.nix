{ makeSetupHook, postgresql }:

makeSetupHook { deps = [ postgresql ]; } ./setup-hook.sh
