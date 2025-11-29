import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import '../models/command_model.dart';

class CommandDetailScreen extends StatelessWidget {
  final LinuxCommand command;

  const CommandDetailScreen({Key? key, required this.command})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(command.name),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(
                    command.difficulty,
                  ).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getDifficultyColor(command.difficulty),
                  ),
                ),
                child: Text(
                  command.difficulty,
                  style: TextStyle(
                    color: _getDifficultyColor(command.difficulty),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, "命令描述"),
            const SizedBox(height: 8),
            Text(
              command.fullDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (command.commonUseCase.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildSectionTitle(context, "常见场景"),
              const SizedBox(height: 8),
              Text(
                command.commonUseCase,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (command.options.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildSectionTitle(context, "常用选项"),
              const SizedBox(height: 8),
              ...command.options.map(
                (opt) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          opt['code'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(opt['desc'] ?? '')),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            _buildSectionTitle(context, "示例代码"),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: HighlightView(
                command.example,
                language: 'bash',
                theme: atomOneDarkTheme,
                padding: const EdgeInsets.all(12),
                textStyle: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
              ),
            ),
            if (command.pitfalls.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildSectionTitle(context, "注意事项 & 常见坑"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Column(
                  children: command.pitfalls
                      .map(
                        (pitfall) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  pitfall,
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
            if (command.relatedCommands.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildSectionTitle(context, "相关命令"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: command.relatedCommands
                    .map(
                      (cmd) => Chip(
                        label: Text(cmd),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case '初级':
        return Colors.green;
      case '中级':
        return Colors.orange;
      case '高级':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
