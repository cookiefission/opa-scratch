package kubernetes.admission.best_practice.deployment_replicas

low_availability_flag {
  is_string(input.request.object.metadata.annotations["kube.example.com/allowed-low-availability"])
}

less_than_minimum_replicas {
  input.request.object.spec.replicas < data.minimum_replicas
}

deny[msg] {
  less_than_minimum_replicas
  not low_availability_flag
    
  msg := "Deployment is requesting too few replicas for high availability"
}
