
# HerbalDoc App Blueprint

## **Project Overview**

Ang HerbalDoc ay isang mobile application na naglalayong magbigay ng impormasyon tungkol sa mga halamang gamot. Ang mga user ay maaaring mag-browse ng listahan ng mga halaman, maghanap ng mga partikular na halaman, at i-save ang kanilang mga paboritong halaman para sa madaling pag-access.

## **Core Features & Design**

### **1. Architecture & State Management**
*   **Provider:** Ginagamit para sa state management, na nagbibigay-daan para sa mahusay na pamamahala ng data sa buong app.
*   **Service/Repository Pattern:** Ang `HerbsProvider` ay kumukuha ng data mula sa isang local JSON file, na naghihiwalay sa data layer mula sa UI.
*   **Model-View-ViewModel (MVVM) like architecture:** Hinihiwalay ang UI (Views) sa business logic (Providers/ViewModels).

### **2. User Interface (UI) & User Experience (UX)**
*   **Animated Splash Screen:** Isang loading screen na may fade-in animation at custom na icon na ipinapakita sa pagbukas ng app.
*   **Immersive Detail Screen:** Ang `HerbDetailScreen` ay gumagamit ng `CustomScrollView` at `SliverAppBar` para sa isang immersive na karanasan, kung saan ang imahe ng halaman ay nagiging bahagi ng app bar.
*   **Modern & Clean Design:** Ang app ay gumagamit ng malinis na layout, modernong mga component, at magandang visual hierarchy.
*   **Floating Action Button (FAB):** Ang "favorite" button ay isang `FloatingActionButton` para sa madaling pag-access.
*   **Custom Fonts (Google Fonts):** Gumagamit ng `google_fonts` para sa mas magandang typography.
*   **Responsive Layout:** Ang UI ay umaangkop sa iba't ibang laki ng screen, na tinitiyak ang magandang karanasan sa parehong mobile at web.
*   **Featured Herb:** Ang `HomeScreen` ay nagha-highlight ng isang "Featured Herb" para sa mas magandang user engagement.

### **3. Key Features**
*   **Herb List & Details:**
    *   Nagpapakita ng listahan ng mga halaman sa isang `GridView`.
    *   Ang pag-tap sa isang halaman ay nagpapakita ng detalyadong screen na may impormasyon tungkol sa halaman.
*   **Search Functionality:**
    *   Ang mga user ay maaaring maghanap ng mga halaman ayon sa pangalan, siyentipikong pangalan, o gamit.
*   **Favorites System:**
    *   Ang mga user ay maaaring magdagdag o mag-alis ng mga halaman sa kanilang "My List" (favorites).
    *   Ang mga paboritong halaman ay naka-save sa device gamit ang `shared_preferences`.
*   **User Notes:**
    *   Ang mga user ay maaaring magdagdag, mag-edit, at mag-delete ng kanilang sariling mga personal na tala sa bawat halaman.
    *   Ang mga tala ay naka-save sa isang local na SQLite database gamit ang `sqflite`.
*   **About Screen & Theme Toggle:** 
    *   Nagbibigay ng impormasyon tungkol sa app at naglalaman ng toggle para sa Dark/Light mode.

## **Development Plan**

### **Completed**
*   **Phase 1: UI/UX Enhancement & Theming**
    *   **Goal:** Pagandahin ang visual na anyo at karanasan ng app.
    *   **Steps Completed:**
        1.  **I-update ang `HomeScreen` UI:** Nagdagdag ng welcome header, "Featured Herb" card, at na-modernize ang search bar.
        2.  **Ipatupad ang Material 3 Theming:** Gumawa ng isang sentralisadong `ThemeData` para sa light/dark modes gamit ang `ColorScheme.fromSeed`.
        3.  **Refactor Code:** Inilipat ang `_buildFeaturedHerbCard` sa isang hiwalay na widget file.
        4.  **Palitan ang Settings ng About:** Pinalitan ang `SettingsScreen` ng `AboutScreen`, inilipat ang theme toggle, at idinagdag ang impormasyon ng app.
        5.  **Idagdag ang Splash Screen:** Gumawa ng loading screen na ipinapakita sa simula ng app.
        6.  **Pagandahin ang Splash Screen:** Pinalitan ang icon, idinagdag ang bagong imahe, at naglagay ng fade-in animation para sa mas modernong hitsura.
*   **Phase 2: Offline-First Features**
    *   **Goal:** Palakasin ang offline capabilities ng app.
    *   **Steps Completed:**
        1.  **Ipatupad ang User Notes:** Nagdagdag ng feature para makapag-imbak ng personal na mga tala ang mga user para sa bawat halaman gamit ang `sqflite`.

### **Current Plan**
*   **Phase 3: Advanced Features**
    *   **Goal:** Magdagdag ng mga advanced na feature para mapabuti ang user experience.
    *   **Potential Features:**
        *   **Reminders/Notifications:** Payagan ang mga user na mag-set ng mga paalala para sa paggamit ng mga halaman.
