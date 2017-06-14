# Vagrant docker image

https://hub.docker.com/r/pschmitt/docker-vagrant/

## Plugins

- [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt)
- [landrush](https://github.com/vagrant-landrush/landrush)

## Build

Run build.sh in the root folder of this project. You may provide the version of vagrant you'd like
to install:

```bash
bash ./build.sh 1.9.5
```

The image will be tagged with vagrant:$VERSION

## Usage

Change to a directory with a vagrant env (which is configured to use libvirt) and run the following
command:

```bash
$ cd /my/vagrant/stuff
$ grep -v '^ *#.*$' Vagrantfile | grep -v '^ *$'
Vagrant.configure("2") do |config|
  config.vm.box = "centos73"
  config.vm.synced_folder './', '/vagrant', disabled: true, type: 'rsync'
end
$ docker run -ti --rm -v "${HOME}/.vagrant.d/boxes:/home/user/.vagrant.d/boxes" -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock -v $(pwd):/data  --name vagrant --net=host vagrant:1.9.5 up
Bringing machine 'default' up with 'libvirt' provider...
==> default: Creating image (snapshot of base box volume).
==> default: Creating domain with the following settings...
==> default:  -- Name:              data_default
==> default:  -- Domain type:       kvm
==> default:  -- Cpus:              1
==> default:  -- Feature:           acpi
==> default:  -- Feature:           apic
==> default:  -- Feature:           pae
==> default:  -- Memory:            512M
==> default:  -- Management MAC:
==> default:  -- Loader:
==> default:  -- Base box:          centos73
==> default:  -- Storage pool:      default
==> default:  -- Image:             /space/virt/data_default.img (59G)
==> default:  -- Volume Cache:      default
==> default:  -- Kernel:
==> default:  -- Initrd:
==> default:  -- Graphics Type:     vnc
==> default:  -- Graphics Port:     5900
==> default:  -- Graphics IP:       127.0.0.1
==> default:  -- Graphics Password: Not defined
==> default:  -- Video Type:        cirrus
==> default:  -- Video VRAM:        9216
==> default:  -- Sound Type:
==> default:  -- Keymap:            en-us
==> default:  -- TPM Path:
==> default:  -- INPUT:             type=mouse, bus=ps2
==> default: Creating shared folders metadata...
==> default: Starting domain.
==> default: Waiting for domain to get an IP address...
==> default: Waiting for SSH to become available...
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Automatic installation for Landrush IP not enabled
==> default: Configuring and enabling network interfaces...
    default: SSH address: 192.168.121.205:22
    default: SSH username: vagrant
    default: SSH auth method: private key
$ docker run -ti --rm -v "${HOME}/.vagrant.d/boxes:/home/user/.vagrant.d/boxes" -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock -v $(pwd):/data  --name vagrant --net=host vagrant:1.9.5 ssh
[vagrant@localhost ~]$ # Whoooozaaaaaa
[vagrant@localhost ~]$ logout
Connection to 192.168.121.205 closed.
```

## Limitations

9p synced folders don't work and i only tested rsync successfully.
