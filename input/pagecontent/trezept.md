# Übertragen des digitalen Durchschlags zum T-Rezept

Nach geltenden gesetzlichen Regelungen ist dem BfArM nach Abgabe einer Verordnung von einem teratogenen Wirkstoff ein digitaler Durschlag zum E-T-Rezept zu übermitteln. Das BfArM ist in der Pflicht die Verordnung und Abgabe zu prüfen.

Nach Abschluss eines Workflows von einem E-T-Rezept erstellt der E-Rezept-Fachdienst ein Dokument nach [Profil Digitaler Durchschlag T-Rezept](./StructureDefinition-erp-tprescription-carbon-copy.html) und überträgt das an den Webdienst des BfArM.

Hintergründe zum Datenmodell und Designentscheidungen siehe [Informationen zum Datenmodell](./datamodel.html).

## Erstellen des Digitalen Durchschlags

Der E-Rezept-Fachdienst erstellt ein Artefakt mit dem Profil Digitaler Durchschlag T-Rezept. Dabei werden Informationen aus der Verordnung, Dispensierung und dem FHIR-VZD genutzt.
Das Mapping der Quelldaten zu dem Profil werden in der [StructureMap für digitalen Durchschlag](./StructureMap-ERPPrescriptionStructureMapCarbonCopyhtml definiert.

## Mapping des digitalen Durchschlag E-T-Rezept

Der E-Rezept-Fachdienst mappt die Daten von Verordnung, Dispensierung und FHIR-VZD in das Zielprofil. Entwicklungsunterstützend wurden hierfür StructureMaps bereitgestellt. Diese StructureMaps können genutzt werden, um in einer Mapping Engine ein Bundle mit den Quellartefakten in einen digitalen Durchschlag T-Rezept zu transformieren.

Im Folgenden wird beschrieben, wie dies umgesetzt werden kann.

### Bundle zum Mapping

Zunächst muss ein Bundle mit type ´collection´ erzeugt werden, welches alle Quellartefakte enthält:

<div class="gem-ig-svg-container" style="--box-width: 700px;">
        {% include bundle-concept.svg %}
    </div>

Ein Beispiel für ein solches Bundle findet sich hier //TODO: Bundle Beipsiel erstellen

### Signaturzeitpunkt
Der Signaturzeitpunkt ist in den Mappingartefakten nicht abgebildet, da dieser nicht aus einer FHIR Struktur hervorgeht, sondern aus der QES am Element ´1.2.840.113549.1.9.5 signingTime´ extrahiert werden muss.
Der E-Rezept-Fachdienst transformiert den Wert aus der QES in den FHIR-Datentyp ´instant´ mit maximal Sekundengenauigkeit (YYYY-MM-DDThh:mm:ss+zz:zz, bsp: 2026-01-01T00:00:00Z).

### Anwendung der StructureMap

Die StructureMap [ERP-TPrescription-StructureMap-CarbonCopy](./StructureMap-ERPPrescriptionStructureMapCarbonCopyhtml kann mithilfe des [Java HAPI-FHIR](https://github.com/hapifhir/org.hl7.fhir.core) transformiert werden.
Anzugeben ist der HAPI FHIR, sowie die FHIR Version, die verwendeten FHIR Packages, die für das Mapping benötigt werden, sowie der Output-Pfad:

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


### Einzelne Mappings

Weiterhin existieren auch separate StructureMaps um einzelne Artefakte zu transformieren:

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