macro 'AIRE' {

 // --- Created on April 7, 2026 by Flavio S. Silva using Fiji (Fiji is just ImageJ), v. 1.54p ---
 
 // "Refer to README.md for instructions; supporting files are located in the repository folders.

 // 1) Aborts the macro if the ImageJ version is less than the specified:
 requires("1.54p");

 // 2) Sets foreground (255, white) and background (0, black) colors:
 run("Colors...", "foreground=white background=black selection=yellow");

 // 3) Specifies binary image processing preferences:
 run("Options...", "iterations=1 count=1 black pad do=Nothing");

 // 4) Prompts the user to type the scale only once (in the first image) for spatial calibration:
 if (is("global scale")) {
 } else {
     Dialog.create("Type and set scale");
     Dialog.addNumber("Number of pixels/micrometer", 0);
     Dialog.show();
     d=Dialog.getNumber();
     run("Set Scale...", "distance=d known=1 pixel=1 unit=µm global");
 }
	
 // 5) Defines a start point to compute image processing time (in seconds).
 // Then, extracts the name of the current RGB image and converts it to 8–bit:
 start = (getTime()/1000);
 t=getTitle;
 run("8-bit");
	
 // 6) Corrects non-uniform background and illumination to enhance segmentation
 // and binarizes the image using a fuzzy-based global thresholding method:
 run("Subtract Background...", "rolling=250 light sliding");
 setAutoThreshold("Huang");
 setOption("BlackBackground", true);
 run("Convert to Mask");

 // 7) Performs successive filtering for edge-preserving noise reduction,
 // removes isolated particles whithin airspaces, and inverts the image:
 run("Median...", "radius=5");
 run("Median...", "radius=5");
 run("Median...", "radius=5");
 run("Analyze Particles...", "size=1000-Infinity circularity=0.00-0.50 show=Masks");
 run("Invert LUT");
 run("Invert");

 // 8) Smooths alveolar walls further and fills internal voids (< 10 µm) 
 // to ensure a solid mask. The resulting image is then inverted back:
 run("Median...", "radius=5");
 run("Median...", "radius=5");
 run("Median...", "radius=5");
 run("Analyze Particles...", "size=80-Infinity show=Masks");
 run("Invert LUT");	

 // 9) Measures individual airspace areas, closes all images, and
 // defines an end point to compute image processing time (s):
 Defines an end point to compute image processing time in seconds:
 run("Set Measurements...", "area display redirect=None decimal=3");
 run("Analyze Particles...", "size=270-Infinity circularity=0.30-1.00 display clear");
 run("Close All");
 finish = (getTime()/1000);

 // 10) Defines variables to retrieve the airspace count and mean area.
 //Then, computes mean airspace diameter from the equivalent circle:
 N = nResults;
 a = Table.getColumn("Area");
 Array.getStatistics(a, min, max, Mean_Area, std);
 Mean_Diameter = 2 * sqrt(Mean_Area / PI);
 
 // 11) Closes the Results table and writes a summary to a new output table:
 close("Results");
 Table.set("Label", nResults, t);
 Table.set("Airspace count", nResults-1, N);
 Table.set("Mean airspace area (µm²)", nResults-1, Mean_Area);
 Table.set("Mean airspace diameter (µm)", nResults-1, Mean_Diameter);
 Table.set("Execution time (s)", nResults-1, finish-start);
 Table.update;
	
 // 12) Appends results to a Log window:
 run("Input/Output...", "jpeg=85 gif=-1 file=.csv use_file copy_column");
 if (isOpen("Log")) {
     setOption("CopyHeaders", false);
     String.copyResults;
     String.paste;
 }
 else {
     setOption("CopyHeaders", true);
     String.copyResults 
     String.paste;
 }
}
