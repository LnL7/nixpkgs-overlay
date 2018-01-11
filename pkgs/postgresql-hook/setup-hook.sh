declare -a backgroundPids

killPhase() {
  echo "killing background jobs..." >&2

  kill "${backgroundPids[@]}" || kill -9 "${backgroundPids[@]}"
  wait "${backgroundPids[@]}"
}

postPhases+=" killPhase"

postgresqlPhase() {
  runHook prePostgresql

  initdb -U postgres -D $NIX_BUILD_TOP/postgresql

  postgresqlPort=$(shuf -i 2000-65000 -n 1)
  cat <<-EOF > $NIX_BUILD_TOP/postgresql/postgresql.conf
log_destination = 'stderr'
port = $postgresqlPort
EOF

  echo "starting postgresql on port $postgresqlPort..." >&2
  postgres -D $NIX_BUILD_TOP/postgresql -i &
  backgroundPids+=("$!")

  runHook postPostgresql
}

prePhases+=" postgresqlPhase"


exitHook() {
  runHook killPhase
}

failureHook() {
  runHook killPhase
}
