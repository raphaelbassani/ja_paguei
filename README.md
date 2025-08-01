# 💸 Already paid (Já paguei 🇧🇷) – A Simple Flutter App to Manage Monthly Payments

This Flutter app helps users **manually track and manage their monthly bills** by storing important payment information, alerting them to upcoming due dates, and providing a clean history and balance visualization.

The idea came from a need I encountered in my daily life — I always needed a simple app to manage my bills, but the available apps were too complex to do so. As a result, I ended up using to-do list apps for this purpose, which was quite a manual process, and not made for it.

> ⚠️ Note: This app **does not connect to banks** or process real payments. It is purely for personal financial tracking.
> 🌎 App compatible languages: 🇺🇸 English 🇺🇸 ; 🇧🇷 Portuguese 🇧🇷 

---

## 📱 Features

- Add and manage monthly bills
- Mark bills as **paid**, with optional value updates for variable bills
- View bill list sorted by **due date**
- Assign different **payment methods** (BankSlip, Debit, Money, etc.)
- Track bill **status**: Pending, Paid, or Overdue
- View **payment history**
- See a **bar chart** of total expenses over the past 6 months
- Tell me a joke (funny feature of the app)

---

## 📸 Screenshots

> Add your own screenshots in this section using markdown image links.

<!-- Example: -->
<!-- ![Bill List](screenshots/bill_list.png) -->
<!-- ![Add Bill](screenshots/add_bill.png) -->
<!-- ![Chart](screenshots/expenses_chart.png) -->

---

## 🧱 Tech Stack

- **Flutter** – Cross-platform UI (Initially developed in Flutter 3.32.7)
- **Local data persistence** – sqlite, path
- **State Management:** - provider
- **Date and currency formatting** - intl, currency_text_input_formatter
- **Bar charts** - fl_chart
- **For light storage needs** - shared_preferences
- **Localizations** - flutter_localizations
- **Http** - dio, dart_either
- **Unit testing** - equatable
- **Other visual libs** - stylish_bottom_bar, table_calendar, top_snackbar_flutter, modal_bottom_sheet, lottie, loader_overlay

---

## 📁 Folder Structure
lib/
├── core/ # constants, extensions, ui
├── data/ # datasources (remote and local), errors, models, services
├── presentation/
│ ├── pages/ # screens
│ ├── widgets/ # reusable internal UI components
│ └── enums/ # status and models enums
│ └── routes/ # page routes for navigation 
│ └── state/ # view_models 
└── l10n/ # localization files, keys and values

---

## 🚀 Getting Started

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/ja_paguei.git
   cd ja_paguei
   
2. **Install dependencies:**
   
   ```bash
   flutter pub get
   
2. **Run the app:**
   
   ```bash
   flutter run

---

## 🔐 Privacy & Security
All data is stored locally on the user’s device.
No data is shared, uploaded, or monetized.

---

## 📄 License
This project is open-source and available under the MIT License.

---

## 🙌 Contributing
Contributions are welcome! Feel free to fork this repo and submit a pull request.

---

## 📬 Contact
Created by Raphael Bassani
Feel free to reach out on LinkedIn or open an issue. 
https://www.linkedin.com/in/raphaelbassani/


