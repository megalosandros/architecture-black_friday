#!/bin/bash

echo "Общее количество документов и распределение:"
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
db.helloDoc.getShardDistribution()
EOF
echo -e "\r"

echo "состояние RS (кратко):"
docker compose exec -T shard1-1 mongosh --quiet --port 27018 --eval "rs.status().members.map(m=>m.stateStr)"
docker compose exec -T shard2-1 mongosh --quiet --port 27019 --eval "rs.status().members.map(m=>m.stateStr)"
echo -e "\r"
