# Test repo setup for argocd

This repo contains:
* k3d config for local kubernetes cluster
* helm charts for argocd and argocd apps with configured repo
* python application with Dockerfile and helm chart

## Setup

At first setup k3d cluster for local development:

```bash
k3d cluster create -c k3d.yaml
```

Then install argocd:

```bash
helm upgrade --install --namespace argocd --create-namespace argo deploy/helm/argocd --set argocd-apps.enabled=false
```

If you want to see NOTES.txt from argo-cd chart, you man add `--render-subchart-notes` flag.

We set `argocd-apps` to false, because the chart installs CRDs and we want to install them before
adding argocd-apps.
Actually, sometimes people add CRDs before running any helm commands. But let's keep it that way.

```bash
helm upgrade --install --namespace argocd --create-namespace argo deploy/helm/argocd --set argocd-apps.enabled=true
```

Now we need to get the secret from argocd secret that contains admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Of course, if you've used different namespace or release name, you need to change them in the command above to get the correct secret.

After login you will see the application up and running.