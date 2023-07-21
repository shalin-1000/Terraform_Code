output "Jenkins_IP" {
  value = aws_instance.Jenkins.public_ip

}

output "Sonarqube" {
  value = aws_instance.Sonarqube.public_ip

}

output "Nexus_IP" {
  value = aws_instance.Nexus.public_ip

}


