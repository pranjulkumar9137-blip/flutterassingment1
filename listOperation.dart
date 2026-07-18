void main()
{
  var list=[10,"pranjul","akash",10.2];
  print(list[0]);
  print(list[1]);
  print(list[2]);
  print(list[3]);
  //adding a element at the last
  list.add("vivek");
  print("\n ${list[4]}\n");

  //removing an element 
  list.remove("akash");
  
  //find the length of the list
  int len=list.length;
  for(int i=0;i<len;i++)
  {
    print(list[i]);
  }
}