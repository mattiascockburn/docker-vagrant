# Vagrant docker image

https://hub.docker.com/r/pschmitt/docker-vagrant/

## Plugins

- [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt)
- [vagrant-proxmox](https://github.com/telcat/vagrant-proxmox)

## Usage
```bash
docker run -it --rm --name vagrant -v VAGRANT_CONFIG_DIR:/data pschmitt/vagrant up
```
