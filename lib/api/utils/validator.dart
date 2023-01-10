mixin Validator {
  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // String pattern = r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  String? emailValidator(String? fieldContent) {
    String content = fieldContent ?? '';
    if (content.isEmpty) {
      return 'Enter an Email';
    } else {
      if (isEmailValid(content)) {
        return null;
      } else {
        return 'Please enter a valid email';
      }
    }
  }

  String? passwordValidator(String? fieldContent) {
    String content = fieldContent ?? '';
    if (content.isEmpty) {
      return 'Enter Password';
    } else {
      if (isPasswordValid(content)) {
        return null;
      } else {
        RegExp capitalRegex = RegExp(r'^(?=.*?[A-Z])');
        RegExp smallRegex = RegExp(r'^(?=.*?[a-z])');
        RegExp digitRegex = RegExp(r'^(?=.*?[0-9])');
        RegExp specialCharRegex = RegExp(r'^(?=.*?[!@#\$&*~])');

        if (!capitalRegex.hasMatch(content)) {
          return 'Capital is missing';
        } else if (!smallRegex.hasMatch(content)) {
          return 'Small character is missing';
        } else if (!digitRegex.hasMatch(content)) {
          return 'Digit is missing';
        } else if (!specialCharRegex.hasMatch(content)) {
          return 'Special character is missing';
        } else {
          return 'Password should have 8 character';
        }
      }
    }
  }
}
