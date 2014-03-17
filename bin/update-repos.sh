pushd $PWD > /dev/null
for i in $(find $1 -name "*.git")
do
    cd $i;
    git fetch;
done
popd
