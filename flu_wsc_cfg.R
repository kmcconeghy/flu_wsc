#
# Title: Configure and project set-up
# Purpose: Automate R-specs
# Programmer: Kevin W. McConeghy
# Date Created: 2018.11.21
#

#--System options
options(scipen=999)
options(max.print = 500)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre-9.0.1')

#--Directories
wd <- 'C:\\Users\\Rluv\\Documents\\GitHub\\flu_wsc'

#--Load up project parameters
ParamPath <- list.files(path = paste0(wd, '\\'),
                        pattern='params.xlsx', full.names = T)
ParamTypes <- c('FileNames', 'Objects', 'FilePaths', 'Packages')
Param <- list()
for (i in ParamTypes) {
  Param[[i]] <- readxl::read_excel(ParamPath, i)
}

#--Directories
## Assign directory filepaths according to param file
Directory <- Param$FilePaths
for (i in 1:nrow(Directory)) {
  if (stringr::str_detect(Directory$PathName[i], 'wd.')==T) {## standards
    assign(Directory$PathName[i],
           paste0(wd, '\\', Directory$Path[i], '\\'))
  } else {
    assign(Directory$PathName[i], Directory$Path[i])
  }
}

#--Packages to be loaded
suppressWarnings(library('tidyverse', character.only=T, quietly=T, warn.conflicts = F)) #-- Always load first
Packages <- Param$Packages %>%
  dplyr::filter(CodeFileId=='00') %>%
  .[['PackageName']]
suppressMessages(sapply(Packages, library, character.only=T, warn.conflicts = F, quietly=T))

#--Source local functions
prj.func <- list.files(path=paste0(wd.CodeFiles, '\\', 'func', '\\'), 
                       pattern = '.R', full.names = T, recurs = F, 
                       include.dirs = F)
#--Load local functions
for (i in prj.func) {
  source(i)
}

#--Load Project Objects
prj.Objects <- Param$Objects
for (i in 1:nrow(prj.Objects)) {
  assign(prj.Objects$Object[[i]],
         paste0(prj.Objects$ObjectVal[[i]]))
}
prj.RunTime <- Sys.time()
