import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:isolates_example/data_models.dart/hotels_list_model.dart';

class Worker
{
  SendPort _sendPort;
  Isolate _isolate;
  final isIsolateReady =Completer<void>();
  Completer<HotelListModel> hotels;

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
    else if(message is HotelListModel){
      hotels?.complete(message);
      hotels==null;
      return;
    }
    else if(message is String)
    {
     
    }

  }

  sendMessageToNewIsolate()async {
    print('hellllllllllllooooooooooo');
  
   
    _sendPort.send('getData');
      hotels=Completer<HotelListModel>();
     return hotels.future;
  }

static newIsolate(dynamic sendPort){
var newIPort=ReceivePort();
sendPort.send(newIPort.sendPort);
http.Client client=http.Client();



newIPort.listen((dynamic message)async {
print('hello12344');
 if(message is String)
 {
   if(message=='getData')
   {
     print('wooowwww');
     var data= await getHotelsList(client);
     sendPort.send(data);
   }
 }
});

}

static Future<HotelListModel> getHotelsList(http.Client client)async
{
  print('12345');
   var url= 'http://115.98.3.215:90/preorder_flutter/fetch_hotels_list.php';
 var response=await http.post(url,body: {
  'location': 'MADHAPUR'
});

return hotelListModelFromJson(response.body);
}
void dispose()
{
  _isolate.kill();
}
}