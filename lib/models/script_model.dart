class ScriptTopic {
  final String title;
  final String content;
  final String code;

  ScriptTopic({required this.title, required this.content, required this.code});

  factory ScriptTopic.fromJson(Map<String, dynamic> json) {
    return ScriptTopic(
      title: json['title'] as String,
      content: json['content'] as String,
      code: json['code'] as String,
    );
  }
}
