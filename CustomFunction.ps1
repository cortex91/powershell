function MyFunction
{

    param
    (

        [Parameter(Mandatory,ValueFromPipeline)]
        $Input,
        [Parameter]
        [array]$MyArray,

        [Switch]$MySwitch

    )

    if ($MySwitch.IsPresent)
    {# Wenn Switch vorhanden, mache

        

    }

    # Zurückgeben an StdIn
    $output

}