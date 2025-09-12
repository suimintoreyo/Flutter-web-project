import 'package:serverpod/serverpod.dart';
import 'package:bcrypt/bcrypt.dart';

import '../generated/protocol.dart';

class AuthEndpoint extends Endpoint {
  /// Registers a new user with [email] and [password]. Returns a session
  /// token if registration succeeded, otherwise null if the email is already
  /// in use.
  Future<String?> register(
      Session session, String email, String password) async {
    var existing = await User.findSingleRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (existing != null) return null;

    var hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
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

    return session.authenticationKey;
  }

  /// Logs in a user with the provided [email] and [password]. Returns a
  /// session token if authentication is successful, otherwise null.
  Future<String?> login(
      Session session, String email, String password) async {
    var user = await User.findSingleRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (user == null) return null;

    if (!BCrypt.checkpw(password, user.hashedPassword)) return null;

    await session.updateUserId(user.id!);
    return session.authenticationKey;
  }
}
