# Crayon Management

The lecture giver will use the crayon management application. Presentation of PDFs and starting quizzes during a lecture will be available in this application.


## Table of contents
* [Screenshots](#screenshots)
* [General info](#general-info)
* [Requirements](#requirements)
* [Technologies](#technologies)
* [Setup](#setup)


## Screenshots


Login            |  Dashboard
:-------------------------:|:-------------------------:
![login](preview/login_dark.png?raw=true)  |  ![dashboard](preview/dashboard_dark.png?raw=true)


Quiz Process            |  Presentation
:-------------------------:|:-------------------------:
![start-quiz](preview/start_quiz_hell.png?raw=true)  |  ![presentaiton](preview/presentation.png?raw=true)

## General info

This program is fully functional and uses Firebase as a backend. The key functionalities of the Crayon Management application are:
* Lectures
* Presentation
* Questions
* Quizzes


The lectures must be created to access the other functionalities of the application! The presentation mode allows showing the lecture slides to the students. These slides must be in PDF format and must be uploaded to the system before use. As shown in [Presentation] with a yellow icon in the bottom left corner, the system notifies if a student asked a question over the Crayon student application on the presentation mode screen. In addition, this screen also allows to draw over the presentation content as shown in [Presentation]. This allows explaining a specific slide further.

Moreover, the Crayon Management system also allows starting quizzes. These quizzes must be previously created in the system. A quiz is composed of one or more questions. To start a quiz, as shown in the illustration [Quiz Process]  is multiple step process:

* Select quiz
* Time
* Lobby
* Timer
* Results
* Explenation

First of all, the lecture giver requires to select the quiz, and in the second step is necessary to pick the time for a quiz. By default, this time is 100 seconds. After choosing the quiz, the teacher can open the lobby. Therefore a notification is sent to the  Crayon student application that a quiz was started for a specific lecture. The student requires then to join the lobby, which then shows the username of the joined students in the lobby. As soon as the teacher decides to start the quiz, each student who joined the quiz gets set into the quiz mode of the Crayon student application, and the teacher gets redirected into the timer screen. The timer screen is a simple countdown of the selected time set by the teacher. Moreover, after the time has elapsed, the top 5 students of the quiz will be displayed with their final score. Finally, the last step is the quiz explanation screen which allows to explain each question individually and shows how many students got the question right or wrong. 


## Requirements
The application 100% works for the newest browser. This application can also be built as executable. However, the executables setup requires setting the respective Firebase credentials again.
The Supported browsers are:
* Microsoft Edge
* Google Chrome
* Mozilla Firefox

## Technologies

The code is written in plain Dart and uses the Framework Flutter.


## Setup
Download the project and open it in your favourite IDE. You are required to start the webpage on a server if you are using Visual Studio Code you can quickly launch it in a live server width the command flutter run -d chrome.


## Additional Screenshots
To see additional screenshots of the Crayon Management application and Crayon Student application the following webpage provides this:
[Crayon](https://schroederlionel.github.io/crayon/)
