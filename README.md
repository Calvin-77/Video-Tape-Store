# Video Tape Store

Video Tape Store is a cross-platform application for managing a video tape rental store. The project features a Flutter-based frontend for a modern, responsive user interface, and a Node.js/Express backend for managing store data and operations.

## Features

- Browse and search available video tapes
- Manage user accounts and rentals
- Add, edit, and delete video tape entries (admin)
- Store and display images for each video tape
- RESTful API backend for robust data management

## Project Structure

```
video_tape_store/       # Flutter frontend application
video_tape_store_be/    # Node.js/Express backend server
```

### Frontend (Flutter)

Located in `video_tape_store/`, the Flutter app provides a rich UI for users to interact with the video tape store. To get started:

1. Ensure you have [Flutter installed](https://docs.flutter.dev/get-started/install).
2. Run the app:
   ```bash
   cd video_tape_store
   flutter pub get
   flutter run
   ```

### Backend (Node.js/Express)

The backend server is under `video_tape_store_be/`. It manages the store’s data and exposes various API endpoints.

1. Install dependencies:
   ```bash
   cd video_tape_store_be
   npm install
   ```
2. Start the server:
   ```bash
   npm start
   ```
   By default, the server runs on port 3000.

## API Endpoints

Some key endpoints include:

- `POST /videos` — Add a new video tape
- `GET /videos` — List all video tapes
- `PUT /videos/update` — Update video tape information
- `DELETE /videos/delete` — Delete a video tape
- `GET /users` — Manage user accounts

See the source code in `video_tape_store_be/routes` for details.

## Database

The backend expects a relational database (e.g., MySQL) with a table named `videos`. Configure your database connection in the backend as needed.

## Getting Started

This project is an ideal starting point for learning Flutter and Express.js integration, or for building a rental management system.

### Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Express Documentation](https://expressjs.com/)

## License

This project is open source and available under the [MIT License](LICENSE).
