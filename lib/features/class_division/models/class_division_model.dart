/// Entity representing the class and division configuration for followed institutions.
class SchoolConfigModel {
  final String id;
  final String name;
  final String crestAsset;
  final List<String> classes;
  final List<String> divisions;
  final String? selectedClass;
  final String? selectedDivision;

  const SchoolConfigModel({
    required this.id,
    required this.name,
    this.crestAsset = 'assets/images/salford-crest.png',
    this.classes = const ['LKG', 'UKG', '1', '2', '3', '4', '5', '6'],
    this.divisions = const ['A', 'B', 'C', 'D', 'E'],
    this.selectedClass,
    this.selectedDivision,
  });

  bool get isConfigured => selectedClass != null && selectedDivision != null;

  SchoolConfigModel copyWith({
    String? id,
    String? name,
    String? crestAsset,
    List<String>? classes,
    List<String>? divisions,
    String? selectedClass,
    String? selectedDivision,
    bool clearClass = false,
    bool clearDivision = false,
  }) {
    return SchoolConfigModel(
      id: id ?? this.id,
      name: name ?? this.name,
      crestAsset: crestAsset ?? this.crestAsset,
      classes: classes ?? this.classes,
      divisions: divisions ?? this.divisions,
      selectedClass: clearClass ? null : (selectedClass ?? this.selectedClass),
      selectedDivision: clearDivision ? null : (selectedDivision ?? this.selectedDivision),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'crestAsset': crestAsset,
      'selectedClass': selectedClass,
      'selectedDivision': selectedDivision,
    };
  }

  factory SchoolConfigModel.fromJson(Map<String, dynamic> json) {
    return SchoolConfigModel(
      id: json['id'] as String,
      name: json['name'] as String,
      crestAsset: json['crestAsset'] as String? ?? 'assets/images/salford-crest.png',
      selectedClass: json['selectedClass'] as String?,
      selectedDivision: json['selectedDivision'] as String?,
    );
  }
}
