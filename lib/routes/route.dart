import 'package:go_router/go_router.dart';
import '../view/view.dart';
import 'routes_name.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutesName.splashScreen,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    // its Routes defines to reduce the stack of screen in login and signup screen
    GoRoute(
      path: RoutesName.loginScreen,
      builder: (context, state) {
        return const LoginScreen();
      },
      routes: [
        GoRoute(
          name: RoutesName.signupName,
          path: RoutesName.signupScreen,
          builder: (context, state) {
            return const SignUpScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: RoutesName.homeScreen,
      builder: (context, state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: RoutesName.usersListingScreen,
      builder: (context, state) {
        return const UserListingScreen();
      },
    ),
    GoRoute(
      path: RoutesName.addPeopleScreen,
      builder: (context, state) {
        return AddPeopleScreen();
      },
    ),
    GoRoute(
      path: RoutesName.createGrpScreen,
      builder: (context, state) {
        return CreateGroupScreen();
      },
    ),
    GoRoute(
      path: RoutesName.userProfileScreen,
      builder: (context, state) {
        return UserProfileScreen();
      },
    ),
    GoRoute(
      path: RoutesName.editProfileScreen,
      builder: (context, state) {
        return EditUserProfile();
      },
    ),
  ],
);
