wget --spider --header 'Accept: application/json' 'http://localhost:7200/rest/repositories/test-repo'
if [ $? != 0 ]
then
    exit 1
fi
exit 0