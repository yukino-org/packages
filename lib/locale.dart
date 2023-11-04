part 'locale.g.dart';

class Locale {
  const Locale(this.display, this.native, this.code);

  factory Locale.fromJson(final Map<String, dynamic> json) => Locale(
        json['display'] as String,
        json['native'] as String,
        json['code'] as String,
      );

  factory Locale.parse(final String code) => LocalesRepository.all[code]!;

  final String display;
  final String native;
  final String code;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'display': display,
        'native': native,
        'code': code,
      };

  @override
  String toString() => 'Locale<$code>';

  @override
  bool operator ==(final Object other) => other is Locale && code == other.code;

  @override
  int get hashCode => Object.hash(display, code);

  static Locale? tryParse(final String code) => LocalesRepository.all[code];
}
