#!/bin/bash

echo "1. Количество документов в shard1:"
docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit()
EOF
echo -e "\r"

echo "2. Количество документов в shard2:"
docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit()
EOF
echo -e "\r"

echo "3. Общее количество документов:"
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
exit()
EOF
echo -e "\r"
