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

1. Run the [release GitHub action]([.github/workflows/release.yml](https://github.com/bonitasoft/bonita-marketplace/actions/workflows/release.yml)).
2. Select the release version by reviewing the [existing releases](https://github.com/bonitasoft/bonita-marketplace/releases) and incrementing as needed.

This will generate a new release with assets (zip file) containing the Bonita Marketplace content.

## Updating the Marketplace in Bonita Studio

Bonita Studio ships with an offline copy of the marketplace, allowing users to install extensions without an internet connection. This copy downloaded for each Bonita Studio build.

To provide users with the latest extensions, periodically update the Studio repository with the newest marketplace release. This requires updating both the marketplace version and its checksum in the properties of the community `pom.xml` —see the [Bonita Studio repository](https://github.com/bonitasoft/bonita-studio/blob/38fce4513e1fddfa1496e75494dbad028722fe24/pom.xml#L23-L24) for details.

Bonita Studio also periodically downloads the latest release assets from this repository to update its list of available extensions.

For implementation details, refer to the code responsible for [retrieving the assets](https://github.com/bonitasoft/bonita-studio/blob/10.2.0/bundles/plugins/org.bonitasoft.studio.application/src/org/bonitasoft/studio/application/ui/control/model/dependency/BonitaMarketplace.java#L149-L165).
