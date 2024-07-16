import 'package:firebase_core/firebase_core.dart';

//import 'firebase_options.dart';

// ...

Future<void> initializeFirebase() async {
  try {
// Initialisiere Firebase
    await Firebase.initializeApp();

    //print('Firebase wurde erfolgreich initialisiert!');

  } catch (e) {

    //Logger('Fehler bei der Initialisierung von Firebase: $e');

  }
}

