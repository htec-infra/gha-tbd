# Mandatory parameters 

In order to use this workflow we need to make sure that mandatory parameters are provided:

- PROJECT_NAME(repository name (project name in sonarcloud))
- ORG_NAME(organization name created in sonarcloud)
- SONAR_TOKEN(used for authorization with sonarcloud)
- GITHUB_TOKEN(used by sonarscan plugin)

# Optional parameters

- DOTNET_VERSION(default version is 6.0 [Supported dotnet versions](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-msbuild/))
- JAVA_VERSION(used by sonarscan)
- BUILD_DIR(used as parameter in dotnet build command in order to build the project, by default it will be in root directory of repo)