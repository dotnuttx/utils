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

# generate multi arch builder

# Debian SID arm32v5
docker `
    build `
    -t dotnuttx/builder:linux-arm32v6 `
    --build-arg ARCH_SHA=sha256:b7517ddbfac9e8f960592086acf7f81165abc29a53ac26c718b6b80e9e93a0ef `
    -f Dockerfile .
$arm32v6Ret = $LASTEXITCODE

docker `
    build `
    -t dotnuttx/builder:linux-riscv64 `
    --build-arg ARCH_SHA=sha256:90b2ab69bc9b074b5d747fe044247e385f953534ebb6f51ac476fd7121b2dc6d `
    -f Dockerfile .
$riscv64Ret = $LASTEXITCODE

# reports
Write-Host -NoNewline " ⚠️ "
Write-Host "Build Report ::" `
    -ForegroundColor Black `
    -BackgroundColor DarkYellow

outputReport $arm32v6Ret    " dotnuttx/builder   -  Linux arm32v6 "
outputReport $riscv64Ret    " dotnuttx/builder   -  Linux Risc-V 64 "
