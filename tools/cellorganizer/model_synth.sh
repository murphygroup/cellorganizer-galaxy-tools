find . -type f -name "cell*.ome.tif" -exec mv -v {} . \;
find . -type f -name "cell*.xml" -exec mv -v {} . \;

if [ -d param ]; then
    zip -r param.zip param
    rm -rfv param
fi

if [ -d temp ]; then
    zip -r temp.zip temp
    rm -rfv temp
fi

if [ -f diary.txt ]; then
    file diary.txt
fi

if [ -f model.mat ]; then
    file model.mat
fi

if [ -f param.zip ]; then
    file param.zip
fi
    
if [ -f temp.zip ]; then
    file temp.zip
fi

for I in *.ome.tif
do
    file $I
done
    
echo "# Image synthesis" > report.md
echo "[Log](./diary.txt)" >> report.md
for I in *.ome.tif
do
    echo "[$I](./$I)" >> report.md
done

echo "Making temporary folder "$1
if [ ! -d $1 ]; then
        mkdir $1
fi

if [ -f diary.txt ]; then
    mv -v diary.txt $1
fi

if [ -f model.mat ]; then
    cp -v model.mat $1
fi

if [ -f param.zip ]; then
    mv -v param.zip $1
fi

if [ -f temp.zip ]; then
    mv -v  temp.zip $1
fi

if [ -f report.md ]; then
    cp -v  report.md $1
fi

for I in *.ome.tif
do
    cp -v $I $1
done

grip report.md --export report.html > /dev/null 2>&1
sed -i '' 's/report.md/CellOrganizer+Galaxy/g' report.html