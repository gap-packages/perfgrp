#
# PerfGrp: GAP Library of Finite Perfect Groups
#
# Reading the implementation part of the package.
#

# See the comment in init.g for what this is about.
if not PERFGRP_PROVIDED_BY_GAP then
  ReadPackage( "perfgrp", "gap/perf.gi" );
  ReadPackage( "perfgrp", "gap/subgrp.gi" );
fi;
