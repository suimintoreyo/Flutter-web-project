import 'package:serverpod/serverpod.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../generated/protocol.dart';

class AuthEndpoint extends Endpoint {
  /// Registers a new user with [email] and [password]. Returns true if the
  /// registration succeeded, otherwise false if the email is already in use.
  Future<bool> register(Session session, String email, String password) async {
    var existing = await User.findSingleRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (existing != null) return false;

    var hashedPassword = sha256.convert(utf8.encode(password)).toString();
    var user = User(
      email: email,
      hashedPassword: hashedPassword,
      createdAt: DateTime.now(),
    );
    await User.insert(session, user);

    // Automatically sign in the newly registered user.
    if (user.id != null) {
      await session.updateUserId(user.id!);
    }

    return true;
  }

  /// Logs in a user with the provided [email] and [password]. Returns true if
  /// authentication is successful.
  Future<bool> login(Session session, String email, String password) async {
    var user = await User.findSingleRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (user == null) return false;

    var hashedPassword = sha256.convert(utf8.encode(password)).toString();
    if (user.hashedPassword != hashedPassword) return false;

    await session.updateUserId(user.id!);
    return true;
  }
}
