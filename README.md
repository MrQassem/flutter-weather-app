# Flutter Weather App

A weather app that shows the usage of external APIs and the usage of google maps inside a flutter project. It has the feature of getting weather information from any place in the world by picking the place from google map.

## Getting Started

1. Add Google Maps API key for android application inside AndroidManifest file
    > To create new API keys, follow the instructions in the link
    [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
    ```bash
    # rename file to have .xml extension
    .\android\app\src\main\AndroidManifest.xml.example
    ```
1. Add Google Maps API key for ios application
    ```bash
    # rename file to have .swift extension
    .\ios\Runner\AppDelegate.swift.example
    ```
1. Run the command to install all dependencies
    > flutter pub get

1. Run the project in an emulator.