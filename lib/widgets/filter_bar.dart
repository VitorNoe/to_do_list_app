import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
      builder: (context, taskService, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Filter chips
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        context,
                        'All',
                        TaskFilter.all,
                        taskService.currentFilter,
                        Icons.list,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        context,
                        'Pending',
                        TaskFilter.pending,
                        taskService.currentFilter,
                        Icons.pending_actions,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        context,
                        'Completed',
                        TaskFilter.completed,
                        taskService.currentFilter,
                        Icons.check_circle,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Sort button
              PopupMenuButton<TaskSort>(
                onSelected: (sort) => taskService.setSort(sort),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: TaskSort.dateCreated,
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 18),
                        SizedBox(width: 8),
                        Text('Date Created'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: TaskSort.priority,
                    child: Row(
                      children: [
                        Icon(Icons.priority_high, size: 18),
                        SizedBox(width: 8),
                        Text('Priority'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: TaskSort.alphabetical,
                    child: Row(
                      children: [
                        Icon(Icons.sort_by_alpha, size: 18),
                        SizedBox(width: 8),
                        Text('Alphabetical'),
                      ],
                    ),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sort,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    TaskFilter filter,
    TaskFilter currentFilter,
    IconData icon,
  ) {
    final isSelected = filter == currentFilter;
    
    return GestureDetector(
      onTap: () => context.read<TaskService>().setFilter(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade600 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

