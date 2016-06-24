# cellorganizer-galaxy
CellOrganizer tools and scripts for CellOrganizer on Galaxy+Bridges.

## Requirements
If you want to run all the tools in this repo, you will need to install these requirements in your Galaxy server or compute cluster

* [Matlab 2015a or higher](http://www.mathworks.com/)
  * [Statistics and Machine Learning Toolbox](http://www.mathworks.com/products/statistics/)
  * [Curve Fitting Toolbox](http://www.mathworks.com/products/curvefitting/)
  * [Image Processing Toolbox](http://www.mathworks.com/products/image/)
  * [SimBiology Toolbox](http://www.mathworks.com/help/simbio/)
* [ffmpeg](https://ffmpeg.org/). A complete, cross-platform solution to record, convert and stream audio and video.
* [pandoc](http://pandoc.org/).  A universal document converter.
* Python libraries
  * [tabulate](https://pypi.python.org/pypi/tabulate)
  * [Markdown](https://pypi.python.org/pypi/Markdown)

## Installation

To install CellOrganizer on Galaxy+Bridges you need to follow four steps.

### Step one: Install Requirements
You need to install the software in the previous section.

### Step two: Copy tools folders

### Step three: Set environmental variables in job configuration file

### Step four: Add tools to tool configuration file

```
<destination id="local" runner="local" >
  <env id="CELLORGANIZER">/pylon1/mc4s8dp/icaoberg/galaxy/cellorganizer</env>
  <env id="MATLAB">/opt/packages/matlab/R2016a/bin/matlab</env>
  <env id="BFTOOLS">/pylon1/mc4s8dp/icaoberg/tools/bioformats/bftools</env>
  <env id="FFMPEG">/usr/local/bin/FFMPEG</env>
  <env id="PANDOC">/usr/local/bin/pandoc</env>
</destination>
```

## Rules for developing tools for CellOrganizer on Galaxy+Bridges

These rules are meant for CellOrganizer developers and contributors.

1. Tools should fall into one of the following categories (1) Training, (2) Synthesis, (3) Demos, (4) Image Tools, (5) Model Tools or (6) Useful Tools.

2. Every tool name should start with a verb. If we do this, we can communicate the intention of the block better, e.g. show_image, train_model, etc.

3. You are more than welcome to use external tools to stitch output generated from CellOrganizer. However the tools you use should be stable, e.g. pandoc, python Markdown or ffmpeg.

4. Tools that generate more than one output, e.g. show_image_info, compare_models, should generate an HTML file with linked files. Those tools should have the option to allow users to export the document to PDF as well.

#Bugs and Questions

Any GitHub user can create an issue on our public repository

* [cellorganizer-galaxy-tools](https://github.com/icaoberg/cellorganizer-galaxy-tools/)

For other inquiries feel free to send an email to our mailing list

* [Send email to mailing list](mailto:cellorganizer@compbio.cmu.edu)
