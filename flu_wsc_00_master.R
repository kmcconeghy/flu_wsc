#
# Title: Master File
# Purpose: First Project Folder, will build primary cohort and ancillary files
# Programmer: Kevin W. McConeghy
# Date Created: 2018.11.21
#

#--Clear
rm(list = ls())
#dev.off()
#devAskNewPage(FALSE)
#options(device.ask.default = F)
#grDevices::devAskNewPage(ask=FALSE)

#--Project Set-up
##Load Config File
ConfigPath <- list.files(pattern='*cfg*')
source(ConfigPath)

#--IF ONLY WANT ONE FILE TO RUN
#-- Ex. RenderOne('A01', wd.CodeFiles, wd.ReportFiles)
RenderOne('C05', DirPath, paste0(ReportFilesPath))

#--Run project
#--Execute SAS Batch File
#shell(paste0(prj.Objects[,2][[1]][grepl("SASBatch", prj.Objects[[1,]])]))

#--Execute R files
load_prj(wd, 
             INSHEET=T, MUNGE=T, REPORT=T, 
             SrcPath=wd,
             ReportPath=ReportFilesPath) #--Run automatic code for project  

cat(paste0('Project Run: ', prj.RunTime %--% Sys.time()))

#End project