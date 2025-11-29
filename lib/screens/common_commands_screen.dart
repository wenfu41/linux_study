import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/command_provider.dart';
import '../widgets/command_card.dart';

class CommonCommandsScreen extends StatelessWidget {
  const CommonCommandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CommandProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = provider.categories;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final commands = provider.getCommandsByCategory(category);

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                title: Text(
                  category,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  _getCategoryIcon(category),
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: commands
                    .map((cmd) => CommandCard(command: cmd))
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '文件管理':
        return Icons.folder;
      case '文本处理':
        return Icons.text_snippet;
      case '权限管理':
        return Icons.security;
      case '系统管理':
        return Icons.settings_system_daydream;
      case '网络管理':
        return Icons.network_check;
      case '压缩备份':
        return Icons.archive;
      default:
        return Icons.code;
    }
  }
}
