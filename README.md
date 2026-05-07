# Sarf - الذكاء في الصرف 💸



**Sarf (صرف)** is a premium, production-ready finance tracking application built with Flutter. It combines sleek design with robust functionality to help users manage their money, track goals, and build healthy financial habits through a gamified experience.

## ✨ Features

### 📊 Financial Analytics
*   **Dynamic Charts:** Visual breakdown of income vs. expenses using advanced data visualization.
*   **Spending Patterns:** Identify where your money goes with category-wise analysis.
*   **Time-based Reports:** Track your progress over weeks, months, or years.

### 🎯 Goal Tracking & Management
*   **Target Savings:** Set specific financial goals and track your progress in real-time.
*   **Progress Indicators:** Visual feedback on how close you are to reaching your financial milestones.
*   **Smart Allocation:** Understand how your current balance contributes to your saved goals.

### 🛡️ Security & Privacy
*   **Biometric Authentication:** Secure your financial data with Fingerprint or Face ID.
*   **Privacy-First:** Toggle visibility of sensitive balance information on the main dashboard.
*   **Offline-Ready:** Your data is stored securely on your device for instant access.

### ⚡ Smart Transactions
*   **Fuzzy Search:** Quickly find any past transaction with intelligent search logic.
*   **Categorization:** Organize your spending with pre-defined or custom categories.
*   **Cloud Sync:** Automatically sync your data to Supabase when online, ensuring your data is never lost.

### 🏆 Gamified Experience (Streak System)
*   **Daily Check-ins:** Build a streak by logging your finances daily.
*   **Smart Notifications:** Get morning and evening reminders to keep your streak alive.
*   **Productivity Focus:** Encourages consistent financial awareness through notification-based nudges.

### 💳 Payment Management
*   **Card Tracking:** Manage multiple payment cards and track their specific spending.
*   **Card Branding:** Automatic identification of card brands (Visa, Mastercard, etc.).

---

## 🏗️ Technical Architecture

The project follows **Clean Architecture** principles to ensure maintainability, testability, and scalability.

*   **Presentation Layer:** Uses **Riverpod** for state management and functional UI updates.
*   **Domain Layer:** Contains pure business logic, entities, and use case definitions.
*   **Data Layer:** Implements repositories, data sources (Hive for local, Supabase for remote), and models.
*   **Dependency Injection:** Managed via **GetIt** and **Injectable** for clean, decoupled code.

### Tech Stack
*   **Framework:** Flutter
*   **Language:** Dart
*   **State Management:** Riverpod (StateNotifier & Notifier)
*   **Database:** Hive (Local NoSQL) & Supabase (PostgreSQL Remote)
*   **DI:** GetIt & Injectable
*   **Navigation:** GoRouter
*   **Animations:** Flutter Animate & Loading Animation Widget
*   **Icons/Images:** Flutter SVG & Flutter Launcher Icons

---

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK (^3.11.4)
*   Dart SDK
*   A Supabase account and project setup.

### Setup
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/YoussefCodez/Sarf-App.git
    cd Sarf-App
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run code generation:**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Configure Supabase:**
    Create a `.env` file or update the `supabase_service.dart` with your `url` and `anonKey`.

5.  **Run the app:**
    ```bash
    flutter run
    ```

---

## 📱 Screenshots

<img width="1920" height="1080" alt="sarf1" src="https://github.com/user-attachments/assets/6ba25caf-d862-421c-b8d0-8ee7e4da7ae8" />
<img width="1920" height="1080" alt="sarf2" src="https://github.com/user-attachments/assets/d9fe86b2-c0f1-4771-bbbf-ae2f878ed6ec" />
<img width="1920" height="1080" alt="sarf3" src="https://github.com/user-attachments/assets/265216e2-5d0c-4ef1-ab82-517b9421dae1" />
<img width="1920" height="1080" alt="sarf4" src="https://github.com/user-attachments/assets/d6e95a65-e692-4f12-add3-a3d5b83fb833" />
<img width="1920" height="1080" alt="sarf5" src="https://github.com/user-attachments/assets/d25d00fe-db8b-464f-a839-0e9232a3f1d3" />
<img width="1920" height="1080" alt="sarf6" src="https://github.com/user-attachments/assets/8bb9f9e6-ba00-4d13-88c1-df6863b32c59" />
<img width="1920" height="1080" alt="sarf7" src="https://github.com/user-attachments/assets/94d41a7e-c71d-4084-a595-edbcfae4fe27" />


---

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

---

**Developed with ❤️ by [YoussefCodez](https://github.com/YoussefCodez)**
