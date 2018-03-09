
# iOS pre build script executed by AppCenter as a pre-build step.
# Here we select and replace the Info.plist and GoogleService-Info.plist
# files depending on the desired Server configuration.
# set the correct managed configuration ( server URL )
sed -i.bak "s/ProductionConfiguration/${environment}Configuration/" ../IM.Core/App/ManagedConfiguration.cs

# Configure file names for enviroment
case $environment in
    "Preview" )
       newBundleIdentifier="com.bump.bumpapppre"
       newGTMFile="GTM-TXJZVV2.json"
    ;;
    "Development")
        newBundleIdentifier="com.bump.bumpappdev"
        newGTMFile="GTM-T9QB7JP.json"
    ;;
    "Staging" )
        newBundleIdentifier="com.bump.bumpappstg"
        newGTMFile="GTM-5H2L64G.json"
    ;;
    "Production" )
        newBundleIdentifier="com.bump.bumpapppro"
        newGTMFile="GTM-W4G56ND.json"
    ;;
esac

plutil -replace CFBundleIdentifier -string $newBundleIdentifier Info.plist

#set correct google service plist
cat "./Configurations/GoogleAnalytics/GoogleService-Info.${environment}.plist" > GoogleService-Info.plist
# set GTM files and update csproj file.
cp "./Configurations/GoogleAnalytics/GTM/${environment}/${newGTMFile}" "./Resources/container/${newGTMFile}"
sed -i.bak "s/GTM.*json/${newGTMFile}/" IM.Ios.csproj


#replace all Icons 
find ./Resources/Images.xcassets/AppIcons.appiconset/*.png -exec rm -rf {}\;
cp -r "./Configurations/Icons/${environment}/" ./Resources/Images.xcassets/AppIcons.appiconset/

#update iTunesArtwork files in the root folder from the enviroment folders and rename them correctly.
cp "./Configurations/Icons/${environment}/iTunesArtwork@1x.png" "iTunesArtwork"
cp "./Configurations/Icons/${environment}/iTunesArtwork@2x.png" "iTunesArtwork@2x"
