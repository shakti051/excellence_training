import 'LikesModel.dart';

class LikeSelectedModel{
  int type;
  String name;
  String emojipath;
  List<LikesData> selectedlikeslist;

  LikeSelectedModel(this.type,this.name,this.emojipath,this.selectedlikeslist);
}