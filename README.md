## Confluent for Kubernetes 

Documentation for this is provided at https://docs.confluent.io/operator/current/overview.html .

This package includes the following:
- The Helm Chart to deploy Confluent for Kubernetes
- kubectl plugin to use and troubleshoot Confluent for Kubernetes

#### Steps for the creation of the cluster

- download the helm cfk bundle
`curl -O https://confluent-for-kubernetes.s3-us-west-1.amazonaws.com/confluent-for-kubernetes-2.5.1.tar.gz`

- create the confluent namespace if it doesn't exist
`kubectl create namespace confluent`

- switch the context to confluent namespace
`kubens confluent`

- make necessary changes to the helm `values.yaml` file for e.g., adding the licenseKey which we received from the confluent.

- exec into helm directory. This will install the confluent operator
`helm upgrade --install confluent-operator ./confluent-for-kubernetes --namespace confluent`

- Follow the `secret-setup/secret-creation-steps.sh` to create necessary certificates and the kubernetes secrets which we would be using in the next step.

- The confluent operator also installs the CRD's for the cluster. Next step, is to install the confluent-platform.

`kubectl apply -f cfk-setup/confluent-platform.yaml`

- The current cluster is configured using mTLS authentication between Zookeeper and kafka and also the communication between the cfk components.

## Monitoring

Current monitoring setup was done using prometheus+grafana. There are three important components for the monitoring setup
- #### metrics exporter
    - All the confluent components expose their jmx metrics on 7778 port on each service. These jmx metrics provide insights on the high-level metrics but not on kafka components like consumer lag etc. So we would need another metric exporter which could do that. 
    - [kminion](https://github.com/redpanda-data/kminion) acts as the prometheus kafka exporter.
    - `kminion` needs secrets to communicate to kafka, so the kafka cert file, cacert and private key are created as k8s secrets and are referenced in `values.yaml` file.
    
- #### Prometheus
    We would install prometheus and also podmonitors to look after those endpoints of jmx, kminion and scrape those metrics to the prometheus instance.
- #### Grafana
    We would use grafana and select the source as the prometheus to visualize the metrics using dashboards.

