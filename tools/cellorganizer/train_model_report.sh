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
    
echo "# Train generative model tool output" > report.md

if [ -f model_information.txt ]; then
	echo "\`\`\`" >> report.md
	cat model_information.txt >> report.md
	echo "\`\`\`" >> report.md
fi

echo "* [View Log](./diary.txt)" >> report.md
if [ -f model.mat ]; then
	echo "* [Model Download](./model.mat)" >> report.md
fi

echo " " >> report.md
if [ -f param.zip ]; then
    echo "* [Parameterization Download](./param.zip)" >> report.md
fi

echo " " >> report.md
if [ -f temp.zip ]; then
    echo "* [Temporary Results Download](./temp.zip)" >> report.md
fi

echo " " >> report.md
if [ -f options.mat ]; then
    echo "* [Options used in Main function Call](./options.mat)" >> report.md
fi


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

if [ -f options.mat ]; then
    mv -v  options.mat $1
fi

#grip report.md --export report.html > /dev/null 2>&1
#sed -i '' 's/report.md/CellOrganizer+Galaxy/g' report.html

pandoc report.md -o report.html

if [ ! -f model.mat ]; then
	echo "Model file not found." 
	exit -1
else
	echo "Model file found."
	exit 0
fi