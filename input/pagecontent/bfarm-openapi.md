# E-T-Rezept OpenAPI

Mit diesem Anwendungsfall stellt der E-Rezept-Fachdienst nach Abgabe eines Arzneimittels aufgrund eines E-T-Rezepts an einen Versicherten den digitalen Durchschlag E-T-Rezept für das BfArM bereit.

Die Übertragung erfolgt asynchron zur Abgabe einer Apotheke ggü. dem E-Rezept-Fachdienst. Dieser Erzeugt den digitalen Durchschlag und überträgt diesen über das Internet an einen Endpunkt, der vom BfArM bereitgestellt wird. Vorgaben zur Authentifizierung des E-Rezept-Fachdienst ggü. dem Webdienst sind in der [Spezifikation des E-Rezept-Fachdienst](https://gemspec.gematik.de/docs/gemSpec/gemSpec_FD_eRp/latest/) beschrieben.

Die bereitgestellte OpenAPI-Definition dient ausschließlich als Hilfestellung bei der Implementierung. 

{% include openapi.html openapiurl="tprescription.yaml" %}