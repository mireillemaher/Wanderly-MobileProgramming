class Destination {
  final String name;
  final String capital;
  final String region;
  final int population;
  final String flagUrl;

  Destination({
    required this.name,
    required this.capital,
    required this.region,
    required this.population,
    required this.flagUrl,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    final String code = (json['alpha2Code'] ?? '').toString().toLowerCase();
    final String cap = (json['capital'] != null &&
        json['capital'].toString().trim().isNotEmpty)
        ? json['capital']
        : 'N/A';

    return Destination(
      name: json['name'] ?? '',
      capital: cap,
      region: json['region'] ?? '',
      population: json['population'] ?? 0,
      flagUrl: 'https://flagcdn.com/w80/$code.png',
    );
  }

  // Lab 4 Task 4: SQLite conversion
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'capital': capital,
      'region': region,
      'population': population,
      'flagUrl': flagUrl,
    };
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    return Destination(
      name: map['name'] as String,
      capital: map['capital'] as String,
      region: map['region'] as String,
      population: map['population'] as int,
      flagUrl: map['flagUrl'] as String,
    );
  }
}