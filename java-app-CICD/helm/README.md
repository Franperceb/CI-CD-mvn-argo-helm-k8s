



# Helm Chart for Spring Boot Application
---
This document explains how to create and use a Helm chart to package and deploy your Spring Boot application on Kubernetes. Helm charts are a valuable tool for simplifying the management of Kubernetes applications.

## Create a Helm Chart

To create a Helm chart for your Spring Boot application, execute the following command:

```bash
helm create spring-boot-app-chart
```
This will generate the basic Helm chart structure with directories and files.

# Packaging and Installing the Helm Chart

After creating your Helm chart for the Spring Boot application, you can package and install it with the following steps.

1. Package the Helm Chart
To package your Helm chart into a tarball (`.tgz`) file, run the following command:
    ```bash
    helm package spring-boot-app-chart
    ```
2. Install the Helm Chart
Now, you can install your Helm chart on your Kubernetes cluster by using the following command:
    ```bash
    helm install spring-boot-app ./spring-boot-app-chart-0.1.0.tgz
    ```

This command will deploy the Spring Boot application along with any associated configurations, such as ConfigMaps and Secrets. These configurations allow you to manage your application's settings and sensitive values separately.
