docker build -t amitkumar20491/multi-client:latest -t amitkumar20491/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amitkumar20491/multi-server:latest -t amitkumar20491/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amitkumar20491/multi-worker:latest -t amitkumar20491/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push amitkumar20491/multi-client:latest
docker push amitkumar20491/multi-server:latest
docker push amitkumar20491/multi-worker:latest
docker push amitkumar20491/multi-client:$SHA
docker push amitkumar20491/multi-server:$SHA
docker push amitkumar20491/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amitkumar20491/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=amitkumar20491/multi-worker:$SHA
kubectl set image deployments/client-deployment client=amitkumar20491/client-server:$SHA