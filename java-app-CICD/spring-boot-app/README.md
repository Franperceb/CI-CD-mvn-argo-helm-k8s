# Spring Boot Java Web Application
---
This part of the repo showcases a simple Java application built with Maven and Spring Boot, offering a practical example of an MVC architecture web application.

## Getting Started with the Application

Follow these steps to run the Spring Boot Java web application locally:

### Prerequisites

- Java Development Kit (JDK) 11
- Git
- Maven

1.**Clone the repository:**
   ```sh
     https://github.com/Franperceb/CI-CD-mvn-argo-helm-k8s.git
     cd java-app-CICD/spring-boot-app
   ```
2.**Build the application**
   ```sh
    mvn clean package
   ```
### Running the Application Locally
1. Execute the following command to start the application:
   ```sh
    java -jar target/spring-boot-web.jar
   ```
2. Access the application in your browser at http://localhost:8080.

## Running on docker 
1. Build the Docker image:
   ```sh
    docker build -t ultimate-cicd-pipeline:v1 .
   ```
2. Run the Docker container:
   ```sh
    docker run -d -p 8010:8080 -t ultimate-cicd-pipeline:v1
   ```
3. Access the application in your browser at  http://<ip-address>:8010.



