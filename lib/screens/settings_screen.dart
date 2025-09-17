import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';
import '../utils/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Data Management Section
            _buildSectionHeader(context, 'Data Management', Icons.storage),
            const SizedBox(height: 12),
            _buildSettingsCard(
              context,
              children: [
                _buildSettingsTile(
                  context,
                  title: 'Export Tasks',
                  subtitle: 'Export all tasks to a file',
                  icon: Icons.download,
                  onTap: () => _exportTasks(context),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  context,
                  title: 'Clear Completed Tasks',
                  subtitle: 'Remove all completed tasks',
                  icon: Icons.clear_all,
                  onTap: () => _clearCompletedTasks(context),
                  isDestructive: true,
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  context,
                  title: 'Reset All Data',
                  subtitle: 'Delete all tasks and reset the app',
                  icon: Icons.delete_forever,
                  onTap: () => _resetAllData(context),
                  isDestructive: true,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Statistics Section
            _buildSectionHeader(context, 'Statistics', Icons.analytics),
            const SizedBox(height: 12),
            _buildStatisticsCard(context),

            const SizedBox(height: 24),

            // App Information Section
            _buildSectionHeader(context, 'About', Icons.info),
            const SizedBox(height: 12),
            _buildSettingsCard(
              context,
              children: [
                _buildSettingsTile(
                  context,
                  title: 'Version',
                  subtitle: '1.0.0',
                  icon: Icons.info_outline,
                  onTap: null,
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  context,
                  title: 'Developer',
                  subtitle: 'Flutter Task Manager Team',
                  icon: Icons.code,
                  onTap: null,
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  context,
                  title: 'License',
                  subtitle: 'MIT License',
                  icon: Icons.description,
                  onTap: () => _showLicense(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppTheme.primaryBlue,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      decoration: AppTheme.elevatedCard,
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive 
              ? Colors.red.withOpacity(0.1)
              : AppTheme.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isDestructive ? Colors.red : AppTheme.primaryBlue,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : AppTheme.darkBlue,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
        ),
      ),
      trailing: onTap != null
          ? Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildStatisticsCard(BuildContext context) {
    return Consumer<TaskService>(
      builder: (context, taskService, child) {
        return FutureBuilder<Map<String, int>>(
          future: taskService.getTaskStatistics(),
          builder: (context, snapshot) {
            final stats = snapshot.data ?? {'total': 0, 'completed': 0, 'pending': 0};
            
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.elevatedCard,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        context,
                        'Total Tasks',
                        stats['total'].toString(),
                        Icons.list_alt,
                        AppTheme.primaryBlue,
                      ),
                      _buildStatItem(
                        context,
                        'Completed',
                        stats['completed'].toString(),
                        Icons.check_circle,
                        Colors.green,
                      ),
                      _buildStatItem(
                        context,
                        'Pending',
                        stats['pending'].toString(),
                        Icons.pending,
                        Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (stats['total']! > 0)
                    LinearProgressIndicator(
                      value: stats['completed']! / stats['total']!,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBlue,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  void _exportTasks(BuildContext context) {
    // TODO: Implement task export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export functionality coming soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _clearCompletedTasks(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Completed Tasks'),
        content: const Text(
          'Are you sure you want to delete all completed tasks? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskService>().clearCompletedTasks();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Completed tasks cleared'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _resetAllData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Data'),
        content: const Text(
          'Are you sure you want to delete ALL tasks and reset the app? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskService>().deleteAllTasks();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All data has been reset'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showLicense(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('MIT License'),
        content: const SingleChildScrollView(
          child: Text(
            'MIT License\n\n'
            'Copyright (c) 2024 Flutter Task Manager\n\n'
            'Permission is hereby granted, free of charge, to any person obtaining a copy '
            'of this software and associated documentation files (the "Software"), to deal '
            'in the Software without restriction, including without limitation the rights '
            'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell '
            'copies of the Software, and to permit persons to whom the Software is '
            'furnished to do so, subject to the following conditions:\n\n'
            'The above copyright notice and this permission notice shall be included in all '
            'copies or substantial portions of the Software.\n\n'
            'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR '
            'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, '
            'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

