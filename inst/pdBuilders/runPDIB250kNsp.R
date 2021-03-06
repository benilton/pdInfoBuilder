
library("pdInfoBuilder")

targ = "../pd.mapping250k.nsp"

if (file.exists(targ)) stop(paste("cannot have folder", targ,
   "present if you want to build there"))

parms_pref = "../../parms_store/pd.mapping250k.nsp"  # should be in parms_store
anno_pref = "../../anno_store/pd.mapping250k.nsp"
pat = function(x) paste(parms_pref, x, sep="/")
pat2 = function(x) paste(anno_pref, x, sep="/")

# next 4 lines gunzip contents of anno_store, if needed
curd = getwd()
setwd(anno_pref)
try(system( paste(c("gunzip", dir(patt="gz$")), collapse=" ")))
setwd(curd)

cdfFile <- pat2("Mapping250K_Nsp.cdf")
csvAnno <- pat2("Mapping250K_Nsp.na24.annot.csv")
csvSeq <- pat2("Mapping250K_Nsp_probe_tab")
spline <- pat("pd.mapping250k.nsp.spline.params.rda")
refd <- pat("pd.mapping250k.nspRef.rda")
crlmmInf <- pat("pd.mapping250k.nspCrlmmInfo.rda")

pkg <- new("AffySNPPDInfoPkgSeed",
           version="0.3.5",
           author="Vince Carey", email="stvjc@channing.harvard.edu",
           biocViews="AnnotationData",
           genomebuild="NCBI Build 36",
           cdfFile=cdfFile, csvAnnoFile=csvAnno, csvSeqFile=csvSeq,
           splineParamFile=spline, crlmmInfoFile=crlmmInf,
           referenceDistFile=refd)


makePdInfoPackage(pkg, destDir="..")

# next 4 lines gzip contents of anno_store
curd = getwd()
setwd(anno_pref)
try(system( paste(c("gzip", dir()), collapse=" ")))
setwd(curd)

