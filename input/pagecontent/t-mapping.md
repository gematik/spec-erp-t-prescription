# Mapping des digitalen Durchschlag E-T-Rezept

Der E-Rezept-Fachdienst mappt die Daten von Verordnung, Dispensierung und FHIR-VZD in das Zielprofil. Entwicklungsunterstützend wurden hierfür StructureMaps bereitgestellt. Diese StructureMaps können genutzt werden, um in einer Mapping Engine ein Bundle mit den Quellartefakten in einen digitalen Durchschlag T-Rezept zu transformieren.

Im Folgenden wird beschrieben, wie dies umgesetzt werden kann.

## Bundle zum Mapping

Zunächst muss ein Bundle mit type ´collection´ erzeugt werden, welches alle Quellartefakte enthält:

<div class="gem-ig-svg-container" style="--box-width: 700px;">
        {% include bundle-concept.svg %}
    </div>

Ein Beispiel für ein solches Bundle findet sich hier //TODO: Bundle Beipsiel erstellen

## Signaturzeitpunkt
Der Signaturzeitpunkt ist in den Mappingartefakten nicht abgebildet, da dieser nicht aus einer FHIR Struktur hervorgeht, sondern aus der QES am Element ´1.2.840.113549.1.9.5 signingTime´ extrahiert werden muss.
Der E-Rezept-Fachdienst transformiert den Wert aus der QES in den FHIR-Datentyp ´instant´ mit maximal Sekundengenauigkeit (YYYY-MM-DDThh:mm:ss+zz:zz, bsp: 2026-01-01T00:00:00Z).

## Anwendung der StructureMap

Die StructureMap [ERP-TPrescription-StructureMap-CarbonCopy](./StructureMap-ERP-TPrescription-StructureMap-CarbonCopy.html) kann mithilfe des [Java HAPI-FHIR](https://github.com/hapifhir/org.hl7.fhir.core) transformiert werden.
Anzugeben ist der HAPI FHIR, sowie die FHIR Version, die verwendeten FHIR Packages, die für das Mapping benötigt werden, sowie der Output-Pfad:

```
java -jar <path-to>/fhir_hapi.jar <path-to>/mapping_bundle.json 
-transform https://gematik.de/fhir/erp-t-prescription/StructureMap/ERP-TPrescription-StructureMap-CarbonCopy 
-version 4.0.1 
-ig de.gematik.erp.t-prescription#dev
-ig de.gematik.erezept-workflow.r4 
-ig kbv.ita.erp
-ig de.gematik.fhir.directory
-output <path-to>/output.json 
```

Die Mappingengine im FHIR-HAPI transformiert das Bundle in einen digitalen Durchschlag E-T-Rezept. Entsprechende Beispiele hierfür können in den [E2E-Examples E-Rezept]() angesehen werden. //TODO Add Link 


## Einzelne Mappings

Weiterhin existieren auch separate StructureMaps um einzelne Artefakte zu transformieren:

| Quellartefakt  | Zielprofil | StructureMap |
| ------------- |:-------------:|:-------------:|
| [KBV_Prescription (MedicationRequest)](https://simplifier.net/erezept/kbv_pr_erp_prescription)| [E-T-Rezept Medication Request](./StructureDefinition-erp-tprescription-medication-request.html) | [StructureMap-MedicationRequest](./StructureMap-ERP-TPrescription-StructureMap-MedicationRequest.html)
| [KBV_Medication_PZN](https://simplifier.net/erezept/kbv_pr_erp_medication_pzn) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-KBV-PZN-Medication](./StructureMap-ERP-TPrescription-StructureMap-KBV-PZN-Medication.html)
| [KBV_Medication_Ingredient](https://simplifier.net/erezept/kbv_pr_erp_medication_ingredient) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-KBV-Ingredient-Medication](./StructureMap-ERP-TPrescription-StructureMap-KBV-Ingredient-Medication.html)
| [KBV_Medication_Compounding](https://simplifier.net/erezept/kbv_pr_erp_medication_compounding) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-KBV-Compounding-Medication](./StructureMap-ERP-TPrescription-StructureMap-KBV-Compounding-Medication.html)
| [KBV_Medication_FreeText](https://simplifier.net/erezept/kbv_pr_erp_medication_freetext) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-KBV-FreeText-Medication](./StructureMap-ERP-TPrescription-StructureMap-KBV-FreeText-Medication.html)
| [GEM_ERP_PR_Medication](https://simplifier.net/erezept-workflow/gem_erp_pr_medication) | [E-T-Rezept Medication](./StructureDefinition-erp-tprescription-medication.html)     | [StructureMap-StructureMap-GEM-Medication](./StructureMap-ERP-TPrescription-StructureMap-GEM-Medication.html)
[GEM_MedicationDispense](https://simplifier.net/erezept-workflow/gem_erp_pr_medicationdispense) | [E-T-Rezept Medication Dispense](./StructureDefinition-erp-tprescription-medication-dispense.html) | [StructureMap-StructureMap-MedicationDispense](./StructureMap-ERP-TPrescription-StructureMap-MedicationDispense.html)
[VZD Searchset](./StructureDefinition-erp-tprescription-vzd-searchset.html)      | [E-T-Rezept Organization](./StructureDefinition-erp-tprescription-organization.html) | [StructureMap-StructureMap-Organization](./StructureMap-ERP-TPrescription-StructureMap-Organization.html)