# Preface
It should be noted that this algorithm will not work for all kinds of images as there is no universal approach to fully automated particle sizing. It relies on automated thresholding in order to segment the image and therefore it will fail to analyse low signal-to-noise or poor contrast images.

An example of a good image which the algorithm has managed to segment and analyse fairly well is presented here:

![SEM example](https://github.com/blongbot/ParticleSizingSEMTEM/blob/master/example.png)

# ParticleSizingSEMTEM Instructions
Start by downloading the main script: "SizingScript.ijm" or copying and pasting it into a text editor and save locally as either .txt or .ijm. 

This is an ImageJ batch processing particle sizing script written with SEM images in mind but hopefully also works for TEM images. The script prompts the user to select an input directory where your image files a stored and an output directory to store the results. It will process all tiff image files in the input directory.

To run the script in ImageJ use the Plugins > Macros > Run... route and double click the script file (.txt or .ijm).

## Input Image Info

After input and output directories are selected the script then asks the user for some simple information regarding the image:

![Image Info](https://github.com/blongbot/ParticleSizingSEMTEM/blob/master/Imageinfo.PNG)

1. Particle circularity range (0.0-1.0):

This is taken from the Analyze Particles command of ImageJ and is used as a selection criteria for more circular shaped objects. The narrower the range, i.e. 0.9-1.0, the closer the object of interest should be to a circle. For very rough objects, e.g. synthetic clay nanoparticles, this number should be set low i.e. 0.2-1.0. The default setting is 0.2. To clarify you don't need to insert a range here just the lower fraction.

2. Approximate lower limit particle size (pix^2):

This is again taken from the Analyze Particles command and allows the user to select a lower limit for the particle detected in the image. It is advised to carefully select a size (area in pixels^2) that represents the smallest particles you wish to measure. Selecting below 10 pix^2 is likely to erroneously pick up noise. The default is 20.

3. SEM or TEM image?

Self explanatory. This is used to determine whether we are working with light particles on a dark background (SEM) or dark particles on a light background (TEM).

## Data Output

After inputing these parameters, the code will run and output an image of the traced particle outlines for each analyzed tiff image along with a .csv file  containing the size data that can be opened in Excel. The size data is presented in pixel units so conversion will need to be done afterwards by the user. The .csv file contains a table with the following columns:

![Sample Output Table](https://github.com/blongbot/ParticleSizingSEMTEM/blob/master/csvoutput.PNG)

The first column contains the particle number identifier, the second lists the filename, third is the measured area for each particle in pixels^2, the rest of the columns are then outputs from Feret diameter measurements. Feret gives essentially a caliper distance across the particle and therefore is a measure of the max diameter around the particle. This is useful for rough particles.

Good luck with your measurements!

