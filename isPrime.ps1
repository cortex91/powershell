function isPrime
{

    param
    (
        [Parameter(Mandatory,ValueFromPipeline)]
        $Zahl
    )

    if ($Zahl -lt 2)
    {# Wenn die Zahl kleiner als 2 ist, ist es keine Primzahl

        $prime = $false

    }

    else
    {# Wenn die Zahl größer als 2 ist, nehme ich an dass es eine Primzahl ist

        $prime = $true

        $zaehler = 2
        do
        {# Solange nicht 0 als Rest rauskommt, rechne $zahl Modulo $zähler

            $rest = $zahl % $zaehler
            $zaehler++

        } until ($rest -eq 0)

        if ($rest -eq 0 -and $zaehler-1 -ne $zahl)
        { $prime = $false}
    
    }
    $prime

}

$zahlen = Read-Host "Bis zu Welcher Zahl sollen die Primzahlen ausgegeben werden?"
$primzahlen = @()

$zeit_start = Get-Date
for ($zaehler = 0; $zaehler -lt $zahlen; $zaehler ++)
{

    if ($zaehler |isPrime)
    {

        $primzahlen += $zaehler

    }

}
$zeit_ende = Get-Date
$zeit_benoetigt = New-TimeSpan -Start $zeit_start -End $zeit_ende
$primzahlen
"Zeit benötigt: {0:hh\:mm\:ss\.fff}” -f $zeit_benoetigt