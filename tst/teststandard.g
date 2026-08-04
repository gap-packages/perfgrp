#
# PerfGrp: GAP Library of Finite Perfect Groups
#
LoadPackage("PerfGrp");
TestDirectory( [
  DirectoriesPackageLibrary("PerfGrp","tst/manualexamples"),
  DirectoriesPackageLibrary("PerfGrp","tst/testinstall"),
  DirectoriesPackageLibrary("PerfGrp","tst/teststandard"),
  ], rec(exitGAP := true));
FORCE_QUIT_GAP(1);
