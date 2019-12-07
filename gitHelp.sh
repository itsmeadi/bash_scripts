pr
function parse(){
git status|grep modified|awk '{print $2}'| while read -r line ; do
	git diff $line
	read "ai?Add or Ignore? " </dev/tty
    case $ai in
        [Aa]* ) 
		git add $line; 
		echo "Adding" $line
		;;
        [Ii]* ) 
		;;
        *) echo "Add or ignore";;
    esac 
done   
}

function branch()
{
if [ "$2" != "nup" ];then
git fetch origin
fi
git checkout -b mc_stag_i_aditya_$1 origin/staging
git checkout -b mc_prod_i_aditya_$1 origin/production
git checkout -b i_aditya_$1 origin/master
}
function mergef(){
branchName="$(git branch| grep -F "*" | awk '{print $2}')"
te=${branchName#*(mc_prod_|mc_stag_)}
git merge $te --no-ff --no-edit
}

function merge(){
branchName="$(git branch| grep -F "*" | awk '{print $2}')"
git checkout mc_stag_$branchName
git merge $branchName
git checkout mc_prod_$branchName
git merge $branchName
}
function pushall(){
branchName="$(git branch| grep -F "*" | awk '{print $2}')"
git push --atomic origin $branchName mc_stag_$branchName mc_prod_$branchName
open -a "Google Chrome" https://github.com/tokopedia/ads/pull/new/$branchName
}

function update(){
git fetch origin
git checkout master
git merge origin/master
git checkout production

git merge origin/production

git checkout staging
git merge origin/staging
}
function push(){

branchName="$(git branch| grep -F "*" | awk '{print $2}')"

git push origin head  --no-verify  
if [[ $branchName == *"prod"* ]]; then
open -a "Google Chrome" https://github.com/tokopedia/ads/compare/production...$branchName
elif [[ $branchName == *"stag"* ]]; then
open -a "Google Chrome" https://github.com/tokopedia/ads/compare/staging...$branchName
else
open -a "Google Chrome" https://github.com/tokopedia/ads/compare/master...$branchName
fi
}

function stb(){
branchName="$(git branch| grep -F "*" | awk '{print $2}')"
git checkout mc_stag_$branchName
}

function prdb(){
branchName="$(git branch| grep -F "*" | awk '{print $2}')"
git checkout mc_prod_$branchName
}

function fb(){
branchName="$(git branch| grep -F "*" | awk '{print $2}')"
te=${branchName#*(mc_prod_|mc_stag_)}
git checkout $te
}

