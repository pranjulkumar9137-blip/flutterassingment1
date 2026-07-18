//in this program i print the table with user input
import 'dart:io';
void main()
{
  stdout.write("Enter the table no: ");
  int num=int.parse(stdin.readLineSync()!);
  for(int i=1;i<=10;i++)
  {
    print("$num * $i := ${num*i}");
  }
}