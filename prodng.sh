fin()
{
        echo ~/Downloads/tsh ssh --proxy=ports2.tokopedia.net:3080 readonly@${1} 'grep "'$2'" /var/log/eventapp/eventapp.*.log'
        if ~/Downloads/tsh ssh --proxy=ports2.tokopedia.net:3080 readonly@${1} 'ls -al /var/www/eventapp/bin'
        then
           echo "found@"
           echo -e "\033[1;31m ~/Downloads/tsh ssh --proxy=ports2.tokopedia.net:3080 readonly@${1} \033[0m"
           echo $1;
        else
                echo "---------------------------------$1"
        fi
}
#~/Downloads/tsh ls |grep eventapp|grep -oE  "=172.\b([0-9]{1,3}\.){2}[0-9]{1,3}\b" |grep -oE  "172.\b([0-9]{1,3}\.){2}[0-9]{1,3}\b">prodlist
#read -p "word??? " word
word=$@
#word=POxCPF4rQU61UaBuk6M39w
echo $1 $2 $3
cat prodlist | while read line; do
        #server= readonly@${line}
        fin $line $word &
done
