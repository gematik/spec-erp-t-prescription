# Übertragen des digitalen Durchschlags zum T-Rezept

Nach geltenden gesetzlichen Regelungen ist dem BfArM nach Abgabe einer Verordnung von einem teratogenen Wirkstoff ein digitaler Durschlag zu übermitteln. Das BfArM ist in der Pflicht die Verordnung und Abgabe zu prüfen.

Nach Abschluss eines Workflows von einem E-T-Rezept erstellt der E-Rezept-Fachdienst ein Dokument nach [Profil Digitaler Durchschlag T-Rezept](./StructureDefinition-gem-erp-pr-t-carbon-copy.html) und überträgt das an den Webdienst des BfArM.

Hintergründe zum Datenmodell und Designentscheidungen siehe [Informationen zum Datenmodell](./datamodel.html).

## Erstellen des Digitalen Durchschlags

Der E-Rezept-Fachdienst erstellt ein Artefakt mit dem Profil Digitaler Durchschlag T-Rezept. Dabei werden Informationen aus der Verordnung, Dispensierung und dem FHIR-VZD genutzt.
Das Mapping der Quelldaten zu dem Profil werden in der [StructureMap für digitalen Durchschlag](./StructureMap-BfArMStructureMap.html) definiert.