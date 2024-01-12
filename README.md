# WGoWwSoRMU
AKA: `WireGuardOnWindowsWithSwagOnRemoteMachineUtils`

## Overview

This repository contains a Bash script, `genHostEntryFromSwagConf.sh`, designed to be run on a Linux machine with the `linuxserver.io/swag` container running as a reverse proxy. The purpose of this script is to generate a list of configured domains in the format "domain local_ip." The resulting output can be used on a machine running WireGuard on Windows to push to the host file, I need to do that because I have problems with setting a DNS on that machine and I want those domains to still be resolved "locally" (but only when i'm running the wireguard vpn)

Additionally, the repository includes a "wireguard_utils" folder containing two scripts, `PostUp.ps1` and `PostDown.ps1`, which are meant to be placed on the Windows machine to configure the WireGuard tunnel's PostUp and PostDown actions.

## Prerequisites

- A Linux machine with the `linuxserver.io/swag` container running.
- WireGuard installed and configured on a Windows machine.

## Usage

### Step 1: Running the Bash script

1. Ensure that the `linuxserver.io/swag` container is running on your Linux machine.

2. Clone this repository to your Linux machine.

    ```bash
    git clone https://github.com/alsd4git/WGoWwSoRMU.git
    ```

3. Navigate to the repository.

    ```bash
    cd WGoWwSoRMU
    ```

4. Edit the variables in the script (first 3 lines, explaination in the script file)

    ```bash
    nano genHostEntryFromSwagConf.sh
    ```

5. Make the Bash script executable.

    ```bash
    chmod +x genHostEntryFromSwagConf.sh
    ```

6. Run the script.

    ```bash
    ./genHostEntryFromSwagConf.sh
    ```

   The script will generate a list of configured domains in the specified format. (you have a domains.txt example in th wireguard_utils subfolder)

### Step 2: Configuring WireGuard on Windows

1. Copy the generated output from Step 1.

2. Navigate to the "wireguard_utils" folder.

    ```pwsh
    cd wireguard_utils
    ```

3. Place the `PostUp.ps1` and `PostDown.ps1` scripts on your Windows machine. (Isuggest to just copy the whole folder and adjust the domains.txt file from your server)

4. Install the `PsHosts` powershell module with the following command:

    ```pwsh
    install-module PsHosts
    ```

    note that if you use powershell.exe you need to install the module in the Windows Powershell install, not Powershell-core

5. Open the WireGuard configuration file on your Windows machine.

6. Update the `[Interface]` section to include the following:

    ```conf
    PostUp = powershell.exe -Command "& { cd C:\path\to\wireguard_utils\ ; .\PostUp.ps1 }"
    PostDown = powershell.exe -Command "& { cd C:\path\to\wireguard_utils\ ; .\PostDown.ps1 }"
    ```

   Replace `C:\path\to\` with the actual path where you placed the scripts.

7. Save and apply the changes to your WireGuard configuration.

8. If you have a message in your wireguard log telling you that the postUp and PostDown commands are not executed check here <https://github.com/WireGuard/wireguard-windows/blob/master/docs/adminregistry.md>

Now, your WireGuard tunnel on Windows should execute the specified scripts during the PostUp and PostDown phases, enabling the required configurations for the reverse proxy setup.

## Disclaimer

This script and associated utilities are provided as-is. Please review and customize them based on your specific requirements and security considerations. Use at your own risk.
