# Safe Setter & Getter for amd_pstate_epp hints.
May be beneficial if switching between Kernels/Kernel Parameters. 

## Usage

`set_epp_hint` outputs valid parameters

`set_epp_hint power` tries to set all epp_hints to "power" mode

`get_epp_hint` outputs currently set epp_hints

## Install 

For terminal use, add following line to .bashrc: 

```source %pathtofile%/eppfunctions.sh```

For bootup, create a bootup script like:
```
#!/bin/bash
source %pathtofile%/eppfunctions.sh
set_epp_hint power
```
and systemd service like
```
[Unit]
Description= Bootup Power Settings
After=

[Service]
Type=oneshot
User=root
ExecStart=%pathtofile%/bootup_script.sh

[Install]
WantedBy=multi-user.target
```
