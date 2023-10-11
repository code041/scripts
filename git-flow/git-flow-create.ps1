param(
    [string]$repo,
    [string]$owner,
    [string]$destinationFolder,
    [string]$visibility
)

$branchProtectionFile = "branch-protection.json"

function createBranch{
    param (
        [string]$branchName
    )

    git checkout -b $branchName
    git commit --allow-empty -m "init $branchName branch"
    git push origin $branchName
}

function createBranches{
    param(
        [array]$branches,
        [string]$destinationFolder
        )
        $root = (Get-Item -Path $PWD).FullName
        Set-Location $destinationFolder
        foreach($b in $branches){
            createBranch -branchName $b
        }
        Set-Location $root
    }
    
function protectBranch{
    param(
        [string]$owner,
        [string]$repo,
        [string]$branchName
    )
    gh api -X PUT repos/$owner/$repo/branches/$branchName/protection --input $branchProtectionFile
}

function protectBranches{
    param(
        [string]$owner,
        [string]$repo,
        [array]$branches
    )
    foreach($b in $branches){
        protectBranch -owner $owner -repo $repo -branchName $b
    }
}

function createRepo{
    param(
        [string]$owner,
        [string]$repo,
        [string]$visibility
    )
    if($visibility -eq "public"){
        gh repo create $owner/$repo --public
    }elseif ($visibility -eq "private"){
        gh repo create $owner/$repo --private
    }elseif ($visibility -eq "internal"){
        gh repo create $owner/$repo --internal
    }else{
        throw "Visibility value invalid! (Accepted values: public, private and internal)"
    }
}

function cloneRepo{
    param(
        [string]$owner,
        [string]$repo,
        [string]$destinationFolder
    )
    git clone git@github.com:$owner/$repo.git $destinationFolder
    #Copy-Item -Path $branchProtectionFile -Destination $destinationFolder
    #Set-Location $destinationFolder
}

function createProject{
    param(
        [string]$owner,
        [string]$title
    )
    gh project create --owner $owner --title $title
}



function angularWorkspace{
    param(
        [string]$destinationFolder
    )
    $root = (Get-Item -Path $PWD).FullName
    Set-Location $destinationFolder
    git checkout dev
    git checkout -b workspace-setup
    ng new . --no-create-application
    git add .
    git commit -a -m "angular workspace created"
    git push -u origin workspace-setup
}

$branches = @("main", "bugfix", "dev");



createRepo -owner $owner -repo $repo -visibility $visibility
createProject -owner $owner -title $repo
cloneRepo -owner $owner -repo $repo -destinationFolder $destinationFolder
createBranches -branches $branches -destinationFolder $destinationFolder
protectBranches -owner $owner -repo $repo -branches $branches

#angularWorkspace -destinationFolder $d


