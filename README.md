### Hi there 👋
I am a learner and .net DEV

##SSRS-zip.yml
  This is yml file in devops but inline powershell can be used.
  Motive is to Get Delta(Committed RDL files in SSRS project folder if we have multiple folders inside that)
  Copy rdl's to temp folder and zip
  Publish zip to artifactory (Build pipeline)
  
##DeployToAzure.ps1
  For this powershell add extract step before and copy rdl's to folder in release pipeline (see Extract.yml).
  Set variables as required
  Powershell is responsible to create folder in ssrs report server and copy rdls to respective folder as they are created in same path
  
I know this has lot of limitations and open for more improvements.
