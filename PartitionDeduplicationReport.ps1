# Get info about disk and deduplication status to email

# Define email parameters
$emailParams = @{
    SmtpServer  = "SMTP server"
    From        = "from_@server_com"
    To          = "to_@server_com"
    Subject     = "Subject Partition and Deduplication Report"
}

# Get partition information with size, free space, and free space percentage
$partitions = Get-Volume | Where-Object { $_.DriveLetter -ne $null } |  # Filter to exclude partitions without drive letters
              Select-Object @{Name='Partition';Expression={$_.DriveLetter}},
                            @{Name='Size (TB)';Expression={[math]::Round($_.Size/1TB, 2)}},
                            @{Name='Free Space (TB)';Expression={[math]::Round($_.SizeRemaining/1TB, 2)}},
                            @{Name='Free Space (%)';Expression={[math]::Round(($_.SizeRemaining/$_.Size)*100, 2)}} |
              Sort-Object Partition

# Get deduplication job information
$dedupJobs = Get-DedupJob | Where-Object { $_.Volume -ne $null } |  # Filter to exclude deduplication jobs without volumes
             Select-Object Volume, Type, Status, Progress, StartTime, EndTime |
             Sort-Object Volume

# Build email body
$emailBody = @"
<html>
<body>
<h2>VBR-Jaffa-Dell partition Information:</h2>
$($partitions | ConvertTo-Html -Property Partition, 'Size (TB)', 'Free Space (TB)', 'Free Space (%)' -Fragment)

<h2>Deduplication Jobs:</h2>
$($dedupJobs | ConvertTo-Html -Property Volume, Type, Status, Progress, StartTime, EndTime -Fragment)
</body>
</html>
"@

# Send email
Send-MailMessage @emailParams -Body $emailBody -BodyAsHtml
