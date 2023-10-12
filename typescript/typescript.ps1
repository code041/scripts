param(
    [string]$destinationFolder,
    [string]$libraryName
)

function configRepo{
    param(
        [string]$repo,
        [string]$owner,
        [string]$destinationFolder,
        [string]$visibility
    )
    Write-Host "Executando o script git-flow.ps1"
    & .\\git-flow\git-flow.ps1 -repo $repo -owner $owner -destinationFolder $destinationFolder -visibility $visibility
}

configRepo -repo $libraryName -owner "code041" -visibility "private" -destinationFolder $destinationFolder
Set-Location $destinationFolder
git checkout -b library-init
npm init --yes $libraryName --scripts "start: node index.js"
npm install typescript --save-dev
npx tsc --init
git add .
git commit -a -m "library init"
git push origin library-init