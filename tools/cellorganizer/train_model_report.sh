zip -r param.zip param

file diary.txt
file model.mat
file param.zip
# file temp.zip

echo "# Demo1D01 " > report.md
echo "# diarys " >> report.md
echo " " >> report.md
cat diary.txt >> report.md
echo " " >> report.md
echo "![Model Download](./model.mat)" >> report.md
echo " " >> report.md
echo "![Parameterization Download](./param.zip)" >> report.md
echo " " >> report.md
# echo "![Temporary Results Download](./temp.zip)" >> report.md

echo "Making temporary folder "$1
if [ ! -d $1 ]; then
        mkdir $1
fi
mv diary.txt $1
mv model.mat $1
mv param.zip $1
# mv temp.zip $1
grip report.md --no-inline --export report.html