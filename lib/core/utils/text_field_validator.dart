class TextFieldValidator {
  String? vaildateUserName(String? userName) {
    if (userName == null || userName.isEmpty) {
      return 'User name is required';
    }

    if (userName.length < 3) {
      return 'User name must be bigget than 3 characters';
    }

    if (RegExp(r'^[0-9]').hasMatch(userName)) {
      return 'User name cannot start with number';
    }

    return null;
  }

  String? vaildatePaswword(String? password) {
    if (password == null || password.isEmpty) {
      return 'password is required';
    }

    if (password.length < 8) {
      return 'password must be at least 8 characters';
    }

    final hasUpperCaseLetter = RegExp(r'[A-Z]').hasMatch(password);
    final hasLawerCaseLetter = RegExp(r'[a-z]').hasMatch(password);
    final hasSpecialCarchetrs = RegExp(r'[@#<>!*&%$:{}?]').hasMatch(password);
    final haSNumber = RegExp(r'\d').hasMatch(password);

    if (!haSNumber) {
      return 'Password must number';
    }

    if (!hasUpperCaseLetter) {
      return 'Password must at least one uppercaseletter';
    }

    if (!hasLawerCaseLetter) {
      return 'Password must contains at least one  lawercaseletter';
    }

    if (!hasSpecialCarchetrs) {
      return 'Password must contains at least one special character';
    }

    return null;
  }

  String ?vaildateLimit(String? limit){ 
    
    if (limit == null || limit.trim().isEmpty) 
    {
    return 'Please enter a number';
    }
     final number = int.tryParse(limit.trim());

                      if (number == null) {return 'Please enter a valid number';}
                      if (number < 2) {return 'Number must be at least 2';}
                      if (number > 10000000) {return 'Number too large (max: 10,000,000)';}
                      return null;

  }
}
