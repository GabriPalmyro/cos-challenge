class Failure {
  Failure({required this.message});
  final String message;

  @override
  String toString() => 'Failure: $message';
}
