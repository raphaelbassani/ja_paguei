enum StatusEnum {
  idle,
  loading,
  loaded,
  error;

  const StatusEnum();

  bool get isIdle => this == idle;

  bool get isLoading => this == loading;

  bool get isLoaded => this == loaded;

  bool get isError => this == error;
}
