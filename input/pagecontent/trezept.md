# Übertragen des digitalen Durchschlags zum T-Rezept

Nach geltenden gesetzlichen Regelungen ist dem BfArM nach Abgabe einer Verordnung von einem teratogenen Wirkstoff ein digitaler Durschlag zum E-T-Rezept zu übermitteln. Das BfArM ist in der Pflicht die Verordnung und Abgabe zu prüfen.

Nach Abschluss eines Workflows von einem E-T-Rezept erstellt der E-Rezept-Fachdienst ein Dokument nach [Profil Digitaler Durchschlag T-Rezept](./StructureDefinition-erp-tprescription-carbon-copy.html) und überträgt das an den Webdienst des BfArM.

Hintergründe zum Datenmodell und Designentscheidungen siehe [Informationen zum Datenmodell](./datamodel.html).

## Erstellen des Digitalen Durchschlags

Der E-Rezept-Fachdienst erstellt ein Artefakt mit dem Profil Digitaler Durchschlag T-Rezept. Dabei werden Informationen aus der Verordnung, Dispensierung und dem FHIR-VZD genutzt. Die fachlichen Informationen, die hierbei übertragen werden ist in [Logisches Modell digitaler Durchschlag E-T-Rezept](./StructureDefinition-erp-tprescription-carbon-copy-logical.html) abgebildet.

Der E-Rezept-Fachdienst erstellt diesen Datensatz aus Eingangsdaten, die nach Abschluss eines E-Rezept Workflows zur Verfügung stehen.

## Mapping des digitalen Durchschlag E-T-Rezept

Als Hilfestellung zur Implementierung des Mappings von Eingangsdaten in den digitalen Durchschlag sind in diesem Projekt StructureMaps bereitgestellt. Diese können genutzt werden, um automatisiert den digitalen Durchschlag aus Quellinformationen zu erzeugen. Das nötige Vorgehen ist im folgenden Beschrieben.

### Grundlegender Ansatz zum Mapping

Grundlegend werden alle Quellinformationen, die vorhanden sind im digitalen Durchschlag übertragen. Dabei gilt:
- nur Datenfelder, die das Zielprofil erlauben und nicht wegprofiliert wurden, werden gemappt
- KBV Extensions werden in EPA Extensions gemappt

Die jeweiligen Zielprofile in diesem Projekt enthalten eine Tabelle, die aufzeigt welche Daten aus der Quelle übernommen werden und wie diese im Ziel abgebildet werden.

### Vorgehen zur Nutzung der StructureMaps

Die umklammernde Mappingdefinition von Quelldaten zum digitalen Durchschlag werden in der [StructureMap für digitalen Durchschlag](./StructureMap-ERPTPrescriptionStructureMapCarbonCopy.html) definiert. Diese importiert alle im Projekt vorhandenen Mappingdaten. Als Eingangsartefakt benötigt diese Structure Map ein FHIR-Bundle, welches alle notwendigen Eingangsartefakte enthält:

