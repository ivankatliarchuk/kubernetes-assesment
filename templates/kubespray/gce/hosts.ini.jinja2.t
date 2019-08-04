[all]
## Configure 'ip' variable to bind kubernetes services on a
## different ip than the default iface
{% if bastion_ip %}
{% for item in masters -%}
k8s-master-ltn6 ansible_ssh_host={{ item }} ip={{ item }} etcd_member_name=etcd-{{ loop.index0 + 1 }}
{% endfor -%}
{% for item in nodes -%}
node-{{ loop.index0 + 1 }} ansible_ssh_host={{ item }} ip={{ item }}
{% endfor %}
{% for item in etcds -%}
etcd-{{ loop.index0 + 1 }} ansible_ssh_host={{ item }} ip={{ item }} etcd_member_name=etcd-{{ loop.index0 + 1 }}
{% endfor %}
## configure a bastion host if your nodes are not directly reachable
bastion-1 ansible_host={{ bastion_ip }} ansible_user={{ ansible_user }}
{% endif %}

[bastion]
bastion-1

[kube-master]
{% for item in masters -%}
k8s-master-ltn6
{% endfor %}
[etcd]
{% for item in masters -%}
k8s-master-ltn6
{% endfor %}
{% for item in etcds -%}
etcd-{{ loop.index0 + 1 }}
{% endfor %}
[kube-node]
{% for item in nodes -%}
node-{{ loop.index0 + 1 }}
{% endfor %}
## [kube-ingress]
## {% for item in nodes -%}
## node-{{ loop.index0 + 1 }}
## {% endfor %}

[k8s-cluster:children]
kube-node
kube-master

[all:vars]
ansible_ssh_user=k8s
ansible_user=k8s
ansible_become=yes
ansible_python_interpreter="/usr/bin/python3"