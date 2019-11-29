import 'dart:async';
import 'dart:isolate';

class Worker
{
  SendPort _sendPort;
  Isolate _isolate;
  final isIsolateReady =Completer<void>();

Worker()
{
  init();

}
Future<void> get isReady=>isIsolateReady.future;
  Future<void> init()async{
      ReceivePort receivePort=ReceivePort();
      receivePort.listen(_handleMessage);
      _isolate =await Isolate.spawn(newIsolate,receivePort.sendPort);

  }
  _handleMessage(dynamic message){
    if(message is SendPort)
    {
      _sendPort=message;
      isIsolateReady.complete();

    }
    else if(message is String)
    {
      print ('message Recieved from new Isolate');
    }

  }

  sendMessageToNewIsolate()async {
    _sendPort.send('hello from main Isolate');
  }

static newIsolate(dynamic sendPort){
var newIPort=ReceivePort();
sendPort.send(newIPort.sendPort);

newIPort.listen((dynamic message){
  print('message Recieved from main isolate');
  sendPort.send('message to mainIsolate');
});

}  
void dispose()
{
  _isolate.kill();
}
}