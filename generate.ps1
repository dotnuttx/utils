#!/usr/bin/pwsh

function outputReport {
    $ret = $args[0]
    $name = $args[1]

    # error
    if (-not ($ret -eq 0)) {
        Write-Host -NoNewline " 💩 "
        Write-Host "$name" `
            -ForegroundColor Black `
            -BackgroundColor Red
    } else {
        Write-Host -NoNewline " 😁 "
        Write-Host "$name" `
            -ForegroundColor Black `
            -BackgroundColor Green
    }
}

# generate the containers that output the binaries with Nuttx

# esp32c3
Set-Location ./generate-bin-esp32c3
./docker.build
$esp32c3Ret = $LASTEXITCODE
Set-Location -

# k210
Set-Location ./generate-maix-bit-k210
./docker.build
$k210Ret = $LASTEXITCODE
Set-Location -

# pi-pico rp2040
Set-Location ./generate-pico-uf2
./docker.build
$piPicoRet = $LASTEXITCODE
Set-Location -

# reports
Write-Host -NoNewline " ⚠️ "
Write-Host "Build Report ::" `
    -ForegroundColor Black `
    -BackgroundColor DarkYellow

outputReport $esp32c3Ret    " dotnuttx/generate-bin-esp32c3     -  Nuttx rcv32 "
outputReport $k210Ret       " dotnuttx/generate-maix-bit-k210   -  Nuttx rcv64 "
outputReport $piPicoRet     " dotnuttx/generate-pico-uf2        -  Nuttx arm-m0 "
