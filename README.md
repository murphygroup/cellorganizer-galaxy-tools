# cellorganizer-galaxy
CellOrganizer tools and scripts for Galaxy Project

## Rules for developing tools for Galaxy

These rules are meant for CellOrganizer developers and contributors.

1. Tools should fall into one of the following categories (1) Training, (2) Synthesis, (3) Demos, (4) Image Tools, (5) Model Tools or (6) Useful Tools.

2. Every tool name should start with a verb. If we do this, we can communicate the intention of the block better, e.g. show_image, train_model, etc.

3. You are more than welcome to use external tools to stitch output generated from CellOrganizer. However the tools you use should be stable, e.g. pandoc, python Markdown or ffmpeg.

4. Tools that generate more than one output, e.g. show_image_info, compare_models, should generate an HTML file with linked files. Those tools should have the option to allow users to export the document to PDF as well.

#Bugs and Questions

Any GitHub user can create an issue to our public repository

* [cellorganizer-galaxy-tools](https://github.com/icaoberg/cellorganizer-galaxy-tools/)
