##Author: Jorge Ceballos
##Description: Kubernetes Log Analyzer by pattern
import kubernetes
from kubernetes import client, config
import os
from datetime import datetime

def analyze_logs(log_pattern):
    config.load_kube_config()  # Load the Kubernetes configuration

    # Initialize a Kubernetes API client
    api_instance = client.CoreV1Api()

    report = []  # List to store log analysis results
    try:
        # List all pods in a specific namespace
        pods = api_instance.list_namespaced_pod(namespace="default")
        for pod in pods.items:
            pod_name = pod.metadata.name
            container_name = pod.spec.containers[0].name  # Assuming the first container

            # Get logs from the pod
            logs = api_instance.read_namespaced_pod_log(
                name=pod_name, namespace="default", container=container_name
            )
            # Check if the log contains the specified pattern
            if log_pattern in logs:
                report.append(f"Pod: {pod_name}, Container: {container_name}")

    except kubernetes.client.exceptions.ApiException as e:
        print(f"Exception when calling CoreV1Api: {e}")

    return report

if __name__ == '__main__':
    log_directory = os.path.join(os.path.dirname(os.path.dirname(os.getcwd())), "scripts/optimization/logs/pods")  # Update with the actual log directory path
    log_pattern = "Started"  # Update with the pattern you want to monitor  
    report_file_path = os.path.join(log_directory, "log_analysis_report.txt")

    report = analyze_logs(log_pattern)

    if report:
        # Generate a timestamp for the report
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        report.insert(0, f"Log Analysis Report: ({timestamp}). Instances ({log_pattern}) correctly")

        # Write the report to a file
        with open(report_file_path, "w") as report_file:
            report_file.write("\n".join(report))

        print("Log analysis report generated.")
    else:
        print("No logs matching the pattern found.")

