class APIRoutes {
  static const String _baseRoute = 'http://192.168.1.85:8001/api/';

  static String getRoute(String key) {
    switch (key) {
      case 'REGISTER_PET_OWNER':
        key = "${_baseRoute}auth/signup";
        break;
      case 'LOGIN':
        key = '${_baseRoute}auth/login';
        break;
      default:
    }

    return key;
  }
}
