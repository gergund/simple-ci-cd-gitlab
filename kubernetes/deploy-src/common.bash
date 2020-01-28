#!/usr/bin/env bash

echo_test() {
	echo "Common BASH script is running ..."
}

create_kubeconfig() {
  [[ -z "$KUBE_URL" ]] && return

  echo "Generating kubeconfig..."
  export KUBECONFIG="$(pwd)/kubeconfig"
  export KUBE_CLUSTER_OPTIONS=
  if [[ -n "$KUBE_CA_PEM" ]]; then
    echo "Using KUBE_CA_PEM..."
    echo "$KUBE_CA_PEM" > "$(pwd)/kube.ca.pem"
    export KUBE_CLUSTER_OPTIONS=--certificate-authority="$(pwd)/kube.ca.pem"
  fi
  kubectl config set-cluster gitlab-deploy --server="$KUBE_URL" \
    $KUBE_CLUSTER_OPTIONS
  kubectl config set-credentials gitlab-deploy --token="$KUBE_TOKEN" \
    $KUBE_CLUSTER_OPTIONS
  kubectl config set-context gitlab-deploy \
    --cluster=gitlab-deploy --user=gitlab-deploy \
    --namespace="$KUBE_NAMESPACE"
  kubectl config use-context gitlab-deploy
  echo ""
  export KUBECONFIG="$(pwd)/kubeconfig"
}


echo_test
create_kubeconfig
