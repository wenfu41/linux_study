class LinuxCommand {
  final String name;
  final String description;
  final String fullDescription;
  final String category;
  final String example;
  final List<String> pitfalls;
  final List<Map<String, String>> options;
  final List<String> relatedCommands;
  final String difficulty; // 初级, 中级, 高级
  final String commonUseCase;

  LinuxCommand({
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.category,
    required this.example,
    required this.pitfalls,
    this.options = const [],
    this.relatedCommands = const [],
    this.difficulty = '初级',
    this.commonUseCase = '',
  });

  factory LinuxCommand.fromJson(Map<String, dynamic> json) {
    // Handle pitfalls: support both String (old) and List (new)
    List<String> parsedPitfalls = [];
    if (json['pitfalls'] is String) {
      parsedPitfalls = [json['pitfalls']];
    } else if (json['pitfalls'] is List) {
      parsedPitfalls = List<String>.from(json['pitfalls']);
    }

    // Handle options
    List<Map<String, String>> parsedOptions = [];
    if (json['options'] != null) {
      parsedOptions = (json['options'] as List).map((item) {
        return Map<String, String>.from(item);
      }).toList();
    }

    // Handle relatedCommands
    List<String> parsedRelated = [];
    if (json['relatedCommands'] != null) {
      parsedRelated = List<String>.from(json['relatedCommands']);
    }

    return LinuxCommand(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      fullDescription: json['fullDescription'] as String? ?? '',
      category: json['category'] as String? ?? '其他',
      example: json['example'] as String? ?? '',
      pitfalls: parsedPitfalls,
      options: parsedOptions,
      relatedCommands: parsedRelated,
      difficulty: json['difficulty'] as String? ?? '初级',
      commonUseCase: json['commonUseCase'] as String? ?? '',
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
      'options': options,
      'relatedCommands': relatedCommands,
      'difficulty': difficulty,
      'commonUseCase': commonUseCase,
    };
  }
}
