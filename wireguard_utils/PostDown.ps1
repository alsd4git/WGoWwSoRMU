# Specify the path to your text file
$filePath = "domains.txt"
Import-Module PsHosts;

# Read each line from the file
Get-Content $filePath | ForEach-Object {
    # Split the line into two parts (hostname and IP address)
    $parts = $_ -split ' '

    # Extract the hostname
    $hostname = $parts[0]

    # Define your command and execute it
    $command = "Remove-HostEntry"
    $arg1 = $hostname

    # Execute the command
    Invoke-Expression "$command $arg1"
}
