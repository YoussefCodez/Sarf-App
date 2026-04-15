sealed class AuthIntent {}

class SignUpIntent extends AuthIntent {
  final String email;
  final String password;
  final String name;

  SignUpIntent({
    required this.email,
    required this.password,
    required this.name,
  });
}

class LoginIntent extends AuthIntent {
  final String email;
  final String password;

  LoginIntent({
    required this.email,
    required this.password,
  });
}