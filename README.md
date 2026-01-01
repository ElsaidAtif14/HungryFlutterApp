# Hungry App 🍔🍕

Hungry is a Flutter-based food ordering application that simulates a real-world food delivery experience.  
The app is built using clean architecture concepts and communicates with real APIs for data handling.

## 🚀 Features

- 🔐 Authentication (Login / Profile)
- 🏠 Home screen with products & categories
- 🛒 Cart management
  - Add / remove items
  - Update quantities
  - Handle empty cart state
- 💳 Checkout & order confirmation
- 📦 Order history
- 🔄 Pull-to-refresh support
- ⏳ Proper loading & error handling
- 🌐 Real API integration using Dio

## 🧱 Architecture & Tech Stack

- **Flutter**
- **Dart**
- **State Management:** StatefulWidget / FutureBuilder
- **Networking:** Dio
- **API Handling:** Custom ApiService, ApiError, ApiExceptions
- **UI:** Material & Cupertino widgets
- **Clean separation of layers:**
  - Data
  - View
  - Widgets
  - Repositories
  - Models

## 📂 Project Structure

