class LinuxCommand {
  final String name;
  final String description;
  final String fullDescription;
  final String category;
  final String example;
  final String pitfalls;

  LinuxCommand({
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.category,
    required this.example,
    required this.pitfalls,
  });

  factory LinuxCommand.fromJson(Map<String, dynamic> json) {
    return LinuxCommand(
      name: json['name'] as String,
      description: json['description'] as String,
      fullDescription: json['fullDescription'] as String,
      category: json['category'] as String,
      example: json['example'] as String,
      pitfalls: json['pitfalls'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'fullDescription': fullDescription,
      'category': category,
      'example': example,
      'pitfalls': pitfalls,
    };
  }
}
