import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import 'database_helper.dart';

enum TaskFilter { all, pending, completed }
enum TaskSort { dateCreated, priority, alphabetical }

class TaskService extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final Uuid _uuid = const Uuid();

  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  TaskFilter _currentFilter = TaskFilter.all;
  TaskSort _currentSort = TaskSort.dateCreated;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  bool _isLoading = false;

  // Getters
  List<Task> get tasks => _filteredTasks;
  TaskFilter get currentFilter => _currentFilter;
  TaskSort get currentSort => _currentSort;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  // Initialize and load tasks
  Future<void> initialize() async {
    await loadTasks();
  }

  // Load all tasks from database
  Future<void> loadTasks() async {
    _setLoading(true);
    try {
      _tasks = await _databaseHelper.getAllTasks();
      _applyFiltersAndSort();
    } catch (e) {
      debugPrint('Error loading tasks: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Add a new task
  Future<bool> addTask({
    required String title,
    String description = '',
    String category = 'General',
    int priority = 2,
  }) async {
    if (title.trim().isEmpty) return false;

    _setLoading(true);
    try {
      final task = Task(
        id: _uuid.v4(),
        title: title.trim(),
        description: description.trim(),
        category: category,
        priority: priority,
        createdAt: DateTime.now(),
      );

      await _databaseHelper.insertTask(task);
      _tasks.insert(0, task);
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      debugPrint('Error adding task: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Toggle task completion status
  Future<bool> toggleTaskCompletion(String taskId) async {
    _setLoading(true);
    try {
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex == -1) return false;

      final task = _tasks[taskIndex];
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        completedAt: !task.isCompleted ? DateTime.now() : null,
      );

      await _databaseHelper.updateTask(updatedTask);
      _tasks[taskIndex] = updatedTask;
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      debugPrint('Error toggling task completion: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update task
  Future<bool> updateTask({
    required String taskId,
    String? title,
    String? description,
    String? category,
    int? priority,
  }) async {
    _setLoading(true);
    try {
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex == -1) return false;

      final task = _tasks[taskIndex];
      final updatedTask = task.copyWith(
        title: title ?? task.title,
        description: description ?? task.description,
        category: category ?? task.category,
        priority: priority ?? task.priority,
      );

      await _databaseHelper.updateTask(updatedTask);
      _tasks[taskIndex] = updatedTask;
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      debugPrint('Error updating task: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Delete task
  Future<bool> deleteTask(String taskId) async {
    _setLoading(true);
    try {
      await _databaseHelper.deleteTask(taskId);
      _tasks.removeWhere((task) => task.id == taskId);
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      debugPrint('Error deleting task: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Clear all completed tasks
  Future<bool> clearCompletedTasks() async {
    _setLoading(true);
    try {
      await _databaseHelper.deleteCompletedTasks();
      _tasks.removeWhere((task) => task.isCompleted);
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      debugPrint('Error clearing completed tasks: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Delete all tasks
  Future<bool> deleteAllTasks() async {
    _setLoading(true);
    try {
      await _databaseHelper.deleteAllTasks();
      _tasks.clear();
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      debugPrint('Error deleting all tasks: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Set filter
  void setFilter(TaskFilter filter) {
    _currentFilter = filter;
    _applyFiltersAndSort();
  }

  // Set sort
  void setSort(TaskSort sort) {
    _currentSort = sort;
    _applyFiltersAndSort();
  }

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFiltersAndSort();
  }

  // Set selected category
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    _applyFiltersAndSort();
  }

  // Get all categories
  Future<List<String>> getAllCategories() async {
    try {
      final categories = await _databaseHelper.getAllCategories();
      return ['All', ...categories];
    } catch (e) {
      debugPrint('Error getting categories: $e');
      return ['All'];
    }
  }

  // Get task statistics
  Future<Map<String, int>> getTaskStatistics() async {
    try {
      return await _databaseHelper.getTaskCounts();
    } catch (e) {
      debugPrint('Error getting task statistics: $e');
      return {'total': 0, 'completed': 0, 'pending': 0};
    }
  }

  // Apply filters and sorting
  void _applyFiltersAndSort() {
    List<Task> filtered = List.from(_tasks);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((task) {
        return task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            task.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Apply category filter
    if (_selectedCategory != 'All') {
      filtered = filtered.where((task) => task.category == _selectedCategory).toList();
    }

    // Apply completion status filter
    switch (_currentFilter) {
      case TaskFilter.pending:
        filtered = filtered.where((task) => !task.isCompleted).toList();
        break;
      case TaskFilter.completed:
        filtered = filtered.where((task) => task.isCompleted).toList();
        break;
      case TaskFilter.all:
        break;
    }

    // Apply sorting
    switch (_currentSort) {
      case TaskSort.dateCreated:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case TaskSort.priority:
        filtered.sort((a, b) {
          if (a.isCompleted != b.isCompleted) {
            return a.isCompleted ? 1 : -1;
          }
          return b.priority.compareTo(a.priority);
        });
        break;
      case TaskSort.alphabetical:
        filtered.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
    }

    _filteredTasks = filtered;
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

