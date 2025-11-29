import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/command_provider.dart';
import '../widgets/command_card.dart';

class CommandListScreen extends StatefulWidget {
  const CommandListScreen({Key? key}) : super(key: key);

  @override
  State<CommandListScreen> createState() => _CommandListScreenState();
}

class _CommandListScreenState extends State<CommandListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: '搜索命令 (例如: ls, copy...)',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              Provider.of<CommandProvider>(
                context,
                listen: false,
              ).searchCommands(value);
            },
          ),
        ),
        Expanded(
          child: Consumer<CommandProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.commands.isEmpty) {
                return const Center(child: Text("未找到相关命令"));
              }
              return ListView.builder(
                itemCount: provider.commands.length,
                itemBuilder: (context, index) {
                  return CommandCard(command: provider.commands[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
