void main(){
  //create a map 
  Map<String ,int> m={
    'pranjul':200,
    'akash':240,
    'mukesh':500
  };

  //accessing element without using the loop
  print(m["pranjul"]);
  print(m["akash"]);
  print(m["mukesh"]);
  
  // adding a element
  m["vivek"]=25;
  print(m["vivek"]);

  //delete an key from the map
  m.remove("akash");
}