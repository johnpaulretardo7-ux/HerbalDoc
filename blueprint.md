# HerbalDoc App Blueprint

## Overview

HerbalDoc is a complete offline mobile application for Flutter that serves as a Filipino Herbal Guide. The app provides users with a quick and easy way to access information about various local medicinal herbs. With the new symptom-based search, users can find remedies even if they don't know the name of the herb. All data is stored locally, making the app 100% functional without an internet connection. The app also allows users to create a personal list of their favorite herbs.

## Current Status

The application is fully functional. The search functionality has been upgraded to support symptom-based queries, and users can now manage a list of their favorite herbs.

## Features & Design

### Core Features:

- **Offline Data:** All herb information is loaded from a local `herbs.json` file.
- **Symptom-Based Search:** A smart search bar on the home screen allows users to filter herbs by name, scientific name, facts, preparation, or by symptom (e.g., searching for "ubo" will show all herbs used for cough).
- **Splash Screen:** A clean introductory screen.
- **Home Page (Grid View):** Displays a grid of available herbs.
- **Herb Details Page:** Provides a detailed view of the selected herb, including:
    - Scientific Name
    - Interesting Facts
    - Preparation Instructions
    - Uses (displayed as interactive chips)
- **My List:** Users can add or remove herbs from a personal "My List" of favorites.

### Navigation Flow:

1.  **Splash Screen** (Initial launch)
2.  **Home Page** (Displays the herb grid with a symptom-based search bar)
3.  **Herb Details Page** (Shows complete information for a selected herb)
4.  **My List** (Accessible via the bottom navigation bar, displays a list of favorite herbs)

### Design Principles:

- **Theme:** A clean, nature-inspired, and minimalist user interface.
- **Color Palette:** Green and white shades to evoke nature and health.
- **Typography:** Clean and readable text using the `google_fonts` package.
- **Layout:** A responsive grid layout for browsing and a clear, scrollable layout for details.

---

## Project Structure

```
/lib
  /models
    - herb.dart
  /providers
    - favorite_provider.dart
  /screens
    - splash_screen.dart
    - home_screen.dart
    - herb_detail_screen.dart
    - favorites_screen.dart
  /widgets
    - herb_card.dart
    - bottom_nav_handler.dart
  - main.dart

/assets
  /data
    - herbs.json
  /images
    - [herb_images.png]

/pubspec.yaml
```

## Completed Steps

1.  **Setup Project Structure:** Created the necessary folders and files.
2.  **Define Data Model:** Created the `Herb` class.
3.  **Implement `pubspec.yaml`:** Added dependencies and declared assets.
4.  **Create Screens & Widgets:** Built the initial UI for all screens.
5.  **Set Up `main.dart`:** Configured the app's theme and routing.
6.  **Added Search Bar:** Implemented a basic search bar.
7.  **Upgraded to Symptom-Based Search:** 
    - Updated the `herbs.json` file to include a `uses` array for each herb.
    - Modified the `Herb` data model to match the new JSON structure.
    - Implemented the advanced search logic in `home_screen.dart` to search across multiple fields, including the `uses` array.
    - Updated the `herb_detail_screen.dart` to display the uses as chips.
8.  **Implemented "My List" Feature:**
    - Added the `provider` package for state management.
    - Created a `FavoriteProvider` to manage the list of favorite herbs.
    - Integrated the `FavoriteProvider` into the app.
    - Added a "favorite" button to the `HerbDetailScreen` to add/remove herbs.
    - Created a `FavoritesScreen` to display the list of favorite herbs.
    - Updated the `BottomNavHandler` to include the `FavoritesScreen`.
9.  **Fixed "My List" Bug:**
    - Resolved an issue where favorited herbs were not appearing in the "My List" screen.
    - Overrode the `==` operator and `hashCode` in the `Herb` model to ensure correct object comparison.
10. **Code Cleanup:**
    - Removed an unused import from `lib/models/herb.dart`.