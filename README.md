# 📱 Flutter Demo App

A Flutter application demonstrating **high-performance data handling** and **offline-first architecture** using the **BLoC pattern**.

---

## 🚀 Features

### 📰 Feed Screen

* Displays a **large list of items** with images and charts
* Uses **pagination (infinite scroll)**
* Optimized with:

  * ✅ `compute()` for background JSON parsing
  * ✅ `RepaintBoundary` to reduce unnecessary UI rebuilds
  * ✅ `CachedNetworkImage` for efficient image loading
* Handles **network cancellation** using Dio `CancelToken`
* Smooth scrolling performance even with large datasets

---

### ✅ Task Screen (Offline-First)

* Fully functional **offline task management system**
* Implements **Optimistic UI updates**
* Uses **Hive (local database)** as source of truth
* Syncs with server when internet is available

#### 🔄 Sync Features

* Add / Update / Delete tasks offline
* Automatic sync when connectivity is restored
* Batch processing for large data sync
* Retry mechanism for failed requests

---

## 🏗️ Architecture

The app follows **Clean Architecture + BLoC pattern**:

```
lib/
 └── src/
      ├── core/
      │     └── utils/
      │           └── json_parser.dart
      │
      └── features/
            ├── feed/
            │     ├── data/
            │     ├── domain/
            │     └── presentation/
            │
            └── task/
                  ├── data/
                  ├── domain/
                  └── presentation/
```

---

## 🧠 Key Concepts Demonstrated

* 🔥 Background processing using `compute()`
* 📦 Efficient JSON parsing with reusable utilities
* ⚡ Infinite scrolling with pagination
* 🌐 Network request cancellation (Dio)
* 💾 Offline-first data handling (Hive)
* 🔄 Sync queue with batching & retry logic
* 🎯 Reactive UI using BLoC & Streams

---

## 🛠️ Tech Stack

* **Flutter**
* **Dio** (Networking)
* **Hive** (Local Storage)
* **flutter_bloc** (State Management)
* **Freezed** (Immutable models)

---

## ▶️ Getting Started

```bash
git clone <your-repo-url>](https://github.com/JiyadAhammad/kutoot_task
cd project
flutter pub get
flutter run
```

---

## 📌 Notes

* Feed API uses mock data (`jsonplaceholder`)
* Image URLs replaced with reliable sources for consistency
* Designed for scalability and real-world production patterns

---

## 👨‍💻 Author

**Jiyad Ahammad**
Flutter Developer

---
