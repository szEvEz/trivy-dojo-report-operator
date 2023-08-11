# trivy-dojo-report-operator

The trivy-dojo-report-operator is a Kubernetes operator developed using Kopf and Python. This operator listens for vulnerability reports generated by the Trivy Operator and forwards them to Defect Dojo for further analysis and tracking.

# Features

* Monitor Kubernetes for new Trivy vulnerability reports.
* Push vulnerability reports to a configured Defect Dojo instance.
* Seamless integration with your existing Kubernetes cluster and security workflow.
* Developed using the Pythonic Kopf framework for easy maintenance and extensibility.

# Prerequisites

* A running Kubernetes cluster (minikube, kind, or another environment)
* Trivy Operator installed and configured in the cluster
* An instance of Defect Dojo for storing vulnerability reports

# Installation and usage

* Clone this repository:

```
git clone https://github.com/telekom-mms/trivy-dojo-report-operator.git
cd trivy-dojo-report-operator
```

* Configure Defect Dojo settings in the deployment.yaml file:

Update the environment variables in the Deployment manifest to match your Defect Dojo instance configuration:

```
env:
- name: DEFECT_DOJO_URL
  value: "https://your.defectdojo.instance"
- name: DEFECT_DOJO_API_KEY
  value: "your_defect_dojo_api_key"
```

Replace https://your.defectdojo.instance with the URL of your Defect Dojo instance, and your_defect_dojo_api_key with your API key.

* Deploy the trivy-dojo-report-operator:

```
kubectl apply -f deploy/
```

The operator is now running in your cluster and will monitor for Trivy vulnerability reports and push them to the configured Defect Dojo instance.

# Running locally with Docker

You can also run the operator locally. This way you don't have to install anything in your cluster. Just provide the Defect Dojo URL and API-Key and optionally labels to the docker-run command. You also have to mount your kubeconfig into the container to access the cluster.

```bash
docker pull ghcr.io/telekom-mms/docker-trivy-dojo-operator

docker run -it -v /path/to/your/.kube/config:/root/.kube/config -e DEFECT_DOJO_API_KEY=$DEFECT_DOJO_API_KEY -e DEFECT_DOJO_URL=$DEFECT_DOJO_URL -e LABEL="trivy-operator.resource.name" -e LABEL_VALUE="master-live-server" ghcr.io/telekom-mms/docker-trivy-dojo-operator
```


# Uninstall

To remove the trivy-dojo-report-operator from your cluster, run the following command:

```
kubectl delete -f deploy/
```

# License

