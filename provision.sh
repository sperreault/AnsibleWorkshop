#!/bin/sh

echo '192.168.33.51 centos1 centos1.example.com' >> /etc/hosts 
echo '192.168.33.52 centos2 centos2.example.com' >> /etc/hosts 

useradd -m -p '#{centos_password}' centos 

mkdir ~centos/.ssh 
cat << EOF > ~centos/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvDkVSYZX8XVBZA+2Yjewl2YUAgQEYceGPfs4HAgQwIOzNOap
P/MJnw/9ephXR+/QiCL5STKe+gEmag8iNqG2QkJ8j2KkNfj4Y7WTNPcrUhjCMN9m
6NeXH+b1WZ7JY4IbcZORSFQ6rSJUr2ihUKFXUfy8UHdDiGEQOmlyp/hJ2Hs7AXgK
PvzpF7MNv7QDS9B3KBI8VfRnydx6V5LL76qqUYuC0xzx4TeEPFraIvmOYiznFkCm
hUEGCGmtquuW77Ydw1Nn7GQNWgqKFsrEM4iEO8LZI/t/tkXtglPDqQPD6Ckn4Q9Y
H8K/ebFlGzhEr5P6pkY8MMntTvVEpO6xQuN6PwIDAQABAoIBABr5U0OmLRQ9aZGd
btXEhVotFtDzIm2g2mwnhHL/9Oah+RyrsbWobsiM0havnlKA27Gm0XLb/kx1vbuV
T6Hkqunz/UXPLRlPBMnFS8NbaKnrQmkemvDjdJTt1FtzlgjcrHIqY7ep2n7VXK2G
oRedB5aIUbR2Ywc4Ycr9MaFAw9RyFafQkWrJBkbw2JuKUNvPEfcl07J4RvCRy4Ep
J7mcTEMm7sILutfuQTSbh17vip2kKinhZAWClCI7PW5d6HhHJgGdxUjrolOwDJY4
2mPwh+hFECw2bcyyoKhQdC9Qz/hXgenjXuKjjEJp4dVGAXWqU5HlAjYGvXCOZwf4
peoMrYECgYEA3L7sNzamzfDEkdRFVwXvUlGO4aP5kyT0f+KYTm+TkxgDmC6lOIa0
b4o9HG09x23VL5FR6YcFM1lz2DBDWgr2k/pI0iuuTacD7EhHUFJN9YiCzuuLpLzM
nh1C1v/83mSE/1GDotqW9xKBPTR6Pmk3M2BDntMkNggTJGOpsV2slxMCgYEA2kh7
b7mNBxd5LmO4eYQ++C9EsbE3oWCiTov3MfoXzYlAxxKE5G3jpkfK/Rj6wOz2QBOp
456LXoum5/hitYduCAUfVJbRWon3WEsYJsZT9yDMPTYTj+CahutcCCRPv1KXquvb
ttnR+RXnNXGmSm1KpVwErvIebPA1p0byoZ7t2aUCgYAMsDC1r7+AwOEbnL7rlJy/
944l7B3xVkNzglvMzl8GKnAydCPtDtkaPDDtDF5rsyV42XqC2M70t6SP/Z4xc8Xe
lZlP81DOh9YS48itlj2C6njSWfmp22xLflUUNJydT9vRLSdK2hOpWffxw61vHu8c
VeEtJOfE70viYJQlbMP53wKBgCVd8RuQJQ9IumrxkTvkIq9z0AunLcHHfCF8HmYE
zRxXWap6hhtgoG7vrVUkeJCcQA96DkQz+OHHgFwHjkZLF8/xqIpfgxk/swL/X/QL
UYZlq/Dyl+iyZ2GfWtLd/HThG6ub0rH7mdFNKZZhjTkCepvSI88bDZBSkqy/HXwD
a+4tAoGAAVnvN/G2KiCEVq92evOnHc5J2xZF60cDRnGbSNdu+jG04odz/SMw/2Jw
kyU65uSXAmxsOW3lWiDfMCg8i/D6h2LGodwhFEerMgXNi2PDd0jTduYrZUr7OBsR
RIGga79FQAFzjyYgaTP7Wvm3BJaDM6AwWpUMSwT5C9MxNgacsBs=
-----END RSA PRIVATE KEY-----
EOF
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8ORVJhlfxdUFkD7ZiN7CXZhQCBARhx4Y9+zgcCBDAg7M05qk/8wmfD/16mFdH79CIIvlJMp76ASZqDyI2obZCQnyPYqQ1+PhjtZM09ytSGMIw32bo15cf5vVZnsljghtxk5FIVDqtIlSvaKFQoVdR/LxQd0OIYRA6aXKn+EnYezsBeAo+/OkXsw2/tANL0HcoEjxV9GfJ3HpXksvvqqpRi4LTHPHhN4Q8Wtoi+Y5iLOcWQKaFQQYIaa2q65bvth3DU2fsZA1aCooWysQziIQ7wtkj+3+2Re2CU8OpA8PoKSfhD1gfwr95sWUbOESvk/qmRjwwye1O9USk7rFC43o/ centos@example.com"  > ~centos/.ssh/authorized_keys 

chmod 0700 ~centos/.ssh
chmod 0600 ~centos/.ssh/* 

mkdir ~centos/ansible
cat << EOF > ~centos/ansible/inventory

[all:vars]
ansible_ssh_user=centos

[web]
web1 ansible_ssh_host=centos2

[admin]
ansible ansible_ssh_host=centos1
EOF

chown centos:centos -R ~centos/ 

echo 'centos ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/centos 

yum clean all
yum install -y epel-release 
if [ $(hostname) == 'centos1.example.com' ]; then
  yum install -y vim ansible
fi
