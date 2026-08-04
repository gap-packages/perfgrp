#############################################################################
##
##  This file is part of PerfGrp, the GAP library of finite perfect groups.
##  This file's authors include Alexander Hulpke.
##
##  SPDX-License-Identifier: GPL-2.0-or-later
##
##  This file contains the methods for determining the perfect and simple
##  subgroups of a finite group, using the Holt/Plesken/Hulpke library.
##


BindGlobal("RepsPerfSimpSub",function(G,simple)
local badsizes,n,un,cl,r,i,l,u,bw,cnt,gens,go,imgs,bg,bi,emb,nu,k,j,
      D,params,might,bo,pls;
  if IsSolvableGroup(G) then
    return [TrivialSubgroup(G)];
  elif Size(SolvableRadical(G))>1 and (IsPermGroup(G) or IsMatrixGroup(G)) then
    D:=LatticeViaRadical(G,IsPerfectGroup);
    D:=List(D!.conjugacyClassesSubgroups,Representative);
    if simple then
      D:=Filtered(D,IsNonabelianSimpleGroup);
    else
      D:=Filtered(D,IsPerfectGroup);
    fi;
    return D;
  else
    PerfGrpLoad(0);
    badsizes := PERFRec.notKnown;
    D:=G;
    D:=PerfectResiduum(D);
    n:=Size(D);
    Info(InfoLattice,1,"The perfect residuum has size ",n);

    # sizes of possible perfect subgroups
    un:=Filtered(DivisorsInt(n),i->i>1
                 # index <=4 would lead to solvable factor
                 and i<n/4);

    # if D is simple, we can limit indices further
    if IsNonabelianSimpleGroup(D) then
      k:=4;
      l:=120;
      while l<n do
        k:=k+1;
        l:=l*(k+1);
      od;
      # now k is maximal such that k!<Size(D). Thus subgroups of D must have
      # index more than k
      k:=Int(n/k);
      un:=Filtered(un,i->i<=k);
    fi;
    Info(InfoLattice,1,"Searching perfect groups up to size ",Maximum(un));

    pls:=Maximum(SizesPerfectGroups());
    if ForAny(un,i->i>pls) then
      # go through maximals
      cl:=Unique(List(MaximalSubgroupClassReps(G),PerfectResiduum));
      cl:=SubgroupsOrbitsAndNormalizers(G,cl,false);
      cl:=List(cl,x->x.representative);
      l:=List(cl,RepresentativesPerfectSubgroups);
      l:=Unique(Concatenation(l));
      r:=List(SubgroupsOrbitsAndNormalizers(G,l,false),x->x.representative);;
      SortBy(r,Size);
      return r;
    fi;

    un:=Filtered(un,i->i in PERFRec.sizes);
    if Length(Intersection(badsizes,un))>0 then
      Error(
        "failed due to incomplete information in the Holt/Plesken library");
    fi;

    cl:=Filtered(ConjugacyClasses(G),i->Representative(i) in D);
    Info(InfoLattice,2,Length(cl)," classes of ",
         Length(ConjugacyClasses(G))," to consider");

    if Length(un)>0 and ValueOption(NO_PRECOMPUTED_DATA_OPTION)=true then
      Info(InfoWarning,1,
      "Using (despite option) data library of perfect groups, as the perfect\n",
      "#I  subgroups otherwise cannot be obtained!");
    elif Length(un)>0 then
      Info(InfoPerformance,2,"Using Perfect Groups Library");
    fi;

    r:=[];
    for i in un do

      l:=NumberPerfectGroups(i);
      if l>0 then
        for j in [1..l] do
          u:=PerfectGroup(IsPermGroup,i,j);
          Info(InfoLattice,1,"trying group ",i,",",j,": ",u);

          # test whether there is a chance to embed
          might:=simple=false or IsNonabelianSimpleGroup(u);
          cnt:=0;
          while might and cnt<20 do
            bg:=Order(Random(u));
            might:=ForAny(cl,i->Order(Representative(i))=bg);
            cnt:=cnt+1;
          od;

          if might then
            # find a suitable generating system
            bw:=infinity;
            bo:=[0,0];
            cnt:=0;
            repeat
              if cnt=0 then
                # first the small gen syst.
                gens:=SmallGeneratingSet(u);
              else
                # then something random
                repeat
                  if Length(gens)>2 and Random(1,2)=1 then
                    # try to get down to 2 gens
                    gens:=List([1,2],i->Random(u));
                  else
                    gens:=List([1..Random(2, Length(SmallGeneratingSet(u)))],
                      i->Random(u));
                  fi;
                  # try to get small orders
                  for k in [1..Length(gens)] do
                    go:=Order(gens[k]);
                    # try a p-element
                    if Random(1, 2*Length(gens))=1 then
                      gens[k]:=gens[k]^(go/(Random(Factors(go))));
                    fi;
                  od;

                until Index(u,SubgroupNC(u,gens))=1;
              fi;
              go:=List(gens,Order);
              imgs:=List(go,i->Filtered(cl,j->Order(Representative(j))=i));
              Info(InfoLattice,3,go,":",Product(imgs,i->Sum(i,Size)));
              if Product(imgs,i->Sum(i,Size))<bw then
                bg:=gens;
                bo:=go;
                bi:=imgs;
                bw:=Product(imgs,i->Sum(i,Size));
              elif Set(go)=Set(bo) then
                # we hit the orders again -> sign that we can't be
                # completely off track
                cnt:=cnt+Int(bw/Size(G)*3);
              fi;
              cnt:=cnt+1;
            until bw/Size(G)*6<cnt;

            if bw>0 then
              Info(InfoLattice,2,"find ",bw," from ",cnt);
              # find all embeddings
              params:=rec(gens:=bg,from:=u);
              emb:=MorClassLoop(G,bi,params,
                # all injective homs = 1+2+8
                11);
              #emb:=MorClassLoop(G,bi,rec(type:=2,what:=3,gens:=bg,from:=u,
              #                elms:=false,size:=Size(u)));
              Info(InfoLattice,2,Length(emb)," embeddings");
              nu:=[];
              for k in emb do
                k:=Image(k,u);
                if not ForAny(nu,i->RepresentativeAction(G,i,k)<>fail) then
                  Add(nu,k);
                  k!.perfectType:=[i,j];
                fi;
              od;
              Info(InfoLattice,1,Length(nu)," classes");
              r:=Concatenation(r,nu);
            fi;
          else
            Info(InfoLattice,2,"cannot embed");
          fi;
        od;
      fi;
    od;
    # add the two obvious ones
    Add(r,D);
    Add(r,TrivialSubgroup(G));
    return r;
  fi;
end);

# These are installed with a positive rank so that they take precedence over
# the fallback methods of the GAP library, which merely signal an error
# explaining that this package is required.

InstallMethod(RepresentativesPerfectSubgroups,
  "using Holt/Plesken/Hulpke library",true,[IsGroup],1,
  G->RepsPerfSimpSub(G,false));

InstallMethod(RepresentativesSimpleSubgroups,
  "using Holt/Plesken/Hulpke library",true,[IsGroup],1,
  G->RepsPerfSimpSub(G,true));

