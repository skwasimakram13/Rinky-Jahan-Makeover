# Rinky Jahan Makeover

Welcome to the **Rinky Jahan Makeover** project repository! This is a full-stack solution designed for a salon and makeover service platform. The platform allows users to browse services/products, book appointments with stylists, and manage their profile, while an admin interface allows the business to manage operations.

## 🚀 Tech Stack

### Frontend (User & Admin App)
- **Framework:** Flutter (^3.5.4)
- **State Management:** Riverpod (`flutter_riverpod`)
- **Routing:** GoRouter
- **Networking:** Dio
- **Local Storage:** Shared Preferences
- **UI:** Custom Material Theme, Google Fonts, Cupertino Icons

### Backend (REST API)
- **Runtime:** Node.js, TypeScript
- **Framework:** Express.js
- **Database / BaaS:** Supabase (PostgreSQL)
- **Authentication / Notifications:** Firebase Admin
- **Payments Integration:** Razorpay
- **Other Tools:** CORS, Dotenv, Axios

---

## 📁 Repository Structure

```text
Rinky Jahan Makeover/
├── rinky_jahan_app/          # Flutter Frontend Application
│   ├── lib/                  # Dart source code
│   │   ├── core/             # Themes, Routing (GoRouter), API clients
│   │   ├── features/         # Feature modules (Auth, Services, Shop, Bookings)
│   │   └── shared/           # Shared UI widgets and utilities
│   ├── pubspec.yaml          # Flutter dependencies
│   └── ...
│
├── rinky_jahan_backend/      # Node.js + Express Backend API
│   ├── src/                  # TypeScript source code
│   │   ├── config/           # Firebase/Supabase/DB setups
│   │   ├── controllers/      # Route controllers definition
│   │   ├── middlewares/      # Express middlewares (Auth, Error handling)
│   │   ├── models/           # Data models/interfaces
│   │   ├── routes/           # API routes (Auth, Catalog, Bookings, Admin)
│   │   ├── services/         # Business logic & 3rd party integrations
│   │   └── index.ts          # Express App Entry Point
│   ├── schema.sql            # PostgreSQL Database Schema
│   ├── .env.example          # Example environment block
│   ├── package.json          # Node dependencies & scripts
│   └── tsconfig.json         # TypeScript configuration
```

---

## ✨ Features

- **User Authentication:** Sign up and login via Firebase/Supabase.
- **Service Catalog:** View categories for bridal, facial, hair styling, etc.
- **Product Shop (E-Commerce):** Browse skincare and makeup products.
- **Appointment Booking:** Select stylists, pick available time slots, and confirm bookings.
- **Payments:** Secure payment gateway integration using Razorpay for bookings and orders.
- **Admin Dashboard (API):** Manage users, catalog items, bookings, and monitor payments.

---

## 🛠️ Prerequisites

Before you begin, ensure you have met the following requirements:
- **Node.js** (v18.x or later) & **npm** installed.
- **Flutter SDK** (^3.5.4) installed.
- Valid **Supabase** account and project setup.
- Valid **Razorpay** account with API credentials.
- Valid **Firebase** project for admin controls.

---

## ⚙️ Backend Setup (`rinky_jahan_backend`)

1. **Navigate to the backend directory:**
   ```bash
   cd rinky_jahan_backend
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Configure Environment Variables:**
   Create a `.env` file in the root of the backend directory. You will need to populate it with your actual service credentials.
   ```env
   PORT=3000

   # Supabase Settings
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key

   # Razorpay Settings
   RAZORPAY_KEY_ID=your_razorpay_key_id
   RAZORPAY_KEY_SECRET=your_razorpay_key_secret

   # Firebase Admin Settings
   FIREBASE_PROJECT_ID=your_project_id
   FIREBASE_CLIENT_EMAIL=your_client_email
   FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYourPrivateKeyHere\n-----END PRIVATE KEY-----\n"

   # MSG91 Settings (SMS/OTP)
   MSG91_AUTH_KEY=your_msg91_auth_key
   MSG91_TEMPLATE_ID=your_msg91_template_id
   ```

4. **Initialize the Database:**
   Run the `schema.sql` script inside your Supabase SQL Editor to generate the required tables:
   - `users`, `services`, `products`, `stylists`, `bookings`, `orders`, `order_items`

5. **Start the Development Server:**
   ```bash
   npm run dev
   ```
   *The server will run on `http://localhost:3000` (or your defined PORT).*

6. **Build for Production:**
   ```bash
   npm run build
   npm start
   ```

---

## 📱 Frontend Setup (`rinky_jahan_app`)

1. **Navigate to the frontend directory:**
   ```bash
   cd rinky_jahan_app
   ```

2. **Get Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure the API Endpoint:**
   Inside `lib/core/` (or your endpoint configuration file), ensure the backend base URL correctly points to your running backend server (e.g., `http://10.0.2.2:3000` for Android emulator or your live production URL).

4. **Run the Application:**
   ```bash
   flutter run
   ```

---

## 🏗️ Architecture Diagram

```mermaid
graph TD
    Client[User App - Flutter] -->|REST API| Backend[Node.js Express API]
    Admin[Admin App - Flutter] -->|REST API| Backend
    Backend -->|Authentication & Notifications| Firebase[Firebase Admin]
    Backend -->|Payments| Razorpay[Razorpay Gateway]
    Backend -->|Data Storage| DB[(Supabase PostgreSQL)]
```

---

## 📸 Screenshots

*(Screenshots of the application will upload here)*

---

## 📡 API Endpoints Documentation

### **Auth Routes (`/api/auth`)**
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/send-otp` | Sends an OTP to the user's phone number |
| POST | `/verify-otp` | Verifies the OTP and returns an authentication token |

### **Catalog Routes (`/api/catalog`)**
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/services` | Retrieves all available salon services |
| GET | `/products` | Retrieves all e-commerce products for sale |
| GET | `/stylists` | Retrieves a list of all salon stylists |

### **Bookings Routes (`/api/bookings`)**
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/` | Creates a new user appointment booking |
| GET | `/user/:user_id` | Fetches all bookings belonging to a specific user |
| PATCH | `/:id/status` | Updates the status of a specific booking (e.g., confirmed, completed) |

### **Admin Routes (`/api/admin`)**
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/bookings` | Retrieves all bookings across the platform for the admin |
| POST | `/bookings` | Allows an admin to manually create an offline booking |

---

## 📦 Building the App (Production)

### Build Android APK

To generate a release APK for Android devices:

```bash
cd rinky_jahan_app
flutter build apk --release
```
The generated APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

*Alternatively, to build an App Bundle (recommended for Google Play Store):*
```bash
flutter build appbundle --release
```

### Build iOS IPA

To generate an IPA for iOS devices (Requires macOS and Xcode):

```bash
cd rinky_jahan_app
flutter build ipa --release
```
Follow the instructions in the terminal to upload to TestFlight or the App Store using Xcode.

---

## 🤝 Contribution Guidelines

1. **Branching Strategy:** Use feature branches (`feature/your-feature-name`) instead of committing directly to `main` or `master`.
2. **Code Style:** 
   - Backend: Follow TypeScript strong typing conventions.
   - Frontend: Use `flutter analyze` and follow standard Riverpod architectural patterns.
3. **Pull Requests:** Ensure your code is thoroughly tested before submitting a PR.

---

# License & Contact
- MIT License — you may use and modify the code for your organization. Include attribution if you redistribute.
- For commercial / closed-source product consider proprietary license.

**Contact**: Project owner / maintainer - wasim@demoody.com

---

## Author
**Develope By** - [Sk Wasim Akram](https://github.com/skwasimakram13)

- 👨‍💻 All of my projects are available at [https://skwasimakram.com](https://skwasimakram.com)

- 📝 I regularly write articles on [https://blog.skwasimakram.com](https://blog.skwasimakram.com)

- 📫 How to reach me **hello@skwasimakram.com**

- 🧑‍💻 Google Developer Profile [https://g.dev/skwasimakram](https://g.dev/skwasimakram)

- 📲 LinkedIn [https://www.linkedin.com/in/sk-wasim-akram](https://www.linkedin.com/in/sk-wasim-akram)

---

💡 *Built with ❤️ and creativity by Wassu.*

---


