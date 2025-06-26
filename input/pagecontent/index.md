# Implementation Guide für den Datenaustausch zwischen Gematik und BfArM

Dieser Implementation Guide beschreibt Profile und deren Verwendung in Anwendungsfällen zum Datenaustausch zwischen der gematik und dem Bundesinstitut für Arzneimittel und Medizinprodukte (BfArM).

In diesem IG wird der Anwendungsfall "[Übertragung digitaler Durchschlag zum T-Rezept](./trezept.html)", sowie die dazugehörigen Profile und Mappingdaten beschrieben.

## Wie dieser IG zu lesen ist

Die Übersichtsseite des Anwendungsfalls (s.o.) beschreibt die fachlichen Anforderungen und gibt eine allgemeine Beschreibung dessen, was erreicht werden soll. Die Profilseiten enthalten jeweils eine Beschreibung der Profile und deren Verwendung.

Dieser IG stellt ebenfalls Mappingdaten zur Verfügung, die entwicklungsunterstützend genutzt werden können, um digitale Durchschläge für das T-Rezept zu erstellen. Weiterführende Beschreibung hierzu findet sich unter [Mapping für den digitalen Durchschlag](./t-mapping.html).

Bezüglich des Datenmodells ist der [digitiale Durchschlag T-Rezept](./StructureDefinition-erp-tprescription-carbon-copy.html) die übergreifende Ressource, die alle relevanten Profile referenziert. Dieses Artefakt wird vom E-Rezept-Fachdienst an das BfArM T-Register übertragen. Weitere Informationen hierzu sind unter [Datenmodell digitaler Durchschlag E-T-Rezept](./datamodel.html) zu finden.

Die API des BfArM Webdienstes wird in der API Dokumentation des E-Rezeptes beschreiben. Der IG beschreibt Hintergründe und Entscheidungen zum Datenmodell.

## Weitere Referenzen und Dokumente

- [Feature Dokument zum T-Rezept der gematik](https://gemspec.gematik.de/docs/gemF/gemF_eRp_T-Rezept/latest/)
- [Spezifikation des E-Rezept-Fachdienst](https://gemspec.gematik.de/docs/gemSpec/gemSpec_FD_eRp/latest/)

