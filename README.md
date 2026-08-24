# Dockerized Multi-Container Web Application

A web application with Docker, Kubernetes configuration, and OCI packaging.

## Overview

This project demonstrates a web application with multiple deployment strategies:

- *Docker Compose* – Local development and testing
- *Kubernetes* – Deployment configuration with GitOps-style updates
- *OCI Rock* – Container image built with Canonical Rockcraft

### Core Components

| Component | Purpose |
|-----------|---------|
| Flask | Backend API (Python) |
| PostgreSQL | Relational database |
| Nginx | Reverse proxy |
| Kubernetes | Container orchestration configuration |
| GitHub Actions | CI/CD automation |

## Table of Contents

- [Architecture](#architecture)
- [Features](#features)
- [Local Development](#local-development)
- [Kubernetes Deployment](#kubernetes-deployment)
- [GitOps Workflow](#gitops-workflow)
- [OCI Rock Packaging](#oci-rock-packaging)
- [Project Structure](#project-structure)
- [Deployment](#deployment)
- [Technologies](#technologies)

## Architecture


┌─────────────┐     ┌──────────┐     ┌────────────┐
│   Browser   │ ──> │  Nginx   │ ──> │   Flask    │
└─────────────┘     └──────────┘     └────────────┘
                           │                │
                           │                ▼
                           │         ┌────────────┐
                           └────────>│ PostgreSQL │
                                     └────────────┘


## Features

- ✅ Dockerized multi-container architecture
- ✅ PostgreSQL with persistent storage (Kubernetes PVC)
- ✅ Nginx reverse proxy
- ✅ Kubernetes Deployments and Services
- ✅ Kustomize for environment-specific configuration
- ✅ GitHub Container Registry (GHCR) for image storage
- ✅ Automated CI/CD with GitHub Actions
- ✅ GitOps-style workflow (image updates committed to Git)
- ✅ OCI Rock packaging with Canonical Rockcraft
- ✅ Immutable image tags (Git commit SHA)

## Local Development

### Prerequisites

- Docker and Docker Compose
- Python 3.10+
- PostgreSQL client (optional)

### Clone and Run

bash
git clone https://github.com/david-onwuka/dockerized-multi-container-flask-app
cd dockerized-multi-container-flask-app
docker-compose up --build


Access the application at http://localhost:80

## Kubernetes Deployment

### Validate Configuration

bash
kubectl kustomize k8s/


### Deploy to Cluster

bash
kubectl apply -k k8s/


### Components

- *Deployments*: Flask (3 replicas), PostgreSQL
- *Services*: Flask (ClusterIP), PostgreSQL (ClusterIP), Nginx (LoadBalancer)
- *Secrets*: Database credentials (Base64 encoded)
- *PVC*: PostgreSQL persistent storage (10Gi)

## GitOps Workflow

The project follows GitOps principles where Git serves as the single source of truth for configuration.


┌──────────────┐     ┌─────────────────┐     ┌────────────────┐
│  Push Code   │ ──> │ GitHub Actions  │ ──> │ Build & Push   │
│  to main     │     │ Build Image     │     │ to GHCR        │
└──────────────┘     └─────────────────┘     └────────────────┘
                                                      │
                                                      ▼
┌─────────────────────────────────────────────────────────────┐
│              Update kustomization.yaml                     │
│     (Automatically commit new image SHA)                  │
└─────────────────────────────────────────────────────────────┘


### Key Practices

1. *Immutable Tags* – Images are tagged with Git commit SHA (sha-<commit>)
2. *Version Control* – All Kubernetes manifests are stored in Git
3. *Automated Updates* – CI updates image references automatically
4. *Declarative Config* – Desired state is defined in YAML manifests

## OCI Rock Packaging

The application is packaged as an OCI-compliant Rock using Canonical Rockcraft.

### Build

bash
rockcraft pack --destructive-mode


Output: dockerized-multi-container-flask-app_0.1_amd64.rock

### Import and Run

bash
sudo rockcraft.skopeo --insecure-policy copy oci-archive:dockerized-multi-container-flask-app_0.1_amd64.rock docker-daemon:flask-rock:latest
docker run -p 8000:8000 flask-rock:latest


### Validation

The Rock was successfully built with Rockcraft 1.20.0 and imported into Docker. The container started successfully with Pebble managing the Gunicorn process, and the Flask application returned an HTTP 200 OK response when accessed on port 8000.

The standalone Rock was tested independently from the PostgreSQL container. Because the external postgres_db service was not available in the standalone Docker network, the application reported a database hostname-resolution error. The HTTP service itself was running and responding to requests.

### Rock Components

- *Base*: Ubuntu 24.04 (minimal)
- *Framework*: Flask with Gunicorn
- *Runtime*: Pebble for service management
- *Dependencies*: libpq5 for PostgreSQL connectivity

## Project Structure


.
├── .github/
│   └── workflows/
│       └── ci-cd.yml              # GitHub Actions pipeline
├── k8s/
│   ├── deployment.yaml            # Flask deployment
│   ├── postgres-deployment.yaml   # PostgreSQL deployment
│   ├── postgres-pvc.yaml          # Persistent volume claim
│   ├── postgres-secret.yaml       # Database credentials
│   ├── service.yaml               # Flask service
│   ├── postgres-service.yaml      # PostgreSQL service
│   ├── nginx-service.yaml         # Nginx service
│   ├── nginx-config.yaml          # Nginx configuration
│   └── kustomization.yaml         # Kustomize configuration
├── app/
│   ├── app.py                     # Flask application
│   └── requirements.txt           # Python dependencies
├── docker-compose.yml
├── Dockerfile
├── rockcraft.yaml                 # Rockcraft specification
└── README.md


## Deployment Options

### Option 1: Docker Compose (Local)
bash
docker-compose up -d


### Option 2: Kubernetes
bash
kubectl apply -k k8s/


### Option 3: OCI Rock (Standalone)
bash
docker run -p 8000:8000 flask-rock:latest


## CI/CD Pipeline

The GitHub Actions workflow automates:

1. Build Docker image
2. Push to GHCR with SHA tag
3. Update kustomization.yaml with new image
4. Commit changes back to repository

## Technologies

### Core
- *Backend*: Flask (Python 3.10)
- *Database*: PostgreSQL
- *Web Server*: Nginx
- *Containerization*: Docker

### Orchestration & Deployment
- *Orchestration*: Kubernetes
- *Configuration*: Kustomize
- *CI/CD*: GitHub Actions
- *Registry*: GitHub Container Registry (GHCR)
- *GitOps*: Git as source of truth

### Packaging
- *Container Builder*: Canonical Rockcraft
- *Service Manager*: Pebble
- *WSGI Server*: Gunicorn

## License

This project is open source and available under the MIT License.

---

*Maintainer*: David Onwuka  
*Repository*: [github.com/david-onwuka/dockerized-multi-container-flask-app](https://github.com/david-onwuka/dockerized-multi-container-flask-app)
