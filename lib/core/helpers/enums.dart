class TypeNotification {
  final String _value;

  const TypeNotification._internal(this._value);

  @override
  toString() => _value;

  static const user = TypeNotification._internal('user');
  static const admin = TypeNotification._internal('admin');
  static const system = TypeNotification._internal('system');
}
