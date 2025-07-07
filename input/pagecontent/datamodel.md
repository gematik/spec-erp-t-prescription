# Informationen zum Datenmodell

Im Laufe der Durchführung eines E-Rezept Workflows erhält der E-Rezept-Fachdienst diverse Artefakte die für die Erstellung des digitalen Durchschlags notwendig sind:

- [Die Verordnung des Arztes](https://simplifier.net/erezept/kbv_pr_erp_bundle)
- [Die Dispensierinformationen der Apotheke](https://simplifier.net/erezept-workflow/gem_erp_pr_par_closeoperation_input)

In den Dispensierinformationen ist die Telematik-ID der Apotheke angegeben. Da der digitale Durchschlag die Adress-, Telefon- und Namensinformationen der Apotheke aufführen muss ruft der E-Rezept-Fachdienst zusätzlich den [Verzeichnisdienst der TI](https://simplifier.net/VZD-FHIR-Directory/~introduction) auf, um die benötigten Informationen der abgebenden Apotheke abzufragen.
Aus diesen Informationen wird der digitale Durchschlag E-T-Rezept erstellt.

## Fachliche Informationseinheiten

Zur Übertragung der fachlichen Informationseinheiten wurde sich auf konkrete Daten geeinigt, diese sind in [gemF_eRp_T-Rezept](https://gemspec.gematik.de/docs/gemF/gemF_eRp_T-Rezept/latest/#5.7.2) aufgelistet und im Logical Model [ERP_TPrescription_CarbonCopy_Logical](./StructureDefinition-erp-tprescription-carbon-copy-logical.html) abgebildet.

## Quell- und Zielartefakte

Folgende Profile und Artefakte sind grundlegend für die Erstellung des digitalen Durchschlags T-Rezept und werden in entsprechende Zielprofile gemappt.

Die Zielartefakte enthalten jeweils Beschreibungen und Definitionen zur Bedeutung der Felder.
Konkrete Informationen und Vorgaben und Hinweise zum Mapping werden in [Mapping des digitalen Durchschlag E-T-Rezept](./trezept.html#mapping-des-digitalen-durchschlag-e-t-rezept) beschrieben.

Eine Übersicht der Quell- und Zielartefakte inklusive anzuwendender StructureMap finden sich unter [Einzelne Mappings](./trezept.html#einzelne-mappings).

## Designentscheidung zur restriktiven Datenmodellierung

Entgegen der Best Practice zur FHIR Modellierung der [HL7 International](https://build.fhir.org/ig/FHIR/ig-guidance/best-practice.html) und [HL7 Deutschland](https://ig.fhir.de/best-practice/1.0.0/Home.html) sind die Profile in diesem Projekt sehr restriktiv designed.

Der Hintergrund sind die gesetzlichen Vorgaben und Abstimmungen zwischen Bundesministerium für Gesundheit (BMG), BfArM und gematik, die konkret definieren, welche Informationen zu übertragen sind. Alle anderen Daten sind verboten zu übertragen und damit auch aus den Profilen via 0..0 Kardinalität gestrichen, s. hierzu [§3a Abs. 7 AMVV](https://www.gesetze-im-internet.de/amvv/__3a.html).