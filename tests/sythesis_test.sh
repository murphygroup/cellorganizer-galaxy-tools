MODEL1="/Users/timmajarian/Documents/Murphylab/projects/cellorganizer/models/3D/diffeomorphic/hela_model.mat"
MODEL2=""
MODEL3=""
MODEL4=""
MODEL5=""
MODEL6=""
SYNTHESISFLAG="all"
NUMIMGS="2"
RESOLUTION=.05
PREFIX="testing"
COMPRESSION="lzw"
MICROSCOPE=""
SAMPLINGMETHOD=""
VERBOSE="true"
DEBUG="false"
RANDOMWALK="false"
WALKSTEPS=1
WALKTYPE=""
TIF="true"
INDEXED="true"
BLENDER="true"
SBML="true"

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
