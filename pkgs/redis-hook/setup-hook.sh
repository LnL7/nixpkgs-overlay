declare -a backgroundPids

killPhase() {
  echo "killing background jobs..." >&2

  kill "${backgroundPids[@]}" || kill -9 "${backgroundPids[@]}"
  wait "${backgroundPids[@]}"
}

postPhases+=" killPhase"

redisPhase() {
  runHook preRedis

  redisPort=$(shuf -i 2000-65000 -n 1)
  mkdir $NIX_BUILD_TOP/redis
  cat <<-EOF > $NIX_BUILD_TOP/redis/redis.conf
port $redisPort
bind 127.0.0.1
dir $NIX_BUILD_TOP/redis
EOF

  echo "starting redis on port $redisPort..." >&2
  redis-server $NIX_BUILD_TOP/redis/redis.conf &
  backgroundPids+=("$!")

  runHook postRedis
}

prePhases+=" redisPhase"


exitHook() {
  runHook killPhase
}

failureHook() {
  runHook killPhase
}
