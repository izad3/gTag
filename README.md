# Gamer Tag Task Chat Application

A modern Flutter chat application with a sleek UI design inspired by iMessage, featuring real-time messaging capabilities and cross-platform support.

## Features

- 💬 iMessage-style chat interface
- 🎮 Switch between multiple gamer profiles (Max Payne, Mona Sax)
- ⏱️ Self-destructing messages with timer functionality
- 👆 Swipe-to-delete messages
- ✅ Read receipts with timestamps
- 📱 Responsive design with custom UI scaling
- 🎨 Modern UI with SF Pro Text font
- 🌐 Cross-platform support (iOS, Android, Web, Windows, Linux, macOS)

## Technical Stack

- **Framework**: Flutter ^3.5.4
- **State Management**: flutter_bloc ^8.1.6
- **UI Components**: Custom chat bubbles with animations
- **Asset Management**: SVG support via flutter_svg
- **Unique Identifiers**: UUID generation
- **Date Formatting**: intl package

## Project Structure

- `lib/`
  - `cubits/` - BLoC state management
  - `models/` - Data models
  - `pages/` - Screen implementations
  - `utilities/` - Helper functions and constants
  - `widgets/` - Reusable UI components

## Getting Started

### Prerequisites

- Flutter SDK ^3.24.5
- Dart SDK ^3.5.4

### Installation

1. Clone the repository:

```bash
git clone https://github.com/izad3/gTag.git
```

2. Install dependencies:

``` bash
flutter pub get
```

3. Run the app:

``` bash
flutter run
```