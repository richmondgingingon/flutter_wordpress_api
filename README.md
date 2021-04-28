## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## How to use this
- Please run `flutter pub get` to get all the packages
- Install JWT Auth - WordPress JSON Web Token Authentication plugin
- Modify wp-config on your WordPress file and add this line: <br> 
    `define( 'JWT_AUTH_SECRET_KEY', 'your-top-secret-key');`
- Please change apiUrl to your own url of wordpress link. To modify it go to lib/services/api_service.dart. 
- Run the app. It should work.
