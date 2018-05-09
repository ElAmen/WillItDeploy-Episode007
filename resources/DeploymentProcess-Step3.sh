# Copy files to host directory
webappInstallPath=$(get_octopusvariable "Octopus.Action.Package.InstallationDirectoryPath")

sudo cp -rf $webappInstallPath/. /var/aspnetcore/randomquotes/

# Restart the Service
sudo systemctl restart kestrel-randomquotes.service
