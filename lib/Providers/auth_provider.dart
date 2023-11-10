import 'package:naveenboutique/Packages/packages.dart';

class AuthProvider with ChangeNotifier {
  // initialize then make getter
  bool _loggedin = false;

  bool get loggedin => _loggedin;
}
