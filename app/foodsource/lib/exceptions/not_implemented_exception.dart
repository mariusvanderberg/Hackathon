class NotImplementedException implements Exception {
  final String message;
  final Exception innerException;

  const NotImplementedException(this.message, {this.innerException});
  const NotImplementedException.closed()
      : message = 'Server Exception',
        innerException = null;

  String toString() {
    StringBuffer sb = new StringBuffer();
    sb.write("NotImplementedException: $message");

    if (innerException != null) {
      sb.write("Inner Exception:");
      sb.write(innerException.toString());
    }

    return sb.toString();
  }
}
