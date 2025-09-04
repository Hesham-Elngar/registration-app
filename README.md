# Registration App Deployment with Jenkins, Ansible, Docker, and Kubernetes

This project automates the deployment of a Registration App using **CI/CD pipelines** with Jenkins, Ansible, Docker, and Kubernetes (EKS).  

---

## 🚀 Project Overview
The pipeline performs the following tasks:
1. **Code Checkout** from GitHub.
2. **Build & Package** the application into a Docker image.
3. **Push Image** to DockerHub.
4. **Provision Infrastructure** using Ansible.
5. **Deploy Application** to a Kubernetes EKS Cluster.
6. **Verify Deployment** by checking running Pods and Services.

## 📂 Project Structure
``` text
Registration-App/
│── webapp/ 
│── server/ 
│── inventory/ # Ansible inventory file
│── playbooks/ # Ansible playbooks for deployment
├── deployment.yml #k8s deployment
├── service.yml #k8s service 
│── Dockerfile # Application Dockerfile
│── Jenkinsfile # Jenkins pipeline script
│── README.md # Documentation
```

## 🏗️ Project Architecture
<img width="1318" height="535" alt="image" src="https://github.com/user-attachments/assets/2042c44b-edba-4475-883a-70e02e44b021" />

👨‍💻 Developer: Pushes code to GitHub.
⚙️ Jenkins Server: Automates the pipeline using Jenkinsfile (build, test, trigger Ansible).
📦 Ansible Server: Handles Docker image build, push, and Kubernetes deployment.
🐳 DockerHub: Stores container images.
☸️ AWS EKS Cluster: Runs containers & exposes the app to users.

## ⚙️ Pipeline Flow
1. **Source Stage**: Jenkins fetches code from GitHub.  
2. **Build Stage**: Jenkins builds Docker image.  
3. **Push Stage**: Docker image pushed to DockerHub.  
4. **Deploy Stage**: Ansible applies K8s manifests to EKS.  

## 🚀 CI/CD Workflow

<img width="1104" height="865" alt="image" src="https://github.com/user-attachments/assets/925d6af4-4c8f-4353-8aea-c6f0ee6bd4ac" />

More Detailed (Inside the EKS Cluster)
<img width="1155" height="681" alt="image" src="https://github.com/user-attachments/assets/7f8af1ed-6882-4969-bcd4-2e39ae45203a" />


```text
+----------------+
|   Developer    |
|----------------|
| 1. Push Code   |
|    to GitHub   |
+----------------+
        | (Webhook / Poll SCM)
        v
+----------------+
| Jenkins Server |
|----------------|
| 1. Checkout    |
| 2. Build WAR   |
| 3. Unit Tests  |
| 4. Archive     |
|    Artifact    |
| 5. Run Ansible |
+----------------+
        | (SSH + Ansible Playbook)
        v
+----------------+
| Ansible Server |
|----------------|
| - Build Docker |
|   Image        |
| - Push Image   |
|   to Registry  |
| - Deploy App   |
|   (K8s)        |
+----------------+
        | (Docker Registry Push)
        v
+----------------+
|   DockerHub    |
+----------------+
        | (Pull Image)
        v
+----------------+
|  K8s Cluster   |
|----------------|
| - Run Pods     |
| - Expose App   |
+----------------+
        |
        v
+----------------+
|   End Users    |
|----------------|
| Access via LB  |
+----------------+
```

---
## 🛠️ Tools & Technologies

Jenkins 🟢 – CI/CD pipeline \
Ansible 🧩 – Infrastructure as Code (IaC) \
Docker 🐳 – Containerization \
Kubernetes (EKS) ☸️ – Orchestration platform \
AWS EKS 🌐 – Managed Kubernetes service

---

## 📸 Screenshots

- Ansible run playbook via pipelines 
<img width="1426" height="623" alt="Screenshot 2025-09-01 224442" src="https://github.com/user-attachments/assets/aa0a1d0a-39b4-44af-a079-98a4903b5634" />
<img width="1417" height="583" alt="Screenshot 2025-09-01 224427" src="https://github.com/user-attachments/assets/03b1ae42-c1f9-4cf6-8c06-b03f084ec7f3" />

- Docker image pushed to DockerHub 🐳  
<img width="1917" height="785" alt="Screenshot 2025-09-02 193816" src="https://github.com/user-attachments/assets/31bc69bd-832f-4a8a-8ed3-faa9211649f9" />
  
- EKS pods running ⚡  
<img width="1611" height="450" alt="Screenshot 2025-09-01 200108" src="https://github.com/user-attachments/assets/fa458d04-dff1-4e4c-9d66-6fc2f3d8e0f7" />

- Application exposed and hosted on AWS🌍  
<img width="1919" height="715" alt="Screenshot 2025-09-01 195909" src="https://github.com/user-attachments/assets/4a718041-53cc-4ed4-a2e9-93254521d57e" />


## 🚀 Future Improvements

Add Monitoring (Prometheus + Grafana). \
Add GitOps approach with ArgoCD/Flux.


