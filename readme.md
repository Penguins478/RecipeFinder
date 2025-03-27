# Recipe Finder

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

This app helps users discover recipes based on ingredients they already have, dietary needs, cuisine preferences, or time available. Encourages home cooking and reduces food waste. It adds a little fun to cooking as well as you don't know what recipe you're gonna get as well.

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Food & Drink
- **Mobile:** Mobile is essential for on-the-go recipe lookup, kitchen use while cooking. Could possibly have notifications for daily mail ideas. Theoretically, one could also use the camera and scan a food item to make sure its including in the recipe. 
- **Story:** Solves the question of "what should I cook/eat today?" problem. Allows users to explore new meals quickly and it encourages creativity, exploration, and possibly healthier eating habits.
- **Market:** The market is huge and for anyone who cooks at home including college students, parents, etc.  
- **Habit:** We could make it a habit for users to check the app by having daily suggestions via push notifications, favorite recipes saved and re-used, along with weekly cooking goals/challenges. Essentially, it could be used multiple times per week, especially at mealtimes.
- **Scope:** It would be very technically challenging to complete this app but a stripped down version would still be interesting to make. We could make it where a user is recommended a random recipe and they can ask for a new one or favorite the recipe. There could be two modes where the user can ask for a random recipe (not including their favorites) or just filter it down to their favorites. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* I want to be able to generate any random recipe
* I want to be able to mark if I have completed a recipe
* I want to be able to "favorite" recipes
* I want to be able to switch to generating recipes only from the "favorited" list
* I want to be able set goals for completing a number of recipes
* I want to be able to reset the count for number of recipes completed
* I want to be able to view a full recipe with all its details
* I want to be able to view a whole list of all my "favorited" recipes
* I want a congratulations page for when I complete my goal

**Optional Nice-to-have Stories**

* I want to be able to view a picture of what the food is supposed to look like
* I want to be able to filter the generated recipes by a category
* I want to be able to filter the generated recipes by the main ingredient

### 2. Screen Archetypes

Home Page
* **I want to be able to generate any random recipe**
* **I want to be able to mark if I have completed a recipe**
* **I want to be able to favorite recipes**
* I want to be able to view a picture of what the food is supposed to look like

Full Recipe
* **I want to be able to view a full recipe with all its details**


Favorites
* **I want to be able to view a full recipe with all its details**
* I want to be able to view a picture of what the food is supposed to look like


Settings
* **I want to be able to switch to generating recipes only from the "favorited" list**
* **I want to be able set goals for completing a number of recipes**
* **I want to be able to reset the count for number of recipes completed**
* I want to be able to filter the generated recipes by a category
* I want to be able to filter the generated recipes by the main ingredient


Congratulations 
* **I want a congratulations page for when I complete my set goal**

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Page
* Favorites
* Settings

**Flow Navigation** (Screen to Screen)

Home Page
* => Full Recipe (by clicking the info icon)
* => Favorites (from the tab navigation)
* => Settings (from the tab navigation)


Full Recipe
* => Home Page (by clicking the back arrow)
* => Favorites (by clicking the back arrow)


Favorites
* => Full Recipe (by cliking on the info icon)
* => Home (from the tab navigation)
* => Settings (from the tab navigation)


Settings
* => Home (from the tab navigation)
* => Favorites (from the tab navigation)


Congratulations
* => Home (from the tab navigation / back arrow)
* * => Full Recipes (back arrow)
* => Favorites (from the tab navigation / back arrow)

**Back arrow navigation depends on previous screen**

## Wireframes

![NBMetadataCache](https://hackmd.io/_uploads/rk9dBfMTJx.jpg)


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

### Sprints

## Sprint 1: Project Setup + Random Recipe Generator

**Goals:**
- Build all 3 screens (not all the UI though) along with the nav bar. 
- Integrate basic mock data.
- Build basic Home Screen layout.
- Display a random recipe (title, ingredients, steps, etc... details the API gives us).
- Add "Generate New Recipe" button.

**SMART Goals:**
- Working Home Screen that shows a random recipe.
- Display at least 3 recipe fields.

---

## Sprint 2: Home Screen + Full Recipe View

**Goals:**
- Implement full Home Screen functionality:
  - Generate random recipes.
  - Mark recipes as complete.
  - Favorite recipes.
- Create Full Recipe screen for detailed viewing.
- Enable navigation from Home ➝ Full Recipe and back.

**SMART Goals:**
- Full recipe view includes picture, ingredients, and instructions.
- Favorite and complete buttons functional (local state).
- Complete navigation flow between Home and Full Recipe.

---

## Sprint 3: Favorites + Settings

**Goals:**
- Build the Favorites screen:
  - List all favorited recipes.
  - Navigate to Full Recipe view.
- Build the Settings screen:
  - Toggle recipe generation between all vs. favorites-only.
  - Set/reset goals for completed recipes.
  - Track completed recipe count.

**SMART Goals:**
- Settings reflect user preferences and update app behavior.
- Favorite mode toggle works.
- Users can view, favorite, and navigate all saved recipes.

---

## Sprint 4: Persistence + Goal Completion

**Goals:**
- Add local data persistence:
  - Store favorites, completed count, and goal values.
- Display Congratulations screen once recipe goal is reached.
- Polish UI, finalize all navigation routes, squash bugs.

**SMART Goals:**
- Favorites and completed count persist across app sessions.
- Congrats screen appears upon reaching goal.
- Record a working demo and complete all unit submission requirements.
