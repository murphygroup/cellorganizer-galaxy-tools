wget --quiet -O image.png -o /dev/null -nc $1

echo "Verifying file"
file image.png

echo "# Image " >> index.md
echo "<a href="image.png"><img src="image.png" width="100"></a>" >> index.md
echo "" >> index.md
echo "## Image information" >> index.md
echo "\`\`\`" >> index.md

identify -verbose image.png >> index.md

echo "\`\`\`" >> index.md

echo "Making temporary folder "$2
if [ ! -d $2 ]; then
	mkdir $2
fi

cp image.png $2

grip index.md --export index.html > /dev/null 2>&1
sed -i '' 's/index.md/CellOrganizer+Galaxy Report/g' index.html