#!/bin/bash

echo "Общее количество документов и распределение:"
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
db.helloDoc.getShardDistribution()
EOF
echo -e "\r"

echo "Состояние RS (кратко):"
docker compose exec -T shard1-1 mongosh --quiet --port 27018 --eval "rs.status().members.map(m=>m.stateStr)"
docker compose exec -T shard2-1 mongosh --quiet --port 27019 --eval "rs.status().members.map(m=>m.stateStr)"
echo -e "\r"

echo "Запросы оценки эффективности кэша:"

# первый запрос (cache miss)
curl -s -o /dev/null -w "Time: %{time_total}s\n" http://localhost:8080/helloDoc/users

# второй запрос (cache hit)
curl -s -o /dev/null -w "Time: %{time_total}s\n" http://localhost:8080/helloDoc/users

echo -e "\r"
