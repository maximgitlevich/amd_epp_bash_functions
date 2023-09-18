# Safe Setter & Getter for amd_pstate_epp hints.
Safe = only sets/gets if valid and possible. 
May be beneficial if switching between Kernels/Kernel Parameters. 

For terminal use, add following line to .bashrc: 

```source %pathtofile%/eppfunctions.sh```

For bootup, create systemd service like:
```
[Unit]
Description= Set EPP Hint to Powersave
After=

[Service]
Type=oneshot
User=root
ExecStart=%pathtofile%/eppfunctions.sh power

[Install]
WantedBy=multi-user.target
```

Terminal Usage

`set_epp_hint` outputs valid parameters

`set_epp_hint power` tries to set all epp_hints to "power" mode

`get_epp_hint` outputs currently set epp_hints
