# Specify the path to your text file
$filePath = "domains.txt"
Import-Module PsHosts;

# Read each line from the file
Get-Content $filePath | ForEach-Object {
    # Split the line into two parts (hostname and IP address)
    $parts = $_ -split ' '

    # Extract the hostname and IP address
    $hostname = $parts[0]
    $ipAddress = $parts[1]

    # Define your command and execute it
    $command = "Add-HostEntry"
    $arg1 = $hostname
    $arg2 = $ipAddress

    # Execute the command
    Invoke-Expression "$command $arg1 $arg2"
}
