#need correct modelpath
MODEL1=<path_to_model>
MODEL2="none"
MODEL3="none"
MODEL4="none"
MODEL5="none"
MODEL6="none"
SYNTHESISFLAG="all"
NUMIMGS="2"
RESOLUTION=.05
PREFIX="testing"
COMPRESSION="lzw"
MICROSCOPE="none"
SAMPLINGMETHOD="disc"
VERBOSE="true"
DEBUG="false"
RANDOMWALK="false"
WALKSTEPS=1
WALKTYPE="none"
TIF="true"
INDEXED="true"
BLENDER="true"
SBML="true"

cd tools/cellorganizer
rm -fv ./cellorganizer
bash ./model_synth.sh $MODEL1 $MODEL2 $MODEL3 $MODEL4 $MODEL5 $MODEL6 $SYNTHESISFLAG $NUMIMGS $RESOLUTION $PREFIX $COMPRESSION $MICROSCOPE $SAMPLINGMETHOD $VERBOSE $DEBUG $RANDOMWALK $WALKSTEPS $WALKTYPE $TIF $INDEXED $BLENDER $SBML

# need correct model name
FILE1=hela_test.zip
if [ -f $FILE1 ]; then
	echo "File exists"
else
	echo "Output file $FILE1 does not exist."
	exit -1
fi