- Verordnungsdatensatz nach [eRezept der KBV](https://simplifier.net/eRezept)
- Vorgangs- und Dispensierinformationen nach [E-Rezept-Workflow der gematik](https://simplifier.net/erezept-workflow)
- Informationen der Apotheke aus dem [FHIR-VZD](https://simplifier.net/VZD-FHIR-Directory)

>!WARNING:  
> Der Signaturzeitpunkt ist in den Mappingartefakten nicht abgebildet, da dieser nicht aus einer FHIR Struktur hervorgeht, sondern aus der QES am Element ´1.2.840.113549.1.9.5 signingTime´ extrahiert werden muss.
> Der E-Rezept-Fachdienst transformiert den Wert aus der QES in den FHIR-Datentyp ´instant´ mit maximal Sekundengenauigkeit (YYYY-MM-DDThh:mm:ss+zz:zz, bsp: 2026-01-01T00:00:00Z).

#### Bundle zum Mapping

Diese zum Mapping erforderlichen Informationen können im Mapping Bundle mit type ´collection´ wie folgt zusammengefasst und erstellt werden:

<div class="gem-ig-svg-container" style="--box-width: 700px;">
        {% include bundle-concept.svg %}
    </div>

Ein Beispiel für solch ein Bundle ist [hier]() abgebildet. //TODO: Beispiel Mapping Bundle erstellen

Im Folgenden wird beschrieben, wie das Mapping mit StructureMaps umgesetzt werden kann.

### Anwendung der StructureMap

Die StructureMap [ERP-TPrescription-StructureMap-CarbonCopy](./StructureMap-ERPPrescriptionStructureMapCarbonCopyhtml kann mithilfe des [Java HAPI-FHIR](https://github.com/hapifhir/org.hl7.fhir.core) auf ein Mapping Bundle angewendet werden.

Das Mapping sieht im Grunde die folgende Übertragung vor:

<div class="gem-ig-svg-container" style="--box-width: 700px;">
        {% include mapping-concept.svg %}
    </div>

Die StructureMap überführt das Mapping Bundle in den digitalen Durchschlag und ruft dabei selbst weitere Structure Maps auf, die die einzelnen unterprofile mappen. Diese können auch Entwicklungsunterstüztend genutzt werden:


| Quellartefakt  | Zielprofil | StructureMap |
| ------------- |:-------------:|:-------------:|
| [KBV_Prescription (MedicationRequest)](https://simplifier.net/erezept/kbv_pr_erp_prescription)| [E-T-Rezept Medication Request](./StructureDefinition-erp-tprescription-medication-request.html) | [StructureMap-MedicationRequest](./StructureMap-ERPTPrescriptionStructureMapMedicationRequest.html)
| [KBV_Medication_PZN](https://simplifier.net/erezept/kbv_pr_erp_medication_pzn) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-KBV-PZN-Medication](./StructureMap-ERPTPrescriptionStructureMapKBVPZNMedication.html)
| [KBV_Medication_Ingredient](https://simplifier.net/erezept/kbv_pr_erp_medication_ingredient) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-KBV-Ingredient-Medication](./StructureMap-ERPTPrescriptionStructureMapKBVIngredientMedication.html)
| [KBV_Medication_Compounding](https://simplifier.net/erezept/kbv_pr_erp_medication_compounding) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-KBV-Compounding-Medication](./StructureMap-ERPTPrescriptionStructureMapKBVCompoundingMedication.html)
| [KBV_Medication_FreeText](https://simplifier.net/erezept/kbv_pr_erp_medication_freetext) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-KBV-FreeText-Medication](./StructureMap-ERPTPrescriptionStructureMapKBVFreeTextMedication.html)
| [GEM_ERP_PR_Medication](https://simplifier.net/erezept-workflow/gem_erp_pr_medication) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-GEM-Medication](./StructureMap-ERPTPrescriptionStructureMapGEMMedication.html)
[GEM_MedicationDispense](https://simplifier.net/erezept-workflow/gem_erp_pr_medicationdispense) | [E-T-Rezept Medication Dispense](./StructureDefinition-erp-tprescription-medication-dispense.html) | [StructureMap-StructureMap-MedicationDispense](./StructureMap-ERPTPrescriptionStructureMapMedicationDispense.html)
[VZD Searchset](./StructureDefinition-erp-tprescription-vzd-searchset.html)      | [E-T-Rezept Organization](./StructureDefinition-erp-tprescription-organization.html) | [StructureMap-StructureMap-Organization](./StructureMap-ERPTPrescriptionStructureMapOrganization.html)

### HAPI FHIR Transformation

Um HAPI FHIR zu nutzen und die Transformation durchzuführen ist die FHIR Version, die verwendeten FHIR Packages, die für das Mapping benötigt werden, sowie der Output-Pfad anzugeben:

```
java -jar <path-to>/fhir_hapi.jar <path-to>/mapping_bundle.json 
-transform https://gematik.de/fhir/erp-t-prescription/StructureMap/ERPTPrescriptionStructureMapCarbonCopy 
-version 4.0.1 
-ig de.gematik.erp.t-prescription#dev
-ig de.gematik.erezept-workflow.r4 
-ig kbv.ita.erp
-ig de.gematik.fhir.directory
-output <path-to>/output.json 
```

Die Mappingengine im FHIR-HAPI transformiert das Bundle in einen digitalen Durchschlag E-T-Rezept. Entsprechende Beispiele hierfür können in den [E2E-Examples E-Rezept]() angesehen werden. //TODO Add Link 

## Übertragen des digitalen Durchschlags

Nachdem der digitale Durchschlag E-T-Rezept erzeugt wurde, wird dieser über das Internet RESTful an den BfArM Webdienst übertragen. Die Übertragung erfolgt asynchron zur Abgabe einer Apotheke ggü. dem E-Rezept-Fachdienst. 

Vorgaben zur Authentifizierung des E-Rezept-Fachdienst ggü. dem Webdienst sind in der [Spezifikation des E-Rezept-Fachdienst](https://gemspec.gematik.de/docs/gemSpec/gemSpec_FD_eRp/latest/) beschrieben.

Die folgende OpenAPI-Definition dient als Hilfestellung bei der Implementierung des Aufrufs am BfArM Webdienst:

{% include openapi.html openapiurl="tprescription.yaml" %}