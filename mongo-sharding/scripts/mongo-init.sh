#!/bin/bash

# echo "1. Инициализация Config Server ..."
# docker compose exec -T configSrv mongosh --port 27017 --quiet <<EOF
# rs.initiate({
#   _id : "config_server",
#      configsvr: true,
#   members: [
#     { _id : 0, host : "configSrv:27017" }
#   ]
# });
# EOF

# echo "2. Инициализация Shard1 ..."
# docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
# rs.initiate({
#   _id : "shard1",
#   members: [
#     { _id : 0, host : "shard1:27018" },
#   ]
# });
# EOF

# echo "3. Инициализация Shard2 ..."
# docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
# rs.initiate({
#   _id : "shard2",
#   members: [
#     { _id : 1, host : "shard2:27019" },
#   ]
# });
# EOF

# echo "4. Инициализация Router ..."
# docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
# sh.addShard("shard1/shard1:27018");
# sh.addShard("shard2/shard2:27019");
# sh.enableSharding("somedb");
# sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );
# EOF

echo "5. Наполнение БД данными ..."
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
use somedb;
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i});
exit();
EOF
