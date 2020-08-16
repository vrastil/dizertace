[![Build Status](https://travis-ci.com/vrastil/dizertace.svg?token=ANedE2SyoBfAxbp1hMca&branch=master)](https://travis-ci.com/vrastil/dizertace)
# Study of dark energy and modified gravity and their influence on the cosmological parameters of the universe
Online version can be viewed at [Github-pages](https://vrastil.github.io/dizertace/)
## Compilation
From the root directory
````sh
make
````
with optional pre-step (e.g. after unsuccessful build)
````sh
make clean
````

# PDF/A-2B Compatibility
Notes for creation of PDFs that are compitable with A-2B  (A-2U) standards.
## Matplotlib
Use PS as backend and Latex fonts:
````
import pyplot as plt
import matplotlib

matplotlib.use('PS')    # generate postscript output by default
plt.rcParams.update({"text.usetex": True})  # LaTeX option is activated
````
## EPS conversion
To convert `.eps` files created by matplotlib to the right PDF format, use the following command
````sh
ps2pdf -q -dEPSCrop -dBATCH -dNOPAUSE -sDEVICE=pdfwrite \
			        -dPDFA -dPDFACompatibilityPolicy=1 \
				    -sProcessColorModel=DeviceRGB -dUseCIEColor \
                    -sOutputFile=OUTPUT_PDF INPUT_EPS
````
For Windows, use `#` instead of `=`. See `Makefile` for usage.

## Latex setting
In Latex, use package `pdfx` with appropriate setting
````
\usepackage[a-2u]{pdfx}
````
You can use `[a-2b]` if you do not need unicode support.