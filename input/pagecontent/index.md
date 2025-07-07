# Implementation Guide: Übertragung digitaler Durchschlag T-Rezept

Dieser Implementation Guide beschreibt Profile und deren Verwendung in Anwendungsfällen zum Datenaustausch zwischen der gematik und dem Bundesinstitut für Arzneimittel und Medizinprodukte (BfArM) im Kontext E-T-Rezept.

In diesem IG wird der Anwendungsfall "[Übertragung digitaler Durchschlag T-Rezept](./trezept.html)", sowie die dazugehörigen Profile und Mappingdaten beschrieben.

## Wie dieser IG zu lesen ist

Die Übersichtsseite des Anwendungsfalls (s.o.) beschreibt die fachlichen Anforderungen und gibt eine allgemeine Beschreibung dessen, was erreicht werden soll. Die Profilseiten enthalten jeweils eine Beschreibung der Profile und deren Verwendung.

Dieser IG stellt ebenfalls Mappingdaten zur Verfügung, die entwicklungsunterstützend genutzt werden können, um digitale Durchschläge für das T-Rezept zu erstellen. Weiterführende Beschreibung hierzu findet sich unter [Mapping für den digitalen Durchschlag](./trezept.html#mapping-des-digitalen-durchschlag-e-t-rezept).

Bezüglich des Datenmodells ist der [digitiale Durchschlag T-Rezept](./StructureDefinition-erp-tprescription-carbon-copy.html) die übergreifende Ressource, die alle relevanten Profile referenziert. Dieses Artefakt wird vom E-Rezept-Fachdienst an das BfArM T-Register übertragen. Weitere Informationen hierzu sind unter [Datenmodell digitaler Durchschlag E-T-Rezept](./datamodel.html) zu finden.

Auf der Seite [E-T-Rezept OpenAPI](./bfarm-openapi.html) ist die Open API Dokumentation des Endpunktes des BfArM T-Registers zu finden.

## Weitere Referenzen und Dokumente

- [Feature Dokument zum T-Rezept der gematik](https://gemspec.gematik.de/docs/gemF/gemF_eRp_T-Rezept/latest/)
- [Spezifikation des E-Rezept-Fachdienst](https://gemspec.gematik.de/docs/gemSpec/gemSpec_FD_eRp/latest/)

## Kontakt und Feedback

Für Fragen und Feedback wenden Sie sich bitte an [erp-umsetzung@gematik.de](mailto:erp-umsetzung@gematik.de) oder nutzen Sie das [GitHub-Repository](https://github.com/gematik/spec-erp-t-prescription/issues).

## Rechtliche Hinweise

Dieser Implementation Guide wird von der [gematik GmbH](https://www.gematik.de/) erstellt und verwaltet.

Copyright ©2025+ gematik GmbH

HL7®, HEALTH LEVEL SEVEN®, FHIR® und das FHIR®-Logo sind Marken von Health Level Seven International, eingetragen beim United States Patent and Trademark Office.
