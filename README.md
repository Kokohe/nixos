nixos config for AVF (experimental android on linux) 

This configuration is to get a working hyprland setup with hardware rendering.

slight modifications required directly to the vm configuration itself to swap from 2d back end to 3d rendering. You can do this using the following command:

sed -t 's/"backend": "2d"/"backend": "virgl" /mnt/internal/linux/vm_config.json

confirm it was successful using this command.

cat /mnt/internal/linux/vm_config.json | grep -A3 '"gpu"'
