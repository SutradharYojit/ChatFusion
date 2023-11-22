import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIo{
  static  final IO.Socket socket = IO.io('http://10.1.86.45:7412', <String, dynamic>{
    'transports': ['websocket'],
  });




}