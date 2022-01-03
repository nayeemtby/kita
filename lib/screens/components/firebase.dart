import 'package:firebase_auth/firebase_auth.dart';
import 'my_models.dart';

Future<ExceptionAwareResponse<UserCredential>> signUp(
  String email,
  String password, {
  FirebaseAuth? instance,
}) async {
  instance ??= FirebaseAuth.instance;
  ExceptionAwareResponse<UserCredential> ret =
      ExceptionAwareResponse(response: null);
  try {
    ret.response = await instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    ret.error = e;
  }
  return ret;
}

Future<ExceptionAwareResponse<UserCredential>> login(
  String email,
  String password,
) async {
  final ExceptionAwareResponse<UserCredential> ret = ExceptionAwareResponse(
    response: null,
  );
  try {
    ret.response = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    ret.error = e;
  }
  return ret;
}
