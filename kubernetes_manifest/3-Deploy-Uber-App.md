# Deploy The Uber App

Once the AKS cluster is built and the Kubernetes manifest is ready, you're now ready to deploy the Kubernetes manifest.

1. `cd` into the `kubernetes_manifest` directory
2. Run the following commands:
- Install ALB Controller (You may need to changes these values: [here](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/main/kubernetes_manifest/scripts/1-install-alb-controller.sh#L3-8) ):
`./scripts/1-install-alb-controller.sh`
- Install Gateway API resources (You may need to changes these values: [here](https://github.com/thomast1906/DevOps-The-Hard-Way-Azure/tree/main/kubernetes_manifest/scripts/2-gateway-api-resources.sh#L1-3) ):
`./scripts/2-install-gateway-api.sh`
- Deploy the Uber app:
`kubectl create -f deployment.yml`


You'll see an output that specifies the service and deployment was created.

3. Run the following command to confirm that the deployment was successful:
`kubectl get deployments`

4. Access uber-ui via Azure Application Gateway Controller for Containers

`fqdn=$(kubectl get gateway gateway-01 -n alb-devopsthehardway -o jsonpath='{.status.addresses[0].value}')
echo "http://$fqdn"
`

Access the uber-ui using the address mentioned above, example: `http://bye7fxhjesf7enf7.fz32.alb.azure.com`