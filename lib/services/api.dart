class Api{
  final String url = "http://nx-leave-app.herokuapp.com/api/v1";

  Uri login() => Uri.parse(url+'/users/login');
  Uri register() => Uri.parse(url+'/users/register');
}

