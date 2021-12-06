# Logos Desktop Citation Styles Readme

## Updating this repo

See the guidelines for updating third party repositories: https://wiki.lrscorp.net/Third_Party_Git_Repositories

## Embedding styles in Logos Desktop

The CSL files are converted to JSON then embedded as resources in the `Libronix.DigitalLibrary.dll` assembly.

The files are converted with the makeJSON.py which is found under the scripts folder. The original version of the `makeJSON.py` file included in the [citeproc-js source](https://bitbucket.org/fbennett/citeproc-js/src/f53167766c75e879f77f5190a57f3c33959b54eb/tools/makejson.py?at=default)

There is an example shell script, `convertJSON.sh`, which can be used to perform the conversion under the scripts folder as well.

The files are converted from CSL to JSON and then copied into the `Libronix.DigitalLibrary/CitationStyles` folder. 

Usage:
```
cd citation-styles/scripts
sh convertJSON.sh "<path_to_Libronix.DigitalLibrary/CitationStyles>"
```

## Localization

The locale files for the supported langaugages are obtained from [https://github.com/citation-style-language/locales](https://github.com/citation-style-language/locales). When they need to be updated, they should be copied into the `Libronix.DigitalLibrary/Citations/Locales` folder. New locale files should be added to the `Libronix.DigitalLibrary.csproj` file as EmbeddedResources.

## CSL terminology, resources, and tips

In a CSL file, the `<citation>` tag defines the footnote citation, and the `<bibliography>` defines the bibliographic citation.

Some styles have two different ways footnotes can be used, "fullnote" and "shortnote"/"author-date". The fullnote version contains much of the same information a bibliographic citation would, whereas the shortnote version will generally contain very little information (often times just the author and date, hence why it is also called author-date).

### Helpful resources

- [CSL Spec](https://docs.citationstyles.org/en/stable/specification.html#appendix-iii-types)
- [CslCitationFormatUtility](https://git.faithlife.dev/Logos/Utility/blob/master/src/Libronix.Utility/Citations/CslCitationFormatUtility.cs) - This is the utility that maps Logos resource fields to CSL fields
