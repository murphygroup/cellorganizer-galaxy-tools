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
    
echo "# Train model tool report " > report.md
echo "## Log " >> report.md
echo "\`\`\`" >> report.md
cat diary.txt >> report.md
echo "\`\`\`" >> report.md
echo "[Model Download](./model.mat)" >> report.md
echo " " >> report.md
if [ -f param.zip ]; then
    echo "[Parameterization Download](./param.zip)" >> report.md
fi
echo " " >> report.md
if [ -f temp.zip ]; then
    echo "[Temporary Results Download](./temp.zip)" >> report.md
fi

echo "Making temporary folder "$1
if [ ! -d $1 ]; then
        mkdir $1
fi

if [ -f diary.txt ]; then
    mv -v diary.txt $1
fi

if [ -f model.mat ]; then
    mv -v model.mat $1
fi

if [ -f param.zip ]; then
    mv -v param.zip $1
fi

if [ -f temp.zip ]; then
    mv -v  temp.zip $1
fi

grip report.md --no-inline --export report.html > /dev/null 2>&1
sed -i '' 's/report.md/CellOrganizer+Galaxy Report/g' report.html