function _create_cluster () {
    kind create cluster --config \
    config/config.yaml --name "$CLUSTER_NAME"

    [ $ENABLE_INGRESS -eq 1 ] && _deploy_ingress
    [ $ENABLE_METALLB -eq 1 ] && _deploy_metallb
 _clean    
}

function _deploy_ingress () {
    kubectl apply -f config/nginx/ingress.yaml
}

function _deploy_metallb () {
    kubectl apply -f config/metallb/metallb.yaml
}

function _help () {
    echo "
$ ./cluster.sh [parâmetros]

Parâmetros aceitos:
  --no-ingress - Não fará o deploy do NGINX Ingress.
  --no-metallb - Não fará o deploy do Metal LB.
  --cluster-name <nome> - Informa qual será o nome do cluster criado.
  -h | --help - Menu de ajuda.
  "
}

function _error () {
    echo "O parâmetro $1 não existe"
    _help
    exit 1
}


function _clean () {
    rm -f get-docker.sh
}