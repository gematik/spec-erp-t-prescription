# Übertragen des digitalen Durchschlags zum T-Rezept

Nach geltenden gesetzlichen Regelungen ist dem BfArM nach Abgabe einer Verordnung eines teratogenen Wirkstoffs (z.B. Lenalidomid, Pomalidomid, Thalidomid) ein digitaler Durchschlag des E-T-Rezepts zu übermitteln.

Nach Abschluss eines Workflows von einem E-T-Rezept erstellt der E-Rezept-Fachdienst ein Dokument nach [Profil Digitaler Durchschlag T-Rezept](./StructureDefinition-erp-tprescription-carbon-copy.html) und überträgt dieses an den Webdienst des BfArM. Die Übermittlung erfolgt asynchron und unabhängig vom Abschluss des Apothekenvorgangs, sodass auch bei temporärer Nicht-Erreichbarkeit des BfArM eine zuverlässige Übertragung durch Backoff-Retry-Mechanismen gewährleistet ist.

Hintergründe zum Datenmodell und zu den Designentscheidungen finden sich unter [Informationen zum Datenmodell](./datamodel.html).

## Erstellen des Digitalen Durchschlags

Der E-Rezept-Fachdienst erstellt ein Artefakt mit dem Profil „Digitaler Durchschlag T-Rezept“. Dabei werden Informationen aus der Verordnung, der Dispensierung (Abgabe) und dem FHIR-VZD (Verzeichnisdienst) genutzt. Die fachlichen Inhalte, die hierbei übertragen werden, sind im [Logisches Modell digitaler Durchschlag E-T-Rezept](./StructureDefinition-erp-tprescription-carbon-copy-logical.html) abgebildet.

Der E-Rezept-Fachdienst erzeugt diesen Datensatz aus den Eingangsdaten, die nach Abschluss eines E-Rezept-Workflows zur Verfügung stehen. Der relevante Workflow-Typ ist der Flowtype 166 („Flowtype für Arzneimittel nach § 3a AMVV“), der speziell für diesen Anwendungsfall eingeführt wurde.

## Mapping des digitalen Durchschlags E-T-Rezept

Zur Unterstützung der Implementierung stehen in diesem Projekt StructureMaps bereit, mit denen das Mapping der Eingangsdaten automatisiert erfolgen kann. Die Vorgehensweise ist wie folgt:

### Grundlegender Mapping-Ansatz

- Es werden alle vorhandenen Quellinformationen in den digitalen Durchschlag übernommen, sofern sie im Zielprofil erlaubt und nicht wegprofiliert sind.
- KBV-Extensions werden in EPA-Extensions gemappt.
- Die jeweiligen Zielprofile enthalten Mapping-Tabellen, die aufzeigen, welche Daten aus der Quelle übernommen und wie sie im Ziel abgebildet werden.

### Vorgehen zur Nutzung der StructureMaps

Die zentrale Mappingdefinition von Quelldaten zum digitalen Durchschlag ist in der [StructureMap für digitalen Durchschlag](./StructureMap-ERPTPrescriptionStructureMapCarbonCopy.html) beschrieben. Diese importiert alle projektrelevanten Mappingdaten. Als Eingangsartefakt wird ein FHIR-Bundle benötigt, das folgende Elemente enthält:

