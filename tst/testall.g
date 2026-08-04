#
# PerfGrp: GAP Library of Finite Perfect Groups
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage("PerfGrp");
TestDirectory( [
  DirectoriesPackageLibrary("PerfGrp","tst/manualexamples"),
  DirectoriesPackageLibrary("PerfGrp","tst/testinstall"),
  ], rec(exitGAP := true));
FORCE_QUIT_GAP(1);
