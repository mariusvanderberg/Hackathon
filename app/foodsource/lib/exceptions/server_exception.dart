class ServerException implements Exception {
  final String message;
  final Exception innerException;

  const ServerException(this.message, this.innerException);
  const ServerException.closed()
      : message = 'Server Exception',
        innerException = null;

  String toString() {
    StringBuffer sb = new StringBuffer();
    sb.write("ServerException: $message");

    if (innerException != null) {
      sb.write("Inner Exception:");
      sb.write(innerException.toString());
    }

    return sb.toString();
  }
}
