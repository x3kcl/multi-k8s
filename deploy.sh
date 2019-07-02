docker build -t x3kcl/multi-client:latest -t x3kcl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t x3kcl/multi-server:latest -t x3kcl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t x3kcl/multi-worker:latest -t x3kcl/multi-worker:$SHA -f ./worker/Dockerfile ./worker
 
docker push x3kcl/multi-client:latest
docker push x3kcl/multi-server:latest
docker push x3kcl/multi-worker:latest

docker push x3kcl/multi-client:$SHA
docker push x3kcl/multi-server:$SHA
docker push x3kcl/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=x3kcl/multi-server:$SHA
kubectl set image deployments/client-deployment client=x3kcl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=x3kcl/multi-worker:$SHA