# Sovellukseni

## Description

Sovellukseni is a quiz application. Users can select topics, answer questions, and view their statistics. The application integrates with an API to fetch questions and submit answers, providing immediate feedback on the correctness of each answer. It also maintains a record of the user's correct answers using shared preferences.

## Key Challenges

1. **Handling Complex Data**
   - Managing and parsing JSON data from the API.
   - Ensuring the data is correctly mapped to the UI components.

2. **Context/State Management**
   - Efficiently managing state with Riverpod to ensure a responsive UI.
   - Handling asynchronous operations and updating the state accordingly.

3. **The Scope/Size of the Project**
   - Structuring the project to keep the codebase maintainable.

## Dependencies

The list of dependencies used in this project and their versions:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  go_router: ^14.2.0
  http: ^1.2.1
  shared_preferences: ^2.2.3
