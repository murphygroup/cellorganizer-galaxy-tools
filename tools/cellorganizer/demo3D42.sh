if [ -d param ]; then
    zip -r param.zip param
    rm -rfv param
fi

if [ -d temp ]; then
    zip -r temp.zip temp
fi

if [ -f diary.txt ]; then
    file diary.txt
fi

if [ -f models/LAT_reltime_0.mat ]; then
    file models/LAT_reltime_0.mat
    cp models/LAT_reltime_0.mat .
fi

if [ -f param.zip ]; then
    file param.zip
fi
    
if [ -f temp.zip ]; then
    file temp.zip
fi
    
echo "# demo3D42" > report.md

for F in temp/illustrations/*.png
do
    echo "## "$(basename $F) >> report.md
    echo "!["$(basename $F)"]("$F")" >> report.md
    echo "" >> report.md
done

echo "* [View Log](./diary.txt)" >> report.md
if [ -f LAT_reltime_0.mat ]; then
	echo "* [Model Download](./LAT_reltime_0.mat)" >> report.md
fi

echo " " >> report.md
if [ -f param.zip ]; then
    echo "* [Parameterization Download](./param.zip)" >> report.md
fi

echo " " >> report.md
if [ -f temp.zip ]; then
    echo "* [Temporary Results Download](./temp.zip)" >> report.md
fi

echo "Making temporary folder "$1
if [ ! -d $1 ]; then
        mkdir $1
fi

if [ -f diary.txt ]; then
    mv -v diary.txt $1
fi

if [ -f LAT_reltime_0.mat ]; then
    cp -v LAT_reltime_0.mat $1
fi

if [ -f param.zip ]; then
    mv -v param.zip $1
fi

if [ -f temp.zip ]; then
    mv -v  temp.zip $1
fi

if [ -d temp ]; then
    mv -v temp $1
fi

pandoc report.md -o report.html