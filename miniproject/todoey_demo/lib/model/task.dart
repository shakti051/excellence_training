class Task{
 final String  name;
 bool isDone;
 Task({this.name="task",this.isDone:false});
  void toggleDone(){
    isDone = !isDone;
  } 
}