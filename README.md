# Dockerized Multi-Container App

A Dockerized multi-container web application using *Flask, **PostgreSQL, and **Nginx, deployed on **AWS EC2* with automated *CI/CD* using *GitHub Actions*.

## Description
This project demonstrates a complete web application setup with multiple containers:
- *Flask* – Backend API
- *PostgreSQL* – Database
- *Nginx* – Reverse proxy
- Dockerized for easy deployment
- Automated CI/CD pipeline to deploy updates to AWS EC2

## Features
- Dockerized multi-container architecture
- PostgreSQL database integration
- Reverse proxy with Nginx
- Automated CI/CD with GitHub Actions

## Local Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/david-onwuka/dockerized-multi-container-flask-app


## GitOps CI/CD Upgrade

This project was extended with a GitOps-based Kubernetes deployment workflow.

### Architecture

- Flask application containerized with Docker
- PostgreSQL database with persistent storage
- Nginx reverse proxy
- Kubernetes Deployments and Services
- Kubernetes Secret for database configuration
- PersistentVolumeClaim for PostgreSQL storage
- Kustomize for Kubernetes configuration management
- GitHub Container Registry (GHCR) for container images
- GitHub Actions for CI/CD automation

### GitOps Workflow

1. Code is pushed to the main branch.
2. GitHub Actions builds the Docker image.
3. The image is pushed to GHCR using the Git commit SHA as an immutable tag.
4. GitHub Actions automatically updates k8s/kustomization.yaml with the new image SHA.
5. The updated Kubernetes configuration is committed back to Git.
6. Kubernetes configuration remains version-controlled as the desired deployment state.

### Key GitOps Practice

Instead of deploying directly from the CI pipeline, the Kubernetes deployment configuration is maintained in Git. Container image versions are referenced by immutable commit SHA rather than relying on the mutable latest tag.

### Validation

The Kubernetes configuration was validated locally with:

```bash
kubectl kustomize k8s
