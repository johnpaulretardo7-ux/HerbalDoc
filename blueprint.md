# Herbal Remedies App Blueprint

## Overview

This document outlines the blueprint for a Flutter application designed to provide information about Filipino herbal remedies. The app will feature a searchable and filterable list of herbs, with details on their uses, preparation, and other relevant facts.

## Style and Design

*   **Theme:** The app will use a modern, clean, and nature-inspired theme.
    *   **Color Palette:** A calming palette of greens, browns, and whites will be used to evoke a natural feel.
    *   **Typography:** The `google_fonts` package will be used to implement a readable and elegant font scheme. `Roboto` will be used for body text, and a more stylized font like `Merriweather` for headings.
*   **Layout:**
    *   **Home Screen:** A grid-based layout will display a list of herbs with their images and names. A search bar at the top will allow users to quickly find specific herbs.
    *   **Detail Screen:** Tapping on an herb will navigate to a detail screen with a larger image, scientific name, uses, preparation instructions, and other facts.
*   **Components:**
    *   **App Bar:** A custom-themed app bar will display the app's title.
    *   **Cards:** Each herb will be displayed in a `Card` widget with a subtle shadow and rounded corners.
    *   **Search Bar:** A `TextField` with an icon will be used for the search functionality.

## Features

*   **Herb Database:** The app will use a local JSON file (`herbs.json`) to store the herb data. This allows for easy updates and offline access.
*   **Search Functionality:** Users can search for herbs by their common name or uses.
*   **Detailed Information:** The app provides detailed information for each herb, including its scientific name, parts used, facts, preparation, and uses.
*   **Image Placeholders:** The app uses placeholder images for each herb, which can be replaced with actual images.
*   **Responsive Design:** The app will be designed to work well on both mobile and web platforms.
*   **My List (Favorites):**
    *   Users can mark herbs as favorites.
    *   A dedicated "My List" screen will display all favorite herbs.
    *   Favorites are saved on the device for persistence between sessions.

## Plan for Current Request

The user has requested to add a "My List" feature to the app, allowing them to save their favorite herbs.

1.  **Add Dependencies:** Add `provider` for state management and `shared_preferences` for local storage.
2.  **Create `FavoriteProvider`:** Implement a provider to manage the list of favorite herbs, including logic to add, remove, and load favorites from `shared_preferences`.
3.  **Create `FavoritesScreen`:** Build a new screen to display the list of favorite herbs.
4.  **Implement Navigation:** Create a bottom navigation bar to switch between the Home screen and the Favorites screen.
5.  **Update UI:**
    *   Add a "favorite" icon button to the `HerbCard` widget.
    *   Add a "favorite" icon button to the `HerbDetailScreen`.
6.  **Modify `main.dart`:** Wrap the app with the `FavoriteProvider` and set up the main navigation.
