# Flutter Task Manager

A modern, feature-rich task management application built with Flutter, featuring a stunning Frutiger Aero design aesthetic with glass morphism effects, smooth animations, and comprehensive task organization capabilities. This application runs seamlessly on both Windows and Android platforms, providing users with a beautiful and efficient way to manage their daily tasks.

## Table of Contents

- [Features](#features)
- [Design Philosophy](#design-philosophy)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## Features

### Core Functionality
- **Task Management**: Create, edit, complete, and delete tasks with ease
- **Persistent Storage**: All tasks are stored locally using SQLite database
- **Real-time Updates**: Instant UI updates with state management using Provider
- **Cross-platform**: Runs on Windows and Android devices

### Advanced Features
- **Smart Filtering**: Filter tasks by completion status (All, Pending, Completed)
- **Category Organization**: Organize tasks into customizable categories
- **Priority System**: Assign priority levels (Low, Medium, High) to tasks
- **Search Functionality**: Quickly find tasks using the built-in search feature
- **Task Statistics**: View comprehensive statistics about your task completion
- **Sorting Options**: Sort tasks by date created, priority, or alphabetically

### User Interface
- **Frutiger Aero Design**: Modern glass morphism effects with blue, white, and silver color scheme
- **Smooth Animations**: Fluid transitions and micro-interactions throughout the app
- **Responsive Layout**: Optimized for both desktop and mobile interfaces
- **Intuitive Navigation**: Clean and user-friendly interface design
- **Dark/Light Themes**: Consistent theming with Material Design 3

### Data Management
- **Export Functionality**: Export tasks to external files (coming soon)
- **Data Backup**: Local database ensures data persistence
- **Settings Panel**: Comprehensive settings for app customization
- **Statistics Dashboard**: Visual representation of task completion progress

## Design Philosophy

The Flutter Task Manager embraces the **Frutiger Aero** design aesthetic, characterized by:

### Visual Elements
- **Glass Morphism**: Translucent containers with subtle shadows and borders
- **Color Palette**: Primary blue (#2196F3), pure white (#FFFFFF), and silver (#C0C0C0)
- **Modern Typography**: Clean, readable fonts with proper hierarchy
- **Grid-based Layout**: Structured, organized interface elements

### User Experience
- **Minimalist Approach**: Clean interface without unnecessary clutter
- **Intuitive Interactions**: Natural gestures and familiar patterns
- **Smooth Animations**: Carefully crafted transitions that enhance usability
- **Accessibility**: High contrast ratios and readable text sizes

### Technical Excellence
- **Performance Optimized**: Efficient rendering and smooth 60fps animations
- **Memory Management**: Proper disposal of resources and controllers
- **Error Handling**: Graceful error handling with user-friendly messages
- **Code Quality**: Well-structured, maintainable, and documented codebase

## Architecture

The application follows a clean architecture pattern with clear separation of concerns:

### Data Layer
```
models/
├── task.dart              # Task data model with serialization
```

### Service Layer
```
services/
├── database_helper.dart   # SQLite database operations
├── task_service.dart      # Business logic and state management
```

### Presentation Layer
```
screens/
├── home_screen.dart       # Main application screen
├── settings_screen.dart   # Settings and preferences

widgets/
├── task_list_widget.dart      # Task list display
├── task_item_widget.dart      # Individual task item
├── add_task_dialog.dart       # Task creation dialog
├── filter_bar.dart           # Task filtering controls
├── search_bar_widget.dart     # Search functionality
├── stats_card.dart           # Statistics display
├── category_filter_widget.dart # Category filtering
```

### Utilities
```
utils/
├── app_theme.dart         # Application theming and colors
├── animations.dart        # Animation utilities and helpers
```

### State Management
The application uses the **Provider** pattern for state management, ensuring:
- Reactive UI updates
- Centralized state management
- Efficient rebuilds
- Clean separation between UI and business logic

### Database Schema
```sql
CREATE TABLE tasks(
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  isCompleted INTEGER NOT NULL DEFAULT 0,
  createdAt INTEGER NOT NULL,
  completedAt INTEGER,
  category TEXT DEFAULT 'General',
  priority INTEGER DEFAULT 2
);
```

## Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- For Windows: Windows 10 or higher
- For Android: Android 5.0 (API level 21) or higher

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/VitorNoe/to_do_list_app.git
   cd flutter_task_manager
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   
   For Android:
   ```bash
   flutter run
   ```
   
   For Windows:
   ```bash
   flutter run -d windows
   ```

4. **Build for Production**
   
   Android APK:
   ```bash
   flutter build apk --release
   ```
   
   Windows Executable:
   ```bash
   flutter build windows --release
   ```

### Configuration

The application works out of the box with default settings. No additional configuration is required for basic functionality.

## Usage

### Getting Started

1. **Launch the Application**: Open the Flutter Task Manager on your device
2. **Create Your First Task**: Tap the "+" button to add a new task
3. **Fill Task Details**: Enter title, description, category, and priority
4. **Manage Tasks**: Use the interface to complete, edit, or delete tasks

### Task Management

#### Creating Tasks
- Tap the floating action button or the "+" icon in the header
- Fill in the task details in the dialog:
  - **Title**: Required field for the task name
  - **Description**: Optional detailed description
  - **Category**: Choose from predefined categories or create new ones
  - **Priority**: Select Low, Medium, or High priority

#### Completing Tasks
- Tap the circular checkbox next to any task to mark it as completed
- Completed tasks will show a checkmark and strikethrough text
- Completion timestamp is automatically recorded

#### Editing Tasks
- Tap the three-dot menu on any task item
- Select "Edit" to modify task details
- Changes are saved automatically

#### Deleting Tasks
- Tap the three-dot menu on any task item
- Select "Delete" and confirm the action
- Deleted tasks cannot be recovered

### Filtering and Search

#### Filter Options
- **All**: Show all tasks regardless of status
- **Pending**: Show only incomplete tasks
- **Completed**: Show only finished tasks

#### Category Filtering
- Use the category chips to filter tasks by category
- Categories are automatically created when you assign them to tasks
- "All" category shows tasks from all categories

#### Search Functionality
- Use the search bar to find tasks by title or description
- Search is case-insensitive and matches partial text
- Clear the search to return to normal view

#### Sorting Options
- **Date Created**: Sort by creation date (newest first)
- **Priority**: Sort by priority level (high to low)
- **Alphabetical**: Sort by task title (A to Z)

### Statistics and Analytics

The statistics card shows:
- **Total Tasks**: Complete count of all tasks
- **Completed**: Number of finished tasks
- **Pending**: Number of remaining tasks
- **Progress Percentage**: Visual completion rate

### Settings and Preferences

Access the settings screen to:
- View detailed task statistics
- Export task data (coming soon)
- Clear completed tasks
- Reset all application data
- View app information and license

## Project Structure

```
flutter_task_manager/
├── lib/
│   ├── main.dart                    # Application entry point
│   ├── models/
│   │   └── task.dart               # Task data model
│   ├── screens/
│   │   ├── home_screen.dart        # Main application screen
│   │   └── settings_screen.dart    # Settings and preferences
│   ├── services/
│   │   ├── database_helper.dart    # SQLite database operations
│   │   └── task_service.dart       # Business logic and state management
│   ├── utils/
│   │   ├── animations.dart         # Animation utilities
│   │   └── app_theme.dart          # Application theming
│   └── widgets/
│       ├── add_task_dialog.dart         # Task creation dialog
│       ├── category_filter_widget.dart  # Category filtering
│       ├── filter_bar.dart             # Task filtering controls
│       ├── search_bar_widget.dart      # Search functionality
│       ├── stats_card.dart             # Statistics display
│       ├── task_item_widget.dart       # Individual task item
│       └── task_list_widget.dart       # Task list display
├── assets/
│   ├── fonts/                      # Custom fonts
│   └── images/                     # Application images
├── pubspec.yaml                    # Project dependencies
└── README.md                       # Project documentation
```

## Dependencies

### Core Dependencies
- **flutter**: The Flutter SDK
- **sqflite**: SQLite database for local storage
- **path**: File path manipulation utilities
- **provider**: State management solution
- **cupertino_icons**: iOS-style icons

### UI and Animation Dependencies
- **google_fonts**: Custom typography
- **flutter_staggered_animations**: List animations
- **lottie**: Vector animations (future use)

### Utility Dependencies
- **intl**: Internationalization and date formatting
- **uuid**: Unique identifier generation

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Code quality and style enforcement

## Development

### Code Style and Standards

The project follows Flutter's official style guide and best practices:

- **Naming Conventions**: Use camelCase for variables and functions, PascalCase for classes
- **File Organization**: Group related files in appropriate directories
- **Documentation**: Comprehensive comments for complex logic
- **Error Handling**: Proper try-catch blocks and user feedback

### Testing

Run tests using:
```bash
flutter test
```

### Performance Optimization

The application is optimized for performance through:
- Efficient widget rebuilds using Provider
- Proper disposal of controllers and resources
- Optimized database queries
- Lazy loading of data where appropriate

### Adding New Features

To add new features:

1. **Create Models**: Define data structures in the `models/` directory
2. **Update Services**: Add business logic to appropriate service classes
3. **Create Widgets**: Build reusable UI components in `widgets/`
4. **Update Screens**: Integrate new features into existing screens
5. **Test Thoroughly**: Ensure new features work across platforms

### Debugging

For debugging:
- Use Flutter Inspector for widget tree analysis
- Enable debug mode for detailed error messages
- Use print statements or debugger for logic debugging
- Test on both platforms to ensure compatibility

## Contributing

We welcome contributions to the Flutter Task Manager! Please follow these guidelines:

### Getting Started
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Code Quality
- Follow the existing code style
- Add tests for new features
- Update documentation as needed
- Ensure cross-platform compatibility

### Bug Reports
When reporting bugs, please include:
- Device and OS version
- Flutter version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable

## License

This project is licensed under the MIT License. See the LICENSE file for details.

```
MIT License

Copyright (c) 2025 Vítor Luciano Cardoso Noé

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

For support or questions, please open an issue on the project repository.
