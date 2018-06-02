# packer-builds

## Build Automated Machine and Container Images for [Ever Proven]

### How it works

First, install prerequisites:

* [Git]
* [Packer]

Clone the repository from GitHub:

```sh
git clone git@github.com:everproven/packer-builds.git
cd packer-builds
```

Choose a template, for instance vagrant-template-ubuntu.json an on of its varfiles:

```sh
# Validate the JSON template
packer validate -var-file=vagrant-varfile-ubuntu-1604.json vagrant-template-ubuntu.json

# Build the image
packer build -var-file=vagrant-varfile-ubuntu-1604.json vagrant-template-ubuntu.json
```

See Packer Getting Started for further ideas:

[https://www.packer.io/intro/getting-started/install.html]

[Ever Proven]: https://github.com/everproven
[Git]: https://git-scm.com/
[Packer]: https://www.packer.io/
[https://www.packer.io/intro/getting-started/install.html]: https://www.packer.io/intro/getting-started/install.html