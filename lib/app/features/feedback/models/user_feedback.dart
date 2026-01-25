class UserFeedback implements Exception {
  final String message;
  UserFeedback(this.message);
  @override
  String toString() => message;
}
