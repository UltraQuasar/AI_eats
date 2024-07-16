// auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ai_eats/authentication/model/auth_model.dart';

class AuthController {
  final AuthModel _authModel = AuthModel();

  Future<void> signIn(BuildContext context, String email, String password) async {
    User? user = await _authModel.signInWithEmailAndPassword(email, password);
    if (user != null) {
      // Auth erfolgreich, fahre mit der App fort
      // Hier könntest du zum nächsten Bildschirm navigieren oder andere Aktionen durchführen.
    } else {
      // Auth fehlgeschlagen, zeige eine Fehlermeldung
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Anmeldung fehlgeschlagen"),
        ),
      );
    }
  }

  Future<void> signUp(BuildContext context, String email, String password) async {
    User? user = await _authModel.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      // Registrierung erfolgreich, fahre mit der App fort
      // Hier könntest du zum nächsten Bildschirm navigieren oder andere Aktionen durchführen.
    } else {
      // Registrierung fehlgeschlagen, zeige eine Fehlermeldung
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registrierung fehlgeschlagen"),
        ),
      );
    }
  }
}
