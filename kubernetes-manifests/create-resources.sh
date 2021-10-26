set -x
ACME_SECRET=rubrik
ACME_NAMESPACE=acme-fitness
kubectl create ns ${ACME_NAMESPACE}
kubectl -n ${ACME_NAMESPACE} create secret generic cart-redis-pass --from-literal=password=${ACME_SECRET}
# Create PVC
kubectl -n ${ACME_NAMESPACE} apply -f mongodata_catalog.yaml
kubectl -n ${ACME_NAMESPACE} apply -f mongodata_users.yaml
kubectl -n ${ACME_NAMESPACE} apply -f redisdata-cart.yaml
kubectl -n ${ACME_NAMESPACE} apply -f redisdata-user.yaml
kubectl -n ${ACME_NAMESPACE} apply -f cart-total-data.yaml
kubectl -n ${ACME_NAMESPACE} apply -f order-db-postgress.yaml

kubectl -n ${ACME_NAMESPACE} apply -f cart-redis-total.yaml
kubectl -n ${ACME_NAMESPACE} apply -f cart-total.yaml
kubectl -n ${ACME_NAMESPACE} create secret generic catalog-mongo-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${ACME_NAMESPACE} create -f catalog-db-initdb-configmap.yaml
kubectl -n ${ACME_NAMESPACE} apply -f catalog-db-total.yaml
kubectl -n ${ACME_NAMESPACE} apply -f catalog-total.yaml
kubectl -n ${ACME_NAMESPACE} apply -f payment-total.yaml
kubectl -n ${ACME_NAMESPACE} create secret generic order-postgres-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${ACME_NAMESPACE} apply -f order-db-total.yaml
kubectl -n ${ACME_NAMESPACE} apply -f order-total.yaml
kubectl -n ${ACME_NAMESPACE} create secret generic users-mongo-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${ACME_NAMESPACE} create secret generic users-redis-pass --from-literal=password=${ACME_SECRET}
kubectl -n ${ACME_NAMESPACE} create -f users-db-initdb-configmap.yaml
kubectl -n ${ACME_NAMESPACE} apply -f users-db-total.yaml
kubectl -n ${ACME_NAMESPACE} apply -f users-redis-total.yaml
kubectl -n ${ACME_NAMESPACE} apply -f users-total.yaml
kubectl -n ${ACME_NAMESPACE} apply -f frontend-total.yaml
kubectl -n ${ACME_NAMESPACE} get services -l service=frontend

kubectl -n ${ACME_NAMESPACE} apply -f point-of-sales-total.yaml
