class LinuxPackage {
  final String name;
  final String description;
  final String fullDescription;
  final String installCommand;
  final String category;

  LinuxPackage({
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.installCommand,
    required this.category,
  });

  factory LinuxPackage.fromJson(Map<String, dynamic> json) {
    return LinuxPackage(
      name: json['name'] as String,
      description: json['description'] as String,
      fullDescription: json['fullDescription'] as String,
      installCommand: json['installCommand'] as String,
      category: json['category'] as String,
    );
  }
}
