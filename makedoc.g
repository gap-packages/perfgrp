#
# PerfGrp: GAP Library of Finite Perfect Groups
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", ">= 2019.04.10") then
    Error("AutoDoc 2019.04.10 or newer is required");
fi;

AutoDoc(rec(
    scaffold := rec( includes := [ "perfgrp.xml" ],
                     bib := "manualbib.xml" ),
    extract_examples := true,
));
