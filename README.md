# bonita-marketplace

This repository lists the extensions available on the Bonita Marketplace:
- actor-filters
- applications
- connectors
- database-drivers

It specifies which extension versions are compatible with each Bonita version.

## Adding a New Extension or Version

To add a new extension or update the version of an existing one:

1. Update or add files in the related directory in `src/main/resources/artifacts`.
2. Commit and push your changes (prefer the usage of Pull Request).

## Releasing a New Version of Bonita Marketplace

To create a new release:

1. Run the [release GitHub action](.github/workflows/release.yml).
2. Select the release version by reviewing the [existing releases](https://github.com/bonitasoft/bonita-marketplace/releases) and incrementing as needed.

This will generate a new release with assets (zip file) containing the Bonita Marketplace content.

Bonita Studio periodically downloads the latest release assets from this repository to update its list of available extensions.

For more details, see the code responsible for [retrieving the assets](https://github.com/bonitasoft/bonita-studio/blob/10.2.0/bundles/plugins/org.bonitasoft.studio.application/src/org/bonitasoft/studio/application/ui/control/model/dependency/BonitaMarketplace.java#L149-L165).
