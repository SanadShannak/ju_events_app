# JUEvents Application

JUEvents is a Flutter-based mobile application designed to efficiently manage the system of publishing event announcements. With this app, users can conveniently explore upcoming events and seamlessly publish their own events based on their specific roles and permissions within the system. The user-friendly interface and robust functionality ensure an optimized experience for both event organizers and attendees, making event management and participation more accessible and streamlined.

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Screens and User Flow](#screens-and-user-flow)
4. [Database Structure](#database-structure)
5. [Packages Used](#packages-used)
  

## Overview

JUEvents simplifies event management for students, teams, and administrators at the University of Jordan. The app streamlines the process of event creation, management, and participation across various institutional units. Built using the Flutter framework, JUEvents integrates seamlessly with Firebase Firestore for real-time data handling and Firebase Authentication for secure user management.

Key Tools:

- Flutter: Cross-platform app development framework
  
- Firebase Authentication : Secure user authentication and management
  
- Firestore: Real-time backend database for scalable data storage
  
- Figma: UI/UX design
  
- Lucidchart: Database and architectural modeling (UML, ERD and Firestore structure)
  

##### Features

- **Event Discovery**: 
  Students or regular users can easily discover upcoming events.
  
- **Role-Based Access Control**:
  The app provides tailored features based on user roles:
  
  - **Team Leaders**:
    - Access all regular user functionalities.
    - Request event publication.
    - Track the status of their event publication requests.
  - **Admins**:
    - Access all regular user functionalities.
    - Manage team leaders' event publication requests within their Institutional Unit.
    - Publish events on behalf of their unit.
- **Personalized Event Suggestions**:
  Users receive event recommendations based on their interests.
  

## Screens and User Flow

Detailed designs and user flow diagrams are provided in the Figma links:

UI Design : [Figma](https://www.figma.com/design/b2yLg75a51gJKmWiPslWQv/JU-Events-App?node-id=0-1&t=gDhsRwqwm2ZFfpg6-1)

User Flow: [Figma](https://www.figma.com/board/RDqH3G0zG0isSZGZGM2e7x/User-Flow?t=gDhsRwqwm2ZFfpg6-1)

## Database Structure

The Firestore database structure, UML, and ERD are documented in Lucidchart:

[Lucid chart](https://lucid.app/lucidchart/8d2058ed-e02b-480b-aa2a-700554dfbdf6/edit?viewport_loc=-1177%2C-17%2C3922%2C1858%2C0_0&invitationId=inv_501f914b-e9ff-42cb-8ed2-a78b90fa5b39)

## Packages Used

1. **`auto_size_text`**
  
  - Dynamically adjusts text size to fit within its bounds for responsive typography.
2. **`firebase_auth`**
  
  - Provides Firebase Authentication functionalities, enabling secure user authentication (email/password).
3. **`provider`**
  
  - Implements state management using the provider pattern.
4. **`flutter_svg`**
  
  - Renders SVG images for scalable and high-quality graphics.
5. **`intl`**
  
  - Supports internationalization, including date, number, and currency formatting.
6. **`dots_indicator`**
  
  - Adds an animated dots indicator for page navigation.
7. **`firebase_core`**
  
  - Initializes Firebase services, acting as the foundation for Firebase integration.
8. **`flashy_tab_bar2`**
  
  - Provides a flashy, animated, and customizable tab bar for app navigation.
9. **`cloud_firestore`**
  
  - Accesses Firebase Firestore, a NoSQL cloud database for real-time data storage.
10. **`json_serializable`**
  
  - Simplifies JSON serialization and deserialization for converting JSON data into Dart objects and vice versa.
11. **`flutter_launcher_icons`**
  
  - Automates the generation of app launcher icons (logo) for multiple platforms.
12. **`smooth_page_indicator`**
  
  - Provides customizable and animated page indicators for paginated screens.

## Team Members Tasks

This section is meant to document each team member's contributions to the project and the tasks that were assigned to them.

*Note: This is only meant for university grading purposes and is to be deleted in case of publication*

[Team Members Tasks](https://www.figma.com/design/50ffeibtwzx0tlEZsdEdiU/Team-Members-Role?node-id=0-1&p=f&t=6HfVB2WK72g9Mlz4-0)
![timeLine](https://github.com/user-attachments/assets/8d61b46a-1fbd-4bd0-85ce-8c9b32de5fe8)

