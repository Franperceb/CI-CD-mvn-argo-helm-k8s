# Scripting for Spring Boot Application
---
### Infrastructure as Code
This Terraform code deploys an Amazon Web Services (AWS) instance running SonarQube, a code analysis and management tool. The infrastructure consists of an AWS EC2 instance and a security group for SSH, HTTPS, and SonarQube access.
#### Running Terraform
##### Prerequisites

Before you begin, make sure you have Terraform installed. You can download Terraform from the [official website](https://www.terraform.io/downloads.html) and follow the installation instructions for your specific operating system.

1. Prepare Your Terraform Configuration
Open a terminal and navigate to the directory containing your Terraform configuration files. Run the following command to initialize the working directory:
    ```sh
    terraform init
    ```
2. Create an execution plan
    ```sh
    terraform plan
    ```
3. Apply the changes
    ```sh
    terraform apply
    ```
4. Destroy Infrastructure (optional)
If you need to tear down the infrastructure you've created, you can use the following command:
    ```sh
    terraform destroy
    ```

### Configuration management 

#### Ansible: Install SonarQube

This Ansible playbook automates the installation of SonarQube on the target hosts. SonarQube is a code analysis and management tool that helps maintain code quality.

##### Prerequisites

Before running this playbook, ensure that you have:

- Ansible installed on the control machine.
- Access to target hosts where SonarQube will be installed.
- The necessary variables set in `secrets.yml` for authentication or configuration.
- Modify on the inventory.ini: ansible_host **( ansible_host=<public-ip-address-of-ec2-instance>)**
- **ask-vault-pass=ansible**

#### Running the ansible playbook
```sh
    ansible-playbook -i inventory.ini ansible-playbook.yaml --ask-vault-pass 
```
## Running the Bash script
This Bash script connects to a Minikube cluster, installs a Helm chart for a Spring Boot application, and verifies the components created along with their logs. The script simplifies the process of deploying the Spring Boot application in a Kubernetes cluster.
##### Prerequisites
Before running this script, ensure you have the following:
- Minikube and Helm installed on your local machine.
- A Minikube cluster set up and running.
- The Helm chart package.

##### Script Execution
1. Navigate to the Script Directory
```sh
    cd java-app-CICD/scripts/optimization
```
2. Run the script
```sh
    ./deploy.sh
```

# Kubernetes Log Analyzer

This **Python script** analyzes logs from Kubernetes pods to check if they contain a specified pattern. It uses the Kubernetes Python client to fetch logs from pods and identify instances where the log pattern is present. The script generates a report with details about the pods and containers where the pattern was found.

## Prerequisites

Before using this script, ensure you have the following:

- Python3 installed on your machine.
- The Kubernetes Python client library (`kubernetes`) installed.
- A valid Kubernetes configuration. You should have the necessary permissions to access the desired namespace and pods.

## Execution
1. Change your working directory to the directory where the script is located:
```sh
    cd /path/to/monitor-pods.py
```
2. Open the Python script and update the following variables according to your requirements:
    - **log_directory**: Path to the directory where the log analysis report will be saved.
    - **log_pattern**: The specific log pattern you want to monitor for.
    - **namespace**: The Kubernetes namespace in which you want to analyze logs.

Execute the script with the following command:
```sh
    python3 monitoring-pods.py 
```

For more information about the python script, **read instruction.txt**







