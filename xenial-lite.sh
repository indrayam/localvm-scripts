#cloud-config

# Add users to the system. Users are added after groups are added.
users:
  - default

write_files:
  # Apt repository for Kubernetes stuff
  - content: |
      deb http://apt.kubernetes.io/ kubernetes-xenial main
    path: /etc/apt/sources.list.d/kubernetes.list
  # Create Post install Shell Script
  - content: |
      cd /tmp

      # Step 2: Setup SSH keys
      cd /tmp
      curl -L https://storage.googleapis.com/seaz/xenial-lite.tar.gz.enc -H 'Accept: application/octet-stream' --output xenial-lite.tar.gz.enc
      openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -d -in xenial-lite.tar.gz.enc -out xenial-lite.tar.gz
      tar -xvzf bionic-lite.tar.gz
      mv dotfiles ~/.dotfiles

      # Step 3: Pull down my .dotfiles repo and setup vim, kube-ps1
      cd ~
      ~/.dotfiles/setup-symlinks-bash.sh

      # Step 4: Final touches...
      mkdir -p /home/ubuntu/workspace
      echo "You're done! Remove this file, exit and log back in to enjoy your new VM"
    path: /home/ubuntu/complete-os-setup.sh
    permissions: '0755'

runcmd:
  - chown -R ubuntu.ubuntu /home/ubuntu
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - add-apt-repository -y ppa:jonathonf/vim
  - curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  - apt-get update
  - apt-get install -y zsh 
  - apt-get install -y vim
  - chown -R ubuntu.ubuntu /usr/local/src
  - ln -s /usr/local/src /home/ubuntu/src
  - chown -h ubuntu.ubuntu /home/ubuntu/src
