abstract class RegisterEvent {
  const RegisterEvent();
}

class OnUsernameChanged extends RegisterEvent {
  final String username;
  const OnUsernameChanged({required this.username});
}

class OnPasswordChangedRegister extends RegisterEvent {
  final String password;
  const OnPasswordChangedRegister({required this.password});
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
