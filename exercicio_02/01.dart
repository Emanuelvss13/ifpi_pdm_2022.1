main(){
  int sum(Iterable<int> numbers){
    var result = 0;
    
    numbers.forEach((num) => {
      result += num
    });
    
    return result;
  }
  
  int result = sum([30,10,20]);
  
  print(result);
  
}