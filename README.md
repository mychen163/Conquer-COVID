# Conquer COVID

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app that provides nearby COVID testing locations and relevant localized COVID data.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Health
- **Mobile:** Mobile is essential for knowing the user's current location to determine nearby COVID-19 testing centers.
- **Story:** Allows users to quickly determine Covid-19 testing facilities near them in a map. 
- **Market:** Anyone who is living during the Covid-19 Pandemic. 
- **Habit:** When user's feel like they have any of the symptoms associated with the coronavirus, or want to take an asymptomatic test.
- **Scope:** V1 will have the map feature showing the location of nearby testing facilities. V2 will provide in-app details about the price/insurance requirements for the test for each location. V3 will provide information about current active covid cases in each location (county data). V4 will include a county updates screen, for any new situations/guidelines. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can get information about nearby testing centers
* User can see the testing centers on a map
* User can get information about active COVID cases nearby

**Optional Nice-to-have Stories**

* User can enter any location (in the US) to find nearby testing centers
* User can see more information about testing center (i.e. ave waiting times, etc.)

### 2. Screen Archetypes

* Map Screen
   * User can see testing centers on the map
 
* Testing Center List Screen (Modal in Map Screen)
   * View list of nearby testing centers 

* COVID Info Screen
    * View localized COVID data 

* County Updates Screen
    * View guideline and situation updates from county

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Map Screen
* COVID Info Screen

**Flow Navigation** (Screen to Screen)

* Map Screen
    * => Testing Center List Screen

* Testing Center List Screen
    * => None 
* COVID Info Screen
    * => County Updates Screen

* County Updates Screen
    * => COVID Info Screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype
<img src="http://g.recordit.co/9UBfbGIccx.gif" width=300>

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
