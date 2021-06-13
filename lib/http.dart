import 'dart:convert';
import "package:http/http.dart" as http;

class RequestResult
{
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

const PROTOCOL = "http";
const DOMAIN = "192.168.1.5:3001";

Future<RequestResult> http_get(String route, [dynamic data]) async
{
  var dataStr = jsonEncode(data);
  var url;
  print(dataStr);
  if (dataStr == "null")
    {
      url = "$PROTOCOL://$DOMAIN/$route";
    }
  else
    {
      url = "$PROTOCOL://$DOMAIN/$route/$dataStr";
    }
  print(url);
  var result = await http.get(url);
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_getWparams(String route, dynamic queryParameters) async
{
  var uri =
      Uri.http("$DOMAIN", "$route", queryParameters);
  var result = await http.get(uri, headers: {"Content-Type":"application/json"});
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post(String route, [dynamic data]) async
{
  var url = "$PROTOCOL://$DOMAIN/$route";
  var dataStr = jsonEncode(data);
  var result = await http.post(url, body: dataStr, headers: {"Content-Type":"application/json"});
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_put(String route, [dynamic data]) async
{
  var url = "$PROTOCOL://$DOMAIN/$route";
  var dataStr = jsonEncode(data);
  var result = await http.put(url, body: dataStr, headers: {"Content-Type":"application/json"});
  return RequestResult(true, jsonDecode(result.body));
}