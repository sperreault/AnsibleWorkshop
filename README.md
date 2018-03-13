# AnsibleWorkshop

Vous allez trouver les fichiers requis avec Vagrant 2.0+ pour partir un environment Ansible pour le Workshop.

## Bien commencer

Vous devez suivre les instructions suivantes pour avoir un environment fonctionnel pour le Workshop.

### Pre-requis

Les outils requis:

```
git
vagrant 2.0+
virtualbox 5.2+
  ou
libvirt (disto resante de linux)
6GB de RAM ou mieux
```

### Installation

Pour utiliser les fichiers du workshop. Dans un terminal:

```
git clone https://github.com/sperreault/AnsibleWorkshop.git
cd AnsibleWorkshop
vagrant up
```

Pour vous connecter aux VMs de votre PC:
```
vagrant ssh centos1
sudo su - centos
```

## Pour tester

Vous devez vous connecter sur centos1 et par la suite tester si ansible fonctionne bien.

```
vagrant ssh centos1
sudo su - centos
cd ansible
ansible -m ping -i inventory web
```

## Authors

* **Sebastien Perreault** - *Initial work* - [sperreault](https://github.com/sperreault)
