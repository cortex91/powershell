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

    # Zur�ckgeben an StdIn
    $output

}