Set-ExecutionPolicy bypass







function Check-SpfRecord
{# Funktion zum Abrufen des SPF-Records

    param
    (

        [Parameter(Mandatory,ValueFromPipeline)]
        [Array]$DomainName

    )

    # Deklarieren eines Arrays für den Output
    $output = @()

    foreach ($domain in $DomainName)
    {# Durchlaufen aller Domains die an Funktion übergeben werden

        $dns = Resolve-DnsName -Name $domain -Type TXT
        $dns = ($dns |? {$_.strings -like "v=spf*"}).strings

        $record = [PSCustomObject]@{DomainName=$domain;SpfRecord="$dns"}
        $output +=$record

    }

    # Zurückgeben an StdIn
    $output

}

function Check-DmarcRecord
{# Funktion zum Abrufen des SPF-Records

    param
    (

        [Parameter(Mandatory,ValueFromPipeline)]
        [Array]$DomainName

    )

    # Deklarieren eines Arrays für den Output
    $output = @()

    foreach ($domain in $DomainName)
    {# Durchlaufen aller Domains die an Funktion übergeben werden

        $dns = Resolve-DnsName -Name "_dmarc.$domain" -Type TXT
        $dns = ($dns |? {$_.strings -like "v=dmarc*"}).strings

        $record = [PSCustomObject]@{DomainName=$domain;DmarcRecord="$dns"}
        $output +=$record

    }

    # Zurückgeben an StdIn
    $output

}

function Check-DkimRecord
{# Funktion zum Abrufen des SPF-Records

    param
    (

        [Parameter(Mandatory,ValueFromPipeline)]
        [String]$DomainName,
        [Parameter(Mandatory)]
        [String]$SelectorName

    )

    # Deklarieren eines Arrays für den Output
    $output = @()

    foreach ($domain in $DomainName)
    {# Durchlaufen aller Domains die an Funktion übergeben werden

        $dns = Resolve-DnsName -Name "$SelectorName._domainkey.$domain" -Type ANY
        $dns = ($dns |? {$_.strings -like "v=dkim*"}).strings

        $record = [PSCustomObject]@{DomainName=$domain;DkimRecord="$dns"}
        $output +=$record

    }

    # Zurückgeben an StdIn
    $output

}


function Check-EmailAuthenticationRecords
{# Funktion zum Abrufen des SPF-Records

    param
    (

        [Parameter(Mandatory,ValueFromPipeline)]
        [String]$DomainName,
        [Parameter(Mandatory)]
        [String]$DkimSelectorName


    )

    $output = [PSCustomObject]@{DomainName=$DomainName;SpfRecord="";DkimRecord="";DmarcRecord=""}

    $spf = Resolve-DnsName -Name $DomainName -Type TXT
    $spf = ($spf |? {$_.strings -like "v=spf*"}).strings

    $dkim = Resolve-DnsName -Name "$DkimSelectorName._domainkey.$DomainName" -Type ANY
    $dkim = ($dkim |? {$_.strings -like "v=dkim*"}).strings

    $dmarc = Resolve-DnsName -Name "_dmarc.$DomainName" -Type TXT
    $dmarc = ($dmarc |? {$_.strings -like "v=dmarc*"}).strings

    $output.SpfRecord = $spf
    $output.DkimRecord = $dkim
    $output.DmarcRecord = $dmarc

    $output

}