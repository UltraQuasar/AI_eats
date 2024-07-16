import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late var userId;

  Future<void> initializeFirebase() async {
    try {
      // Initialisiere Firebase
      await Firebase.initializeApp();

      //print('Firebase wurde erfolgreich initialisiert!');
    } catch (e) {
      //Logger('Fehler bei der Initialisierung von Firebase: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  //Methode zum Abrufen des Users
  Future<User?> getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;
      return user;
    } catch (e) {
      print("Error getting current user: $e");
      return null;
    }
  }

  //Methode um userId abzurufen
  void getCurrentUserId() {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;
        print('Benutzer-ID: $userId');
      } else {
        print('Kein authentifizierter Benutzer gefunden.');
      }
    } catch (e) {
      print('Fehler beim Abrufen der Benutzer-ID: $e');
    }
  }

  // Methode zum Aktualisieren der E-Mail-Adresse
  Future<void> updateEmail(String newEmail) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        // Aktualisiere den lokalen Benutzer, wenn die Aktualisierung auf dem Server erfolgreich war
        user = _auth.currentUser;
        print("E-Mail-Adresse erfolgreich aktualisiert: ${user?.email}");
      }
    } catch (e) {
      print("Fehler beim Aktualisieren der E-Mail-Adresse: $e");
    }
  }

  // Methode zum Aktualisieren des Passworts
  Future<void> updatePassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        print("Passwort erfolgreich aktualisiert");
      }
    } catch (e) {
      print("Fehler beim Aktualisieren des Passworts: $e");
    }
  }

  // Methode zum Aktualisieren des Benutzernamens
  Future<void> updateDisplayName(String newDisplayName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(newDisplayName);
        // Aktualisiere den lokalen Benutzer, wenn die Aktualisierung auf dem Server erfolgreich war
        user = _auth.currentUser;
        print("Benutzername erfolgreich aktualisiert: ${user?.displayName}");
      }
    } catch (e) {
      print("Fehler beim Aktualisieren des Benutzernamens: $e");
    }
  }

  // Methode zum Löschen des Benutzerkontos
  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        print("Benutzerkonto erfolgreich gelöscht");
      }
    } catch (e) {
      print("Fehler beim Löschen des Benutzerkontos: $e");
    }
  }

  // Methode zum Zurücksetzen des Passworts
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Link zum Zurücksetzen des Passworts wurde an $email gesendet");
    } catch (e) {
      print("Fehler beim Senden des Passwort-Zurücksetzungslinks: $e");
    }
  }

  // Methode zum erneuten Anmelden des Benutzers
  Future<void> reauthenticateUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(
          "Benutzer erfolgreich erneut angemeldet: ${userCredential.user?.email}");
    } catch (e) {
      print("Fehler beim erneuten Anmelden des Benutzers: $e");
    }
  }

  //Methode zum Erstellen eines Rezeptes
  Future<void> addRecipe(String userId, Map<String, dynamic> recipeData) async {
    try {
      // Referenz auf die "recipes"-Sammlung im Benutzerdokument
      CollectionReference recipesCollection =
          FirebaseFirestore.instance.collection('users/$userId/recipes');

      // Rezeptdokument hinzufügen
      await recipesCollection.add(recipeData);
      print('Rezept erfolgreich hinzugefügt!');
    } catch (e) {
      print('Fehler beim Hinzufügen des Rezepts: $e');
    }
  }

  //Mehtode zum Updaten von Userdaten
  Future<void> updateUserData(
      int age, String email, String name, String surname) async {
    try {
      // Erstellen Sie eine Referenz auf das Benutzerdokument
      DocumentReference userDocument =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Aktualisieren Sie die Benutzerdaten
      await userDocument.update({
        'age': age,
        'email': email,
        'name': name,
        'surname': surname,
      });

      print('Benutzerdaten erfolgreich aktualisiert!');
    } catch (e) {
      print('Fehler beim Aktualisieren der Benutzerdaten: $e');
    }
  }

  //Methode zum Holen der Userdaten
  Future<Map<String, dynamic>> getUserData() async {
    try {
      // Erstellen Sie eine Referenz auf das Benutzerdokument
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Überprüfen Sie, ob das Dokument existiert
      if (userSnapshot.exists) {
        // Rufen Sie die Benutzerdaten ab
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        return userData;
      } else {
        print('Benutzerdokument existiert nicht.');
        return {};
      }
    } catch (e) {
      print('Fehler beim Abrufen der Benutzerdaten: $e');
      return {};
    }
  }
}
