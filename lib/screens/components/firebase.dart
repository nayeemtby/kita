import 'package:firebase_auth_rest/firebase_auth_rest.dart';
import 'package:http/http.dart';
import 'api/key.dart';

Future<dynamic> signUp(String email, String password) async {
  Client client = Client();
  final FirebaseAuth fbAuth = FirebaseAuth(client, apiKey);
  dynamic response;
  try {
    response = fbAuth.signUpWithPassword(email, password, autoVerify: false);
  } catch (e) {
    response = e;
    print(e);
  }
  return response;
}

Future<dynamic> login(String email, String password) async {
  Client client = Client();
  final FirebaseAuth fbAuth = FirebaseAuth(client, apiKey);
  dynamic response;
  try {
    response = fbAuth.signInWithPassword(
      email,
      password,
    );
  } catch (e) {
    response = e;
    print(e);
  }
  return response;
}
