# Informationen zum Datenmodell

Im Laufe der Durchführung eines E-Rezept Workflows erhält der E-Rezept-Fachdienst diverse Artefakte die für die Erstellung des digitalen Durchschlags notwendig sind:

- Die Verordnung des Arztes
- Die Dispensierinformationen der Apotheke

Zusätzlich ruft der E-Rezept-Fachdienst den Verzeichnisdienst der TI auf, um Apothekendaten anzufragen.

## Fachliche Informationseinheiten

Zur Übertragung der fachlichen Informationseinheiten wurde sich auf konkrete Daten geeinigt, diese sind in [gemF_eRp_T-Rezept](https://gemspec.gematik.de/docs/gemF/gemF_eRp_T-Rezept/latest/#5.7.2) aufgelistet.

## Entscheidung zur Abbildung des Datenmodells

Für die Erstellung des Datenmodells gab es verschiedene Lösungsmöglichkeiten den digitalen Durschlag abzubilden. Es wurde evaluiert zwischen:

- proprietäres JSON
- Hybrid zwischen JSON und FHIR Datenmodell
- FHIR Datenmodell

Ein eigen definiertes JSON hätte ggf. Komplexität reduziert, gleichzeitig aber dazu geführt, dass der E-Rezept-Fachdienst z.B. kodierte Daten auflösen, interpretieren und als textuelle Repräsentation hätte darstellen müssen.

Da der E-Rezept-Fachdienst als Workflow-Engine fungiert und keine Interpretation von fachlichen und medizinischen Daten vornimmt wurde sich darauf verständigt, dass der E-Rezept-Fachdienst die FHIR-Ressourcen, die erhalten wurden auch weitergibt und an das BfArM überträgt. Die Interpretation der fachlichen Daten wird dann auf Seiten des BfArM durchgeführt und dem Endanwender in geeigneter Darstellung angezeigt.

## Designentscheidung zur restriktiven Datenmodellierung

Entgegen der Best Practice zur FHIR Modellierung der [HL7 International](https://build.fhir.org/ig/FHIR/ig-guidance/best-practice.html) und [HL7 Deutschland](https://ig.fhir.de/best-practice/1.0.0/Home.html) sind die Profile in diesem Projekt sehr restriktiv designed.

Der Hintergrund sind die gesetzlichen Vorgaben und Abstimmungen zwischen Bundesministerium für Gesundheit (BMG), BfArM und gematik, die konkret definieren, welche Informationen zu übertragen sind. Alle anderen Daten sind verboten zu übertragen und damit auch aus den Profilen via 0..0 Kardinalität gestrichen, s. hierzu [§3a Abs. 7 AMVV](https://www.gesetze-im-internet.de/amvv/__3a.html).