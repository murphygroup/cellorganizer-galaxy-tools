dataset=<'path to text file with image paths in it'>
dnachannel=1
cellchannel=2
proteinchannel=3
masks="nothing"
trainflag="all"
modelname="hela_test"
modelid="1"
downsample=5
nucleustype="diffeomorphic"
nucleusname="test"
nucleusclass="framework"
nucleusid="1"
celltype="diffeomorphic"
cellname="test_hela_cell"
cellclass="framework"
cellid="1"
proteintype="gmm"
proteinname="mito"
proteinclass="vesicle"
proteinid="1"
proteincytonuclearflag="cyto"
documentation="testing"
verbose="true"
debug="false"

cd tools/cellorganizer
rm -fv ./cellorganizer
bash ./train_model.sh $dataset $dnachannel $cellchannel $proteinchannel $masks $trainflag $modelname $modelid $downsample $nucleustype $nucleusname $nucleusclass $nucleusid $celltype $cellname $cellclass $cellid $proteintype $proteinname $proteinclass $proteinid $proteincytonuclearflag $documentation $verbose $debug

FILE1=hela_test.mat
if [ -f $FILE1 ]; then
	echo "File exists"
else
	echo "Output file $FILE1 does not exist."
	exit -1
fi
