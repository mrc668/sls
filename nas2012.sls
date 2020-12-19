extra.pkgs:
  pkg.installed:
      - pkgs:
        - nfs-utils

/nas2012/Web:
  mount.mounted:
    - fstype: nfs
    - device: nas2012:/Web
    - mkmnt: True
    - opts:
      - defaults

/nas2012/EotN:
  mount.mounted:
    - fstype: nfs
    - device: nas2012:/EotN
    - mkmnt: True
    - opts:
      - defaults

/nas2012/Multimedia:
  mount.mounted:
    - fstype: nfs
    - device: nas2012:/Multimedia
    - mkmnt: True
    - opts:
      - defaults

