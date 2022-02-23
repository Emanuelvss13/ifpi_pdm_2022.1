main(){
  
  var result_sum = exec([1,2,3,4,5], sum);
  var result_mul = exec([1,2,3,4,5], mul);
  
  print(result_sum);
  print(result_mul);
  
}

int exec(Iterable<int> numbers,int Function(Iterable<int>) f){
    return f(numbers);
  }

int mul(Iterable<int> numbers){
    var result = 1;
    
    numbers.forEach((num) => {
      result *= num
    });
    
    return result;
 }

int sum(Iterable<int> numbers){
    var result = 0;
    
    numbers.forEach((num) => {
      result += num
    });
    
    return result;
 }