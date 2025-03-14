mixin SignupMixin {
  static const String USERNAME_FIELD = "username";
  static const String PASSWORD_FIELD = "password";
  static const String CONFIRM_PASSWORD_FIELD = "confirm password";
  static const String IDENTIFICATION_FIELD = "identification";
  String? validator(String campo, {String? value, String? compare}) {
    if (value == null || value.isEmpty) {
      return "El ${campo} es obligatorio";
    }

    switch (campo) {
      case USERNAME_FIELD:
        if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value)) {
          return "Email invalido";
        }
        return null;
      case PASSWORD_FIELD:
        if (!RegExp(r"^(?=.{5,}).*$$").hasMatch(value)) {
          return "La password debe tener al menos 5 caracteres";
        }

        if (!RegExp(r"^(?=.*[A-Z]).*$$").hasMatch(value)) {
          return "La password debe tener al menos una mayuscula";
        }

        if (!RegExp(r"^(?=.*[0-9]).*$$").hasMatch(value)) {
          return "La password debe tener al menos un numero";
        }

        if (!RegExp(r"^(?=.*[@#$%^&+=]).*$$").hasMatch(value)) {
          return "La password debe tener al menos un caracter especial";
        }

        if (!RegExp(r"^(?=.*[a-z]).*$$").hasMatch(value)) {
          return "La password debe tener al menos una minuscula";
        }

        /*if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+$").hasMatch(value)){
          return "Passwod invalido";
        }
        if (!RegExp(r"^(?=.{8,})(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$$").hasMatch(value)) {
          return "La contraseña debe contener al menos una minúscula, una mayúscula, un número y un carácter especial";
        }*/
        return null;
      case IDENTIFICATION_FIELD:
        if (!RegExp(
          r"^[0-9]+",
        ).hasMatch(value)) {
          return "La identificacion solo pueden ser numeros";
        }
        return null;
      case CONFIRM_PASSWORD_FIELD:
        if (value != compare) {
          return "Las contraseñas no coinciden";
        }
        return null;
      default:
        return null;
    }
  }
}
