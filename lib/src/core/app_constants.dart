class AppConstants {
  static const String passwordHintText = 'Password', emailHintText = 'Email';
  static RegExp emailRegEx = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
  static const String incorrectEmailWarning =
          "Please enter a valid email address.",
      emptyEmailWarning = "Please enter your email address.",
      emptyTextWarning = "Please enter a value",
      noInternetMessage =
          "No internet connection was found.Check your internet connection or try again";
}
