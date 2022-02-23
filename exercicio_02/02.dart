main(){
  int mul(Iterable<int> numbers){
    var result = 1;
    
    numbers.forEach((num) => {
      result *= num
    });
    
    return result;
  }
  
  int result = mul([10,10]);
  
  print(result);
  
}