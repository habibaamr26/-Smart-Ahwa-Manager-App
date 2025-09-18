# ☕ Smart Ahwa Manager App

A simple Flutter application for managing coffee shop orders.  
It provides a **Dashboard**, **Add Order**, and **Analysis View** to manage daily sales and track popular items.



## ✨ Features
- ➕ **Add new orders** with customer details, selected drink, and special instructions.  
- 📋 **View pending orders** with the ability to mark them as *Completed*.  
- 📊 **Analytics**:
  - Total daily sales.  
  - Total number of orders.  
  - Most popular drinks (top-selling items).  
- ⚡ Simple and clean **Flutter UI** using `StatefulWidget`s.  

---

## 🧑‍💻 Tech Stack
- **Flutter (Dart)** → for UI development.  
- **OOP + SOLID Principles** → for clean, maintainable architecture.  
- **Repository Pattern** → to separate business logic and data layer from UI.  

---

## 🏗️ Project Structure

lib/
 ├── models/
 │    └── order.dart              # Order entity with encapsulation
 ├── repository/
 │    ├── repo_interface.dart # Abstract repository (interface)
 │    └── repository_impl.dart   # Concrete implementation (in-memory repo)
 ├── ui/
 │    ├── dashboard.dart          # Dashboard screen showing pending orders
 │    ├── add_order.dart          # Add new order screen (form)
 │    └── analysis_view.dart      # Analysis/Reports screen
 └── main.dart                    # App entry point




## 🧩 OOP & SOLID Principles in Action
- **Encapsulation** → `Order` class keeps fields private and exposes only necessary getters/setters.  
- **Abstraction** → `OrderRepository` is defined as an interface to hide implementation details.  
- **Polymorphism** → Any repository implementation (local memory, Firebase, API) can replace the current one without changing the UI.  
- **Single Responsibility Principle** → Each class focuses on one job (e.g., `Order` = model, `OrderRepository` = data manager, `Dashboard` = UI).  
- **Open/Closed Principle** → Extend functionality (new repositories or analytics) without modifying existing code.  

---

## 📖 Link to *The Object-Oriented Thought Process*
This project demonstrates:
- **Modularity** → UI, data, and business logic are separated.  
- **Abstraction** → Contracts/interfaces hide implementation details.  
- **Reusability & Scalability** → Different repository implementations can be swapped seamlessly.  

These principles ensure the app is **clean, maintainable, and scalable**, which is the essence of *The Object-Oriented Thought Process*.  

---

## 🚀 Getting Started
1. Clone the repo:  
   ```bash
   git clone https://github.com/your-username/smart-ahwa-manager.git
