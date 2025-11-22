
# Code-Q

A DevOps project demonstrating full infrastructure setup, containerization, deployment, and monitoring for a microservice-style application.

---

## Setup & Deployment Instructions

### Prerequisites
- Terraform installed 
- Docker installed and running  
- Access to a container registry (Docker Hub, GitLab Registry, etc.)  
- Kubernetes cluster configured and accessible (`kubectl`)  
- GitLab CI/CD runner (or equivalent) with proper permissions  
- Secrets and credentials securely stored (registry, kubeconfig, cloud provider)

### Infrastructure Provisioning
1. Clone the repository:
```bash
git clone https://github.com/AhmedBahaa7/code-q.git
cd code-q
```

2. Configure Terraform variables in `terraform/variables.tf` or a `.tfvars` file.  
3. Initialize and apply Terraform:
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Building & Pushing Docker Images
1. Navigate to each service folder in `dockerfiles/`.  
2. Build Docker image:
```bash
docker build -t <registry>/service-name:latest .
```
3. Push image to registry:
```bash
docker push <registry>/service-name:latest
```

### Deploying to Kubernetes
1. Ensure your cluster context is correct:
```bash
kubectl config use-context <cluster-context>
```
2. Apply base manifests:
```bash
kubectl apply -f k8s/base/
```
3. Apply environment-specific overlays (e.g., production):
```bash
kubectl apply -f k8s/overlays/prod/
```
4. Verify deployment:
```bash
kubectl get pods,svc -n <namespace>
```

---

## Design Decisions & Trade-offs

### Infrastructure as Code
- **Decision**: Terraform for cloud infrastructure provisioning.
- **Pros**: Declarative, versionable, multi-cloud support.
- **Cons**: State management complexity; risk of accidental resource changes.
- **Trade-offs considered**: Manual provisioning (fast but not reproducible); CloudFormation (less flexible for multi-cloud).

### Containerization
- **Decision**: Docker for all microservices.
- **Pros**: Consistent environment across dev/CI/prod; easy scaling and deployment.
- **Cons**: Overhead in image management; debugging inside containers can be harder.
- **Trade-offs considered**: Running directly on VMs (simpler but less scalable).

### Kubernetes Deployment
- **Decision**: Declarative manifests with environment overlays.
- **Pros**: Versionable deployments, scaling, self-healing.
- **Cons**: Steep learning curve; added complexity.
- **Trade-offs considered**: Docker Swarm (simpler but less flexible); serverless (less control).

### CI/CD
- **Decision**: GitLab CI/CD pipeline to build, push, and deploy images.
- **Pros**: Automation, reproducibility, integration with GitLab.
- **Cons**: Runner setup required; pipeline maintenance overhead.
- **Trade-offs considered**: Jenkins/GitHub Actions (more setup), GitOps (more complex).

### Monitoring & Observability
- **Decision**: Prometheus + Grafana for metrics and dashboards.
- **Pros**: Visibility into cluster and app health; alerts on issues.
- **Cons**: Resource overhead; operational burden.
- **Trade-offs considered**: Cloud-managed monitoring (less setup but less portable); logging-only stack (cheaper but less informative).
