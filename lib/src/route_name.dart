abstract class AppRoutes {
  final String name;

  const AppRoutes(this.name);

  String get path => "/$name";

  @override
  String toString() => path;

  @override
  bool operator ==(Object other) => other is AppRoutes && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
