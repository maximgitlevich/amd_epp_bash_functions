#!/bin/bash

get_epp_hint() {
    cat /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
}

set_epp_hint() {
  local scaling_driver=$(</sys/devices/system/cpu/cpu0/cpufreq/scaling_driver)
  if [ "$scaling_driver" == "amd-pstate-epp" ]; then
    local preference="$1"  
    local available_preferences=$(</sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences)

    if [ -z "$preference" ]; then
      echo "No argument passed. Possible values: $available_preferences" | tee "$(tty)"
    else
      # Check if powerstate is valid
      if [[ "$available_preferences" =~ (^| )"$preference"($| ) ]]; then
        
        # Accumulate commands for singular elevation
        local changes=""
        for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*/; do
          changes+="echo \"$preference\" > \"${cpu_dir}cpufreq/energy_performance_preference\" && "
        done
        changes="${changes%&& }"

        # Elevate once
        if [ -n "$changes" ]; then
          echo "$changes" | sudo bash
        fi       

        echo "EPP Mode changed to $preference globally" | tee "$(tty)"
      else
        echo "Invalid Power State, choose from: $available_preferences" | tee "$(tty)"
      fi
    fi
  else
    echo "EPP is not availabe. Enable CBBC in Bios + add amd_pstate=active in kernel parameters(Kernel 6.3+). Reference: https://wiki.archlinux.org/title/CPU_frequency_scaling#Scaling_drivers and 
    https://www.reddit.com/r/linux/comments/15p4bfs/amd_pstate_and_amd_pstate_epp_scaling_driver/" | tee "$(tty)"
  fi
}
