function .. {
    Set-Location -Path '..'
}

function ... {
    Set-Location -Path '..\..'
}

function .... {
    Set-Location -Path '..\..\..'
}

function psprofile {
    $profilePath = $PROFILE
    nvim $profilePath
}


