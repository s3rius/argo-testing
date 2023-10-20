poetry version "${1}"
docker build -t "registry.localhost:5000/argo-testing:${1}" .
docker push "registry.localhost:5000/argo-testing:${1}"
yq -iy ".image.tag = \"${1}\"" deploy/envs/in-cluster.yaml
git add .
git commit -m "Bump version to ${1}"