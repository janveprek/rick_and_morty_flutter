sealed class ScreenState {
  const ScreenState();
}

class LoadingState extends ScreenState {
  const LoadingState();
}

class ErrorState extends ScreenState {
  const ErrorState();
}

class EmptyState extends ScreenState {}

class SuccessState extends ScreenState {

  const SuccessState();
}