#############################################################################
##
##  PackageInfo.g for the package `PerfGrp'
##

SetPackageInfo( rec(

PackageName := "PerfGrp",
Subtitle := "GAP Library of Finite Perfect Groups",
Version := "1.0.0",
Date := "04/08/2026", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

PackageWWWHome :=
  Concatenation( "https://gap-packages.github.io/",
      LowercaseString( ~.PackageName ), "/" ),

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/gap-packages/", LowercaseString( ~.PackageName ) ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),

ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", LowercaseString( ~.PackageName ), "-", ~.Version ),

ArchiveFormats := ".tar.gz",

Persons := [
  rec(
    LastName      := "Hulpke",
    FirstNames    := "Alexander",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "hulpke@math.colostate.edu",
    WWWHome       := "https://www.math.colostate.edu/~hulpke/",
    GitHubUsername := "hulpke",
    PostalAddress := Concatenation( [
                     "Department of Mathematics\n",
                     "Colorado State University\n",
                     "1874 Campus Delivery\n",
                     "Fort Collins, CO 80523-1874\n",
                     "USA" ] ),
    Place         := "Fort Collins, CO",
    Institution   := "Colorado State University",
  ),
  rec(
    LastName      := "Holt",
    FirstNames    := "Derek F.",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "D.F.Holt@warwick.ac.uk",
    WWWHome       := "https://homepages.warwick.ac.uk/~mareg/",
    Place         := "Coventry",
    Institution   := "University of Warwick",
  ),
  rec(
    LastName      := "Plesken",
    FirstNames    := "Wilhelm",
    IsAuthor      := true,
    IsMaintainer  := false,
    Place         := "Aachen",
    Institution   := "RWTH Aachen",
  ),
  rec(
    LastName      := "Felsch",
    FirstNames    := "Volkmar",
    IsAuthor      := true,
    IsMaintainer  := false,
    Place         := "Aachen",
    Institution   := "RWTH Aachen",
  ),
  rec(
    IsAuthor      := false,
    IsMaintainer  := true,
    LastName      := "GAP Team",
    FirstNames    := "The",
    Email         := "support@gap-system.org",
    WWWHome       := "https://www.gap-system.org",
  ),
],

Status := "deposited",

README_URL :=
  Concatenation( ~.PackageWWWHome, "README.md" ),
PackageInfoURL :=
  Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML :=
  "The <span class=\"pkgname\">PerfGrp</span> package provides the library \
  of finite perfect groups, which contains, up to isomorphism, all perfect \
  groups of order less than 2 000 000, as well as functionality for \
  determining the perfect subgroups of a finite group.",

PackageDoc := rec(
  BookName  := "perfgrp",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "GAP Library of Finite Perfect Groups",
),

Dependencies := rec(
  GAP := ">= 4.15",
  NeededOtherPackages := [],
  SuggestedOtherPackages := [],
  ExternalConditions := [],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := ["perfect group", "group library"],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
&copyright; 1989-2026 by the authors.<P/>

This package is free software; you can redistribute it and/or modify it under
the terms of the <URL Text="GNU General Public License">
https://www.fsf.org/licenses/gpl.html</URL> as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.
""",
        Abstract := """
The <Package>PerfGrp</Package> package provides the &GAP; library of finite
perfect groups, and functionality for determining the perfect subgroups of a
finite group.
""",
    ),
    entities := rec(
        VERSION := ~.Version,
        RELEASEDATE := function(date)
          local day, month, year, allMonths;
          day := Int(date{[1,2]});
          month := Int(date{[4,5]});
          year := Int(date{[7..10]});
          allMonths := [ "January", "February", "March", "April", "May", "June", "July",
                         "August", "September", "October", "November", "December"];
          return Concatenation(String(day)," ", allMonths[month], " ", String(year));
        end(~.Date),
        RELEASEYEAR := ~.Date{[7..10]},
    ),
),

));
