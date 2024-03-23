enum StatusFilter {
  all,
  alive,
  dead,
  unknown
}

extension ApiNameExtension on StatusFilter {
  String get apiName {
    switch (this) {
      case StatusFilter.all:
        return '';
      case StatusFilter.alive:
        return 'alive';
      case StatusFilter.dead:
        return 'dead';
      case StatusFilter.unknown:
        return 'unknown';
      default:
        return '';
    }
  }
}