- Medikationsanfrage und Arzneimittel der Verordnung nach [eRezept der KBV](https://simplifier.net/eRezept)
- Vorgangs- und Dispensierinformationen nach [E-Rezept-Workflow der gematik](https://simplifier.net/erezept-workflow)
- Informationen der Apotheke aus dem [FHIR-VZD](https://simplifier.net/VZD-FHIR-Directory)

>!warning
> Der Signaturzeitpunkt ist in den Mappingartefakten nicht enthalten, da dieser nicht aus einer FHIR-Struktur hervorgeht, sondern aus der QES am Element `1.2.840.113549.1.9.5 signingTime` extrahiert werden muss. Der E-Rezept-Fachdienst transformiert diesen Wert in den FHIR-Datentyp `instant` mit maximaler Sekundengenauigkeit (Format: YYYY-MM-DDThh:mm:ss+zz:zz, z.B. 2026-01-01T00:00:00Z).

#### Bundle zum Mapping

Die für das Mapping erforderlichen Informationen können im Mapping-Bundle mit `type: collection` wie folgt zusammengefasst und erstellt werden:

<div class="gem-ig-svg-container" style="--box-width: 700px;">
    {% include bundle-concept.svg %}
</div>

Im Folgenden wird beschrieben, wie das Mapping mit StructureMaps umgesetzt werden kann.

### Anwendung der StructureMap

Die StructureMap [ERP-TPrescription-StructureMap-CarbonCopy](./StructureMap-ERPTPrescriptionStructureMapCarbonCopy.html) kann mittels [Java HAPI-FHIR](https://github.com/hapifhir/org.hl7.fhir.core) auf ein Mapping-Bundle angewendet werden.

Das Mapping sieht im Wesentlichen die folgende Übertragung vor:

<div class="gem-ig-svg-container" style="--box-width: 700px;">
    {% include mapping-concept.svg %}
</div>

Die StructureMap überführt das Mapping-Bundle in den digitalen Durchschlag und ruft dabei selbst weitere StructureMaps auf, die die jeweiligen Unterprofile mappen. Diese können auch entwicklungsunterstützend genutzt werden:

| Quellartefakt  | Zielprofil | StructureMap |
| ------------- |:-------------:|:-------------:|
| [KBV_Prescription (MedicationRequest)](https://simplifier.net/erezept/kbv_pr_erp_prescription)| [E-T-Rezept Medication Request](./StructureDefinition-erp-tprescription-medication-request.html) | [StructureMap-MedicationRequest](./StructureMap-ERPTPrescriptionStructureMapMedicationRequest.html) |
| [KBV_Medication_PZN](https://simplifier.net/erezept/kbv_pr_erp_medication_pzn) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html) | [StructureMap-StructureMap-KBV-PZN-Medication](./StructureMap-ERPTPrescriptionStructureMapKBVPZNMedication.html) |
| [KBV_Medication_Ingredient](https://simplifier.net/erezept/kbv_pr_erp_medication_ingredient) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html) | [StructureMap-StructureMap-KBV-Ingredient-Medication](./StructureMap-ERPTPrescriptionStructureMapKBVIngredientMedication.html) |
| [KBV_Medication_Compounding](https://simplifier.net/erezept/kbv_pr_erp_medication_compounding) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html) | [StructureMap-StructureMap-KBV-Compounding-Medication](./StructureMap-ERPTPrescriptionStructureMapKBVCompoundingMedication.html) |
| [KBV_Medication_FreeText](https://simplifier.net/erezept/kbv_pr_erp_medication_freetext) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html) | [StructureMap-StructureMap-KBV-FreeText-Medication](./StructureMap-ERPTPrescriptionStructureMapKBVFreeTextMedication.html) |
| [GEM_ERP_PR_Medication](https://simplifier.net/erezept-workflow/gem_erp_pr_medication) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html) | [StructureMap-StructureMap-GEM-Medication](./StructureMap-ERPTPrescriptionStructureMapGEMMedication.html) |
| [GEM_MedicationDispense](https://simplifier.net/erezept-workflow/gem_erp_pr_medicationdispense) | [E-T-Rezept Medication Dispense](./StructureDefinition-erp-tprescription-medication-dispense.html) | [StructureMap-StructureMap-MedicationDispense](./StructureMap-ERPTPrescriptionStructureMapMedicationDispense.html) |
| [VZD Searchset](./StructureDefinition-erp-tprescription-vzd-searchset.html) | [E-T-Rezept Organization](./StructureDefinition-erp-tprescription-organization.html) | [StructureMap-StructureMap-Organization](./StructureMap-ERPTPrescriptionStructureMapOrganization.html) |

### HAPI FHIR Transformation

Um HAPI FHIR zur Transformation zu nutzen, müssen FHIR-Version, die verwendeten FHIR-Packages für das Mapping sowie der Output-Pfad angegeben werden:
```
java -jar <path-to>/fhir_hapi.jar <path-to>/mapping_bundle.json \
-transform https://gematik.de/fhir/erp-t-prescription/StructureMap/ERPTPrescriptionStructureMapCarbonCopy \
-version 4.0.1 \
-ig de.gematik.erp.t-prescription#dev \
-ig de.gematik.erezept-workflow.r4 \
-ig kbv.ita.erp \
-ig de.gematik.fhir.directory \
-ig de.gematik.ti \
-output <path-to>/output.json
```

Die Mapping-Engine im FHIR-HAPI transformiert das Bundle in einen digitalen Durchschlag E-T-Rezept.

Die folgenden Beispiele können als Referenz herangezogen werden:

| Beispiel  | Beschreibung |
| ------------- |:-------------:|
|[Bundle-Mapping-Bundle](./Bundle-Mapping-Bundle.html)|Beispiel eines Mapping-Bundles zur Erzeugung eines digitalen Durchschlags E-T-Rezept|
|[TRP-Carbon-Copy](./Parameters-TRP-Carbon-Copy.html)|Manuell erzeugter digitaler Durchschlag E-T-Rezept|
|[Mapped CarbonCopy](./Bundle-erp-t-prescription-carbon-copy-actual.json)|Von der HAPI Transformation Engine erzeugtes JSON|

## Übertragen des digitalen Durchschlags

Nachdem der digitale Durchschlag E-T-Rezept erzeugt wurde, wird dieser RESTful über das Internet an den BfArM Webdienst übertragen. Die Übertragung erfolgt asynchron zur Abgabe in der Apotheke gegenüber dem E-Rezept-Fachdienst.

Vorgaben zur Authentifizierung des E-Rezept-Fachdienstes gegenüber dem Webdienst sind in der [Spezifikation des E-Rezept-Fachdienst](https://gemspec.gematik.de/docs/gemSpec/gemSpec_FD_eRp/latest/) beschrieben.

Die folgende OpenAPI-Definition dient als Hilfestellung bei der Implementierung des Aufrufs am BfArM Webdienst:

{% include openapi.html openapiurl="tprescription.yaml" %}
