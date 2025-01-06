#!/bin/bash

set -eu

function color() {
  # Usage: color "31;5" "string"
  # Some valid values for color:
  # - 5 blink, 1 strong, 4 underlined
  # - fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
  # - bg: 40 black, 41 red, 44 blue, 45 purple
  printf '\033[%sm%s\033[0m\n' "$@"
}

if [ "$#" -lt 1 ]; then
  color "31" "Usage: ./cmd.sh PROCESS FLAGS."
  color "31" "PROCESS can be start-api, stop-api"
  exit 1
fi

if [ "$1" = "create-network" ]; then

  docker network create --subnet=172.200.0.0/16 boa_network

elif [ "$1" = "remove-network" ]; then

  docker network rm boa_network

elif [ "$1" = "start-db" ]; then

  docker compose -f ./database/docker-compose.yaml up -d

elif [ "$1" = "stop-db" ]; then

  docker compose -f ./database/docker-compose.yaml down

elif [ "$1" = "start-api" ]; then

  docker compose -f ./api/docker-compose.yml up -d

elif [ "$1" = "stop-api" ]; then

  docker compose -f ./api/docker-compose.yml down

else

  color "31" "Process '$1' is not found!"
  color "31" "Usage: ./cmd.sh PROCESS FLAGS."
  color "31" "PROCESS can be start-api, stop-api"
  exit 1

fi
