# Simple Todo App 📝

A beginner-friendly Flutter project designed to manage daily tasks with reminder notifications and due dates. This app serves as an introduction to Flutter development, covering core concepts like state management, UI design, local notifications, and third-party package integration.

---

## ✨ Features

*   **Add Tasks:** Easily create new to-do items.
*   **Mark as Complete/Incomplete:** Toggle the completion status of tasks with a checkbox.
*   **Edit Tasks:** Modify the name of existing tasks.
*   **Delete Tasks:** Remove tasks with a swipe-to-delete action.
*   **Set Reminders:** Schedule local notifications to remind you about tasks at specific times.
*   **Set Due Dates:** Assign due dates to tasks for better organization.
*   **Visual Cues:** Overdue tasks are highlighted.
*   **User-Friendly Interface:** Clean and intuitive light theme.
*   **Slidable Actions:** Swipe task items to reveal edit and delete options.

---

## 📸 Screenshots

*(**IMPORTANT**: Add your screenshots here! Take a few good shots of the app in action: the main list, adding a task, setting a reminder/due date, an overdue task, etc. A GIF is even better if you can make one!)*

**Example Placeholder:**
*   [Screenshot of Main List]
*   [Screenshot of Add Task Dialog]
*   [Screenshot of Reminder Picker]

---

## 🛠️ Tech Stack & Key Packages

*   **Flutter SDK:** The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
*   **Dart:** The programming language used by Flutter.
*   **Packages:**
    *   `flutter_local_notifications`: For scheduling and displaying local push notifications (task reminders).
    *   `flutter_slidable`: For creating list items with dismissible/slidable actions (edit, delete).
    *   `intl`: For date and time formatting (displaying due dates and reminder times).
    *   `timezone`: Dependency for `flutter_local_notifications` to handle timezones correctly.

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

*   Flutter SDK (version 3.x.x or higher recommended)
*   An editor like Android Studio or VS Code (with Flutter and Dart plugins)
*   An Android Emulator or a physical Android/iOS device

### Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/sanggitsaaran/Simple_Todo_App
    ```

2.  **Navigate to the project directory:**
    ```bash
    cd simple_todo
    ```

3.  **Get dependencies:**
    ```bash
    flutter pub get
    ```

---

## 🏃 Running the App

1.  **Ensure you have an emulator running or a physical device connected** and recognized by Flutter:
    ```bash
    flutter devices
    ```

2.  **Run the app:**
    ```bash
    flutter run
    ```
    This command will build and install the Flutter application on your connected device or emulator.

---

## 📁 Project Structure (Key Files)

simple_todo/
├── lib/
│ ├── main.dart # App entry point, initializes NotificationService
│ ├── home_page.dart # Main screen UI, state management for todo list
│ └── utils/
│ ├── todo_list.dart # Widget for individual todo list items
│ └── notification_service.dart # Service for handling local notifications
├── android/ # Android specific files
├── ios/ # iOS specific files
├── pubspec.yaml # Project dependencies and metadata
└── README.md # This file!

---

## 🔮 Potential Future Enhancements

*   **Data Persistence:** Save tasks locally using `shared_preferences`, `sqflite`, or `hive` so they don't disappear when the app closes.
*   **Task Priorities:** Allow users to set high, medium, or low priority for tasks.
*   **Sorting & Filtering:** Options to sort tasks (by due date, priority) and filter (by completed, active).
*   **Dark Mode:** Implement a dark theme option.
*   **Sub-tasks:** Allow adding sub-tasks or checklists within a main task.
*   **Recurring Tasks:** Functionality for tasks that repeat daily, weekly, etc.

---

## 💡 Learning Journey

This project was my first step into the world of Flutter development. It helped me understand:

*   Basic widget composition and layout (Scaffold, AppBar, ListView, Row, Column, etc.).
*   Stateful vs. Stateless widgets and managing state with `setState()`.
*   Handling user input with `TextField` and `AlertDialog`.
*   Using third-party packages from `pub.dev`.
*   Implementing local notifications for reminders.
*   Basic date and time manipulation.
*   Creating a more interactive UI with `flutter_slidable`.

---

A few resources that were helpful (and for anyone else starting out):

*   [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
*   [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
*   [Flutter official documentation](https://docs.flutter.dev/)

---

Enjoy using the Simple Todo App!