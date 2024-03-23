abstract class ResultWrapper<T> {}

class Success<T> extends ResultWrapper<T> {
  final T value;

  Success(this.value);
}

class Error<T> extends ResultWrapper<T> {
  final Exception error;

  Error(this.error);
}

