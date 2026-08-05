#
# PerfGrp: GAP Library of Finite Perfect Groups
#
# Reading the declaration part of the package.
#

#
# GAP 4.16 and earlier ship the perfect groups library as part of the GAP
# library itself, in `grp/perf*`. When this package is loaded into such a
# version of GAP, it must not read any of its own files: everything it
# provides is already there, and reading them would re-declare existing
# global variables. Loading the package is then simply a no-op, which makes
# it possible to distribute PerfGrp before the corresponding change to GAP
# has been released.
#
# Note that this is deliberately *not* a version number comparison:
# `CompareVersionNumbers` considers every version ending in "dev" to be newer
# than any release, so a test such as
#
#     CompareVersionNumbers( GAPInfo.Version, "4.17" )
#
# is true for a `stable-4.16` build of GAP, which reports its version as
# "4.16dev". Testing for the data files that used to be part of GAP gives the
# right answer for release and development versions alike.
#
BindGlobal( "PERFGRP_PROVIDED_BY_GAP",
    function()
      local dirs;
      dirs := DirectoriesLibrary( "grp" );
      return dirs <> fail and Filename( dirs, "perf0.grp" ) <> fail;
    end() );

if not PERFGRP_PROVIDED_BY_GAP then
  ReadPackage( "perfgrp", "gap/perf.gd" );
fi;
