//MACRO TO BATCH PROCESS SEM IMAGES AND ANALYZE PARTICLE SIZE

//PROMPTS THE USER FOR AN INPUT AND OUTPUT DIRECTORY FOR FILES
dir1 = getDirectory("Choose Source Directory ");
dir2 = getDirectory("Choose Destination Directory ");
list = getFileList(dir1);
Dialog.create("Image Info");
Dialog.addNumber("Particle circularity range (0.0-1.0):", 0.2);
Dialog.addNumber("Approximate lower limit particle size (pix):", 20);
Dialog.addChoice("SEM image or TEM image?", newArray("SEM", "TEM"));
Dialog.show();
type = Dialog.getChoice();
circ = Dialog.getNumber();
small = Dialog.getNumber();;
setBatchMode(true);
run("Set Measurements...", "area feret's display add redirect=None decimal=3");

 	
 	//ONLY PROCESS SPECIFIC FILES 
		for (i=0; i<list.length; i++) {
			filename = dir1 + list[i];

			if (endsWith(filename, ".tif") || endsWith(filename, "tiff") || endsWith(filename, "Tif") || endsWith(filename, "Tiff") || endsWith(filename, "TIF") || endsWith(filename, "TIFF")) {
 				showProgress(i+1, list.length);
			    open(filename);

		//PROCESS IMAGES
		  run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixels");	//Makes sure that no scale is setup
		  run("8-bit");

          if (type=="SEM") run("Canvas Size...", "width=1024 height=680 position=Top-Center");	//Crops SEM images only.
          if (type=="TEM") run("Invert");	//Inverts the image if it's a TEM image where you have dark particles on a light background.
          
          small2 = 2*small;

          if (type=="SEM") run("Subtract Background...", "rolling=small2");	//Removes background noise and artefacts from the image.
          if (type=="TEM") run("Gaussian Blur...", "sigma=4");

          if (type=="SEM") setAutoThreshold("IsoData dark no-reset");	//Threshold the image to segment particles from background.
          if (type=="TEM") {
          	run("Find Edges"); 
          	setAutoThreshold("Otsu dark");
      };
          setOption("BlackBackground", false);
          run("Convert to Mask");
          
          run("Fill Holes");	//Does as it says - fills in any holes in the middle of particles.
          
          if (type=="TEM") run("Watershed");
          name = File.nameWithoutExtension;

       	//ANALYZE PARTICLES
       	run("Analyze Particles...", "size=small-Infinity circularity=circ-1.00 show=Outlines display exclude");	//Analyzes the particle size distribution based on the binary image and user input settings.
				saveAs("Tiff", dir2 + name + ".tiff");
		
		//SAVE RESULTS AND CLOSE WINDOW
				close();
				}
		} 
		saveAs("Results", dir2 + name + ".csv");
		run("Clear Results");

		    if (isOpen("Results")) { 
         selectWindow("Results"); 
         run("Close"); 
    }
