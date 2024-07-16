import 'package:ai_eats/home_models/bottom_navigator.dart';
import 'package:flutter/material.dart';

class AGBs extends StatelessWidget {
  const AGBs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Condition'),
        titleTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          splashRadius: 30,
          alignment: Alignment.center,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Hintergrund-Icon mit Transparenz
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: Image.asset('assets/icons/logo/Logo_withoutTitle_alpha.png'),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '''
Allgemeine Geschäftsbedingungen (AGB)

1. Geltungsbereich
Diese AGB gelten für die Nutzung der Dienste und Angebote, die von [Ihr Unternehmen] bereitgestellt werden.

2. Registrierung
Um unsere Dienste vollständig nutzen zu können, ist eine Registrierung erforderlich. Sie sind für die Sicherheit Ihrer Zugangsdaten verantwortlich.

3. Datenschutz
Wir legen großen Wert auf den Schutz Ihrer persönlichen Daten. Alle Informationen zur Erhebung, Verarbeitung und Nutzung Ihrer Daten finden Sie in unserer Datenschutzerklärung.

4. Haftung
Wir übernehmen keine Haftung für Schäden, die durch die Nutzung unserer Dienste entstehen, es sei denn, sie beruhen auf Vorsatz oder grober Fahrlässigkeit.

5. Änderungen der AGB
Wir behalten uns das Recht vor, diese AGB jederzeit zu ändern. Nutzer werden über Änderungen informiert.

6. Schlussbestimmungen
Es gilt das Recht der Bundesrepublik Deutschland. Gerichtsstand ist [Ort]. Sollten einzelne Bestimmungen dieser AGB unwirksam sein, bleibt die Wirksamkeit der übrigen Bestimmungen unberührt.
10. Salvatorische Klausel
Sollte eine Bestimmung dieser AGB unwirksam sein, so bleibt der Vertrag im Übrigen wirksam. Die unwirksame Bestimmung gilt als durch eine solche ersetzt, die dem wirtschaftlichen Zweck der unwirksamen Bestimmung am nächsten kommt.

[Dein Unternehmen]
Musterstraße 123
12345 Musterstadt
Kontakt: info@deinunternehmen.com

Stand: [Aktuelles Datum]
            ''',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigator(context),
    );
  }
}
