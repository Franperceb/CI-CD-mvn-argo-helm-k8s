## Author: Jorge Ceballos
#  Description: Connects to the Minikube cluster, install the Helm chart for the Spring Boot application, and verify the components created along with their logs.

#!/bin/bash
KUBE_CONTEXT="minikube"
HELM_RELEASE="dev"
HELM_CHART_PACKAGE="$(pwd | sed 's/\/java-app-CICD\/.*/\/java-app-CICD/')/helm/spring-boot-app-chart-0.1.0.tgz"
echo "$HELM_CHART_PACKAGE"
NAMESPACE="default"
CHART_NAME=$(basename "$HELM_CHART_PACKAGE" | sed 's/-[^-]*.tgz$//')

# Function to check for errors in application logs
check_application_logs() {
  local pod_name
  pod_name="$(kubectl get pods -n "$NAMESPACE" -l app=$CHART_NAME -o jsonpath='{.items[0].metadata.name}')"

  if [ -n "$pod_name" ]; then
    echo "Checking logs for pod: $pod_name"
    kubectl logs -n "$NAMESPACE" "$pod_name" 
  else
    echo "No pods found for your application."
  fi
}


echo $CHART_NAME
#Check if the k8s context exists
if kubectl config get-contexts "$KUBE_CONTEXT" &> /dev/null; then
    echo "Switching to Kubernetes context: $KUBE_CONTEXT"
    kubectl config use-context "$KUBE_CONTEXT"

    echo "Current context:"
    kubectl config current-context
else
    echo "Kubernetes context not found: $KUBE_CONTEXT"
    exit 1
fi


# Install the Helm chart for the web application
helm upgrade --install $HELM_RELEASE  $HELM_CHART_PACKAGE --namespace $NAMESPACE

# Wait for the Deployment to be ready
kubectl rollout status deployment/$HELM_RELEASE-$CHART_NAME -n $NAMESPACE

# Verify that the Service, ConfigMap, and Secret have been created
kubectl get service $HELM_RELEASE-$CHART_NAME-service -n $NAMESPACE
kubectl get configmap $HELM_RELEASE-$CHART_NAME-config -n $NAMESPACE
kubectl get secret $HELM_RELEASE-$CHART_NAME-secret -n $NAMESPACE

# Check application logs for errors
check_application_logs