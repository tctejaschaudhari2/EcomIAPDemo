# EcomIAPDemo

# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Architecture](#architecture)
4. [Structure](#structure)
5. [Designs](#designs)
6. [Dependencies](#dependencies)
7. [API](#api)


# Description
<p>EcomIAPDemo take home assignement is completed using UIKit<br>

# Getting started
<p>
1. Make sure you have the Xcode version 12.0 or above installed on your computer.<br>
2. Minimum iOS target: 15.0.<br>
3. Clone the Project from the given repository [link](https://github.com/tctejaschaudhari2/EcomIAPDemo) <br>
4. No need to run pod install as dependencies are added by SPM<br>
5. Open the EcomIAPDemo.xcodeproj in Xcode.<br>
6. Run the active scheme.<br>
7. You should see Product List on top of the screen.<br>
8. You can buy the product by clicking the card which opens new screen.<br>
9. On clicking 'Buy This Product' we are able to buy using In-App Purchase. <br>
10.EcomIAPDemo uses Configuration.storekit file to handle In-App Purchase, which is testable on Simulator <br>

# Architecture
* EcomIAPDemo project is implemented using the <strong>Model-View-ViewModel (MVVM)</strong> architecture pattern.
* EcomIAPDemo project is implemented using the <strong>Closure Pattern</strong>.
* UIKit is used and has necessary design for the UI.
* ViewModel has any necessary data or business logic needed to generate the EcomIAPDemo on Listing Page.
* View is responsible for displaying EcomIAPDemo on ViewController Class.
* Model is available, whenever ViewModel sends new updates.<br><br>


# Structure 
* "Home": The source code files for a specific module. Files within a module folder are organized into subfolders, such as "Views" or "Models".
* "APIServices": Files or classes related to communicating with an external API. This could include code for making HTTP requests to a web server, parsing responses, and handling any errors that may occur.
* "Helper": Files or resources that are shared across multiple parts of the project. Such as Protocols, and Extensions. Non-code files that are used by the project. These can include images and Color types of assets.


# Designs
<p>EcomIAPDemo project UI is adapted using simple UI</p>

# Dependencies
* Alamofire
* AlamofireImage

# API
* EcomIAPDemo project uses following API: [WeatherAPI Documentation](https://my-json-server.typicode.com/tctejaschaudhari2/sampleEcomData/product).
