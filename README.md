# Crayon Management

The lecture giver will use the crayon management application. Presentation of PDFs and starting quizzes during a lecture will be available in this application.


## Table of contents
* [Screenshots](#screenshots)
* [General info](#general-info)
* [Requirements](#requirements)
* [Technologies](#technologies)
* [Output](#output)
* [Setup](#setup)


## Screenshots
![](preview/login_dark.png?v=4&s=200)
![](preview/dashboard_dark.png?v=4&s=200)
![](preview/start_quiz_hell.png?v=4&s=200)
![](preview/presentation.png?v=4&s=200)
## General info

This program is fully functional and uses Firebase as a backend. The key functionalities of the Crayon Management application are:
* [Lectures]
* [Presentation]
* [Questions]
* [Quizzes]
The lectures must be created to access the other functionalities of the application! The presentation mode allows showing the lecture slides to the students. These slides must be in PDF format and must be uploaded to the system before use. As shown in [], the system notifies if a student asked a question over the Crayon student application on the presentation mode screen. In addition, this screen also allows to draw over the presentation content as shown in []. This allows explaining a specific slide further.

Moreover, the Crayon Management system also allows starting quizzes. These quizzes must be previously created in the system. A quiz is composed of one or more questions. To start a quiz, as shown in the illustration []  is multiple step process 


## Requirements
The application 100% works for the newest browser. This application can also be built as executable. However, the executables setup requires setting the respective Firebase credentials again.
The Supported browsers are:
* [Microsoft Edge]
* [Google Chrome]
* [Mozilla Firefox]

## Technologies

The code is written in plain Dart and uses the Framework Flutter.


## Setup
Download the project and open it in your favourite IDE. You are required to start the webpage on a server if you are using Visual Studio Code you can quickly launch it in a live server width the command flutter run -d chrome.
