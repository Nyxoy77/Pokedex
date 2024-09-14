

---

# Pokedex App

The **Pokedex App** is a Flutter-based application that displays a list of Pokémon, along with detailed information sourced from the [PokeAPI](https://pokeapi.co/). The app supports dynamic loading of Pokémon data using pagination and allows users to mark their favorite Pokémon, which are prominently displayed at the top.

## Features

- **List of Pokémon**: Displays a complete list of Pokémon, fetched dynamically from the PokeAPI.
- **Pagination**: The app loads more Pokémon data as the user scrolls to the end of the list.
- **Favorite Pokémon**: Users can favorite any Pokémon, and their favorites will be shown at the top in a grid view.
- **Persistent State**: The app uses the **Shared Preferences** package to store the user's favorite Pokémon, ensuring that the favorites remain saved even when the app is closed and reopened.

## Technologies Used

- **Flutter**: For building the UI and overall app functionality.
- **PokeAPI**: For fetching Pokémon data (names, stats, types, etc.).
- **Shared Preferences**: For persisting the state of the favorite Pokémon across app sessions.
- **GridView**: For displaying the user's favorite Pokémon at the top.
- **ListView with Pagination**: To dynamically load and display more Pokémon data as the user scrolls.

## How It Works

1. **Dynamic Data Loading**: The app loads Pokémon data from PokeAPI in batches, ensuring a smooth and efficient user experience.
2. **Favoriting Pokémon**: Users can tap a Pokémon to mark it as a favorite. Favorited Pokémon are then displayed at the top of the screen.
3. **Persistent Favorites**: The app uses **Shared Preferences** to maintain the state of favorite Pokémon, meaning users' favorites will be restored whenever they open the app again.

## Installation

To run this app locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/Nyxoy77/Pokedex.git
   cd Pokedex
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app on a simulator or connected device:
   ```bash
   flutter run
   ```

## Screenshots

(Add screenshots of your app here)

## Future Improvements

- Adding search functionality to allow users to search for specific Pokémon by name.
- Implementing sorting options based on various Pokémon attributes (e.g., type, attack, defense).
- Offline support for viewing previously loaded Pokémon data.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

This README provides a good overview of your app and its core functionality! You can tweak it further to match your app's specific details.
