

resource "aws_security_group" "k8_nodes" {
  name        = "k8_nodes_anhdo_vinh"
  description = "sec group for k8 nodes"
  vpc_id      = aws_vpc.vpc_k8s.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.vpc_k8s.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "k8_masters" {
  name        = "k8_masters_anhdo_vinh"
  description = "sec group for k8 master nodes"
  vpc_id      = aws_vpc.vpc_k8s.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    #Kubernetes API server
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_k8s.cidr_block]
  }

  ingress {
    #etcd server client API
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_k8s.cidr_block]
  }

  ingress {
    #Kubelet API
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_k8s.cidr_block]
  }

  ingress {
    #kube-scheduler
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_k8s.cidr_block]
  }

  ingress {
    #kube-controller-manager
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_k8s.cidr_block]
  }

}

resource "aws_security_group" "k8_workers" {
  name        = "k8_workers_anhdo_vinh"
  description = "sec group for k8 worker nodes"
  vpc_id      = aws_vpc.vpc_k8s.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    #Kubelet API
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_k8s.cidr_block]
  }

  ingress {
    #NodePort Services†
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_k8s.cidr_block]
  }
}
