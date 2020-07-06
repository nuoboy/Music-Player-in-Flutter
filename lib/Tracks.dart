//{
//"message": {
//            "header": {
//                        "status_code": 200,
//                        "execute_time": 0.00136,
//                        "available": 646
//                      },
//            "body": {
//                      "track_list": [
//                                      {
//                                      "track": "track'"
//                                      },
//                                      {
//                                      "track": "track'"
//                                      },
//                                      {
//                                      "track": "track'"
//                                      }
//                                    ]
//                      }
//            }
//}


class Body{
  final List<Track> Track_list;
  Body({this.Track_list});

  factory Body.fromJson(Map<String, dynamic> parsedJson){
    var list= parsedJson['track_list'] as List;
    List<Track> amal= list.map((i) => Track.fromJson(i)).toList();
    return Body(
    Track_list:amal
    );
}
}

class Track{
  final String track_name;
  Track({this.track_name});

factory Track.fromJson(Map<String, dynamic> parsedJson){
    return Track(
    track_name:parsedJson['track']
    );
}
}