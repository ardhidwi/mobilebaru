
# WorkWheels - Car Workshop Mobile App

## Overview
This cross-platform mobile application, built with Flutter, enables users to create and manage car service bookings for a car workshop. It includes user authentication, booking creation, and a calendar view, with role-based access for admins and mechanics.

## Features
1. **User Authentication**
   - Registration and login via email/password.
   - Role-based access control for Admin and Mechanic roles.
   - Authentication is managed through a custom FastAPI backend.

2. **Car Service Booking**
   - Admins can create bookings with:
     - Car details (Make, Model, Year, Registration Plate).
     - Customer information (Name, Phone Number, Email).
     - Booking title, Service duration
     - Mechanic assignment.
   - Bookings are stored in the FastAPI backend.

3. **Calendar View for Bookings**
   - Integrated calendar UI to display bookings daily, weekly, or monthly.
   - Admins can view all bookings; mechanics see only their assigned jobs.
   - Selecting a booking reveals additional details.

## Technical Specifications
- **Frontend**: Flutter (cross-platform support for Android and iOS)
- **Backend**: FastAPI with REST API communication
- **Database**: SQLite
- **Libraries Used**:
  - `http`: For API requests to FastAPI backend
  - `flutter_riverpod`: State management
  - `go-router`: Routing
  - Dependencies listed in `pubspec.yaml`

## Installation & Setup Guide

### Prerequisites
Ensure you have the following installed on your machine through following the step-by-step guide:
- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)

### 1. Clone the Repository
Open your terminal, navigate to the desired folder, and run:
```bash
git clone https://github.com/MrPengueeen/car_workshop_flutter.git
```
### 2. Navigate to The App Source Code Folder
```bash
cd car_workshop_flutter
```
### 3. Download Necessary Packages
```bash
flutter pub get packages
```
### 4. Run The Application
```bash
flutter run
```

## Install Release APK
For direction installation of the app without having to setup and build the project, a release build can be found here: `/release`