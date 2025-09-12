import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_project_client/flutter_web_project_client.dart';

/// Provides authentication against the Serverpod backend and manages
/// session tokens using [FlutterSecureStorage].
class AuthService {
  AuthService(this.client);

  /// Generated Serverpod client.
  final Client client;

  /// Storage for persisting the session token between app launches.
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _tokenKey = 'session_token';

  /// Attempts to log in with [email] and [password].
  ///
  /// Returns `true` if the server responds with a valid session token.
  Future<bool> login(String email, String password) async {
    final token = await client.auth.login(email, password);
    if (token != null) {
      await _persistToken(token);
      return true;
    }
    return false;
  }

  /// Registers a new user account with [email] and [password].
  ///
  /// Returns `true` if a session token was returned by the server.
  Future<bool> register(String email, String password) async {
    final token = await client.auth.register(email, password);
    if (token != null) {
      await _persistToken(token);
      return true;
    }
    return false;
  }

  /// Persists the session [token] and updates the client's authentication key.
  Future<void> _persistToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    client.authenticationKeyManager.replaceKey(token);
  }

  /// Reads the locally stored session token, if any.
  Future<String?> getStoredToken() => _storage.read(key: _tokenKey);

  /// Clears the session from secure storage and the client.
  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    client.authenticationKeyManager.clear();
  }
}
