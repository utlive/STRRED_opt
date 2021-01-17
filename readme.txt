Copyright (c) 2017 The University of Texas at Austin
All rights reserved.

Permission to use, copy, or modify this software and its documentation for
educational and research purposes only and without fee is hereby granted,
provided that this copyright notice and the original authors' names appear on
all copies and supporting documentation. This program shall not be used, rewritten,
or adapted as the basis of a commercial software or hardware product without first
obtaining permission of the authors. The authors make no representations about the
uitability of this software for any purpose. It is provided "as is" without express
or implied warranty.

The following papers are to be cited in the bibliography whenever the software is used
as:
C. G. Bampis, P. Gupta, R. Soundararajan and A. C. Bovik, "SpEED-QA: Spatial Efficient 
Entropic Differencing for Image and Video Quality", Signal Processing Letters, under review
R. Soundararajan and A. C. Bovik, "RRED indices: Reduced reference entropic
differences for image quality assessment", IEEE Transactions on Image
Processing, vol. 21, no. 2, pp. 517-526, Feb. 2012

The attached code is a faster version of the original ST-RRED implementation: it calculates 
only one subband (corresponding to a unique combination of scale and orientation) and avoids
computing the whole multi-scale multi-orientation procedure.

For questions and/or comments please email Christos Bampis (cbampis@gmail.com).

