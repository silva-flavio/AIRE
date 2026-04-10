# AIRE (Airspace Image-based Reproducible Evaluation)
A Fiji/ImageJ macro for automated and reproducible airspace morphometry

**Created**: April 7, 2026 **Last updated**: April 10, 2026
Author: Flávio Santos da Silva <flavio.santos [at] ufersa.edu.br>

---

## Welcome to AIRE!

AIRE is a user-friendly macro developed in FIJI (Fiji Is Just ImageJ) that quantifies pulmonary airspace size in lung histology images in an fully automated manner, as an alternative to the mean linear intercept (Lm).

---

## What AIRE does

The main AIRE output is the **mean airspace diameter**, computed as 2√(A/π), where A represents the mean airspace area.
For each image, AIRE also returns the image name, number of measured airspaces, and processing time, which are printed to a log window.
AIRE supports both unsupervised batch processing for multiple images and single-image analysis. 

---

## Requirements

- [Fiji](https://imagej.net/downloads) or [plain ImageJ](https://imagej.net/downloads) v. 1.54p or later
- No additional plugins required

---

## How to use

Open the Fiji or ImageJ. Then, drag and drop the macro file (AIRE.ijm) onto the Fiji/ImageJ toolbar to open a macro editor window. 

AIRE is structured in 12 code blocks: 1–4 specify requirements (ImageJ version, processing preferences and spatial calibration); 
5–9 constitute the core of the macro (i.e., the image processing and analysis); 
10–12 compute descriptive results for batch processing.

To analyze multiple images automatically, copy/paste the full code (lines 1 to 92) in the batch macro window (Process > Batch > Macro...), select the input folder and press "Process".

To run AIRE step by step and supervise the image processing, open one image at a time (File > Open), select the intended code line(s)/block(s) and press Ctrl + R on the keyboard (Ctrl + Shift + R for Fiji users). 

To obtain individual airspace data instead of means for each image, select the lines 1 to 60 (up to the code block number 9) and execute the commands (Ctrl + R in plain ImageJ, and Ctrl + Shift + R in Fiji).
	
---

## Repository contents

| Folder | File | Description |
|---|---|---|
| data/ | `Lm_data_examiner 1.csv` | Manual Lm measurements by Expert Examiner 1 |
|       | `Lm_data_examiner 2.csv` | Manual Lm measurements by Expert Examiner 2 |
|       | `Lm_data_examiner 3.csv` | Manual Lm measurements by Expert Examiner 3 |
|       | `AIRE_and_Lm_data.csv` | AIRE output & averaged Lm measurements |
| images/ | `*.jpg`| Dataset of 89 H&E lung micrographs used for validation |
| macro/ | `AIRE.ijm` | Fiji/ImageJ macro |
| stats/ | `Stats_report.pdf` | Validation tests and raw data tables from GraphPad Prism v. 8.0.2 |
| (root) | `LICENSE` | Terms for software and data use |
| (root) |`README.md` | AIRE usage instructions |

---

## License

MIT License — see [LICENSE](LICENSE) for details.
