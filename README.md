[![Build Status](https://github.com/gap-packages/perfgrp/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/gap-packages/perfgrp/actions/workflows/CI.yml?query=branch%3Amaster)
[![Code Coverage](https://codecov.io/github/gap-packages/perfgrp/coverage.svg?branch=master&token=)](https://codecov.io/gh/gap-packages/perfgrp)

# The PerfGrp package for GAP

The GAP library of finite perfect groups provides, up to isomorphism, a list
of all perfect groups whose sizes are less than 2 000 000. The groups of
orders up to 10^6 have been enumerated by Derek F. Holt and Wilhelm Plesken
and published in their book "Perfect Groups" (Oxford University Press, 1989).
The remaining groups were enumerated by Alexander Hulpke.

In addition, this package provides methods for computing the perfect and
simple subgroups of a finite group, via the attributes
`RepresentativesPerfectSubgroups`, `RepresentativesSimpleSubgroups` and
`ConjugacyClassesPerfectSubgroups`.

This code used to be part of the GAP core system, and was moved into a
separate package to reduce the size of the GAP distribution and to allow
independent updates of the data.


## Documentation

Full information and documentation can be found in the manual, available as
PDF `doc/manual.pdf` or as HTML `doc/chap0_mj.html`, or on the package
homepage at

  <https://gap-packages.github.io/perfgrp/>


## Installation

PerfGrp is a needed package of GAP, so it is contained in every GAP
distribution and no separate installation is required.

To install a development version, place the contents of this repository into
the `pkg` directory of your GAP installation, in a subdirectory named
`perfgrp`.


## Contact

Please report any issues you encounter at

  <https://github.com/gap-packages/perfgrp/issues>


## License

PerfGrp is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

For details, see the file `LICENSE` distributed with this package or the FSF's
own site <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>.
