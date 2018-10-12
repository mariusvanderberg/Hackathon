class UnauthorisedException implements Exception {
  final String message;
  final Exception innerException;

  const UnauthorisedException(this.message, this.innerException);
  const UnauthorisedException.closed()
      : message = 'Unauthorised Access',
        innerException = null;

  String toString() {
    StringBuffer sb = new StringBuffer();
    sb.write("UnauthorisedException: $message");

    if (innerException != null) {
      sb.write("Inner Exception:");
      sb.write(innerException.toString());
    }

    return sb.toString();
  }
}
