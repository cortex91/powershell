foreach ($raw in (Get-Item *.cr3))
{# Durchlaufen aller .cr2 Dateien

    if (!(Test-Path "$(($raw.Name).split(".")[0]).jpg"))
    {# Wenn kein passendes .jpg zum aktuellen Raw vorhanden ist, lösche das Raw

        Remove-Item $raw

    }

}
