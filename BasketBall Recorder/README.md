# BasketBall Recorder

# Basketball Points Recorder

A simple Flutter application to record and display basketball points for two teams: Team A and Team B. The app provides a user-friendly interface with options to increment the points for each team by 1, 2, or 3 points. The app also features a vertical divider to visually separate the two teams.

## Features

- **Score Display**: Shows the current score for both teams in a large, easy-to-read font.
- **Increment Points**: Allows incrementing the score of each team by 1, 2, or 3 points using `ListTile` widgets.
- **Vertical Divider**: Visually separates the score displays and controls for each team.
- **Responsive UI**: The interface adjusts to different screen sizes and orientations.
![WhatsApp Image 2024-06-30 at 20 35 04_33cb9544](https://github.com/EngMahmoudMaher/flutter-course-tasks/assets/173734058/616ee3d9-c49d-49b2-a94b-a56b95c76617)



## Usage

- **Incrementing Points**: Tap on the `ListTile` for "Add 1 Point", "Add 2 Points", or "Add 3 Points" to increment the respective team's score.
- **Team A and Team B**: Each team has its own column with the team name, current score, and point increment options.
- **Resetting Scores**: Restarting the app will reset the scores to 0.

## Layout

- **AppBar**: Displays the title of the app.
- **Row**: Contains two columns, one for each team.
- **Column**: Displays the team name, current score, and `ListTile` widgets for incrementing the score.
- **VerticalDivider**: Separates the columns for Team A and Team B.

## Customization

- **Colors**: The colors for the `ListTile` widgets can be customized to suit your preferences.
- **Font**: The font style for the text can be changed to any preferred font by updating the `TextStyle` properties.

## Contributing

If you'd like to contribute to this project, please fork the repository and use a feature branch. Pull requests are welcome.

## License

This project is licensed under the MIT License.
