
export arcPath=$1
export version=$2
export chart=$3

export repoName="AzureK8sAgents"
echo ACRPATH = $arcPath
echo version = $version
echo chart = $chart
echo repoName = $repoName


helm3 repo add $repoName $arcPath
helm3 fetch $repoName/$chart --version $version
export releaseName=`helm3 list --all-namespaces --all | grep $chart | cut -f1 -d$'\t'`
export namespace=`helm3 list --all-namespaces --all | grep $chart | cut -f2 -d$'\t'`
export filename=$chart-$version.tgz
helm3 upgrade $releaseName $filename -n $namespace --install --reuse-values