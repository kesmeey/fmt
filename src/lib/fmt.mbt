// Add padding spaces to the left of the number
pub fn format_int(width: Int, num: Int) -> String {
    let formatted = num.to_string();  
    let padding = width - formatted.length();  
    let mut result = "";  
for i = 0; i < padding; i = i + 1 {
        result = result + " ";  
    }
    result = result + formatted;  
    result
}
// Function to round a floating-point number to a specified precision and return it as a string
pub fn round_float(num: Float, precision: Int) -> String {
  let format = "%." + precision.to_string() + "f"
  let result = format_string(format, num)
  result
}

// Helper function to format the float number based on the specified format and handle rounding
pub fn format_string(fmt: String, num: Float) -> String {
  let mut result = ""     
  let mut index = 0       
  let mut lastnum = 0    
  let mut check = false   
  let mut num_str = num.to_string()  
  let mut precision =0 
  while index < fmt.length() {
    if fmt[index] == '.' {
      index += 1  
      precision = fmt[index].to_int() - 48 

      index += 1
      let specifier = fmt[index]

      if specifier == 'f' {
        let dot_index = num_str.index_of(".")
        
        if dot_index != -1 {
          let integer_part = num_str.substring(start = 0, end = dot_index)
          let decimal_part = num_str.substring(start = dot_index + 1)
    
          let truncated_decimal = decimal_part.substring(start = 0, end = precision)
          num_str = integer_part + "." + truncated_decimal
          lastnum = decimal_part[precision] - '0'
        }

        result = result + num_str 
        index += 1 
      }
    } 
    index += 1
  }

  if lastnum >= 5 {
    check = true
  }

  if check {
    let mut carry = true
    let mut new_result = ""
    
    for i = result.length() - 1; i >= 0; i = i - 1 {
      let current_char = result[i]
      if carry {
        if current_char == '.' {
          new_result = "." + new_result
        } else {
          let digit = current_char.to_int() + 1 - 48

          if digit == 10 {
            new_result = "0" + new_result
          } else {
            new_result = digit.to_string() + new_result
            carry = false
          }
        }
      } else {
        new_result = current_char.to_string() + new_result
      }
    }

    if carry {
      new_result = "1" + new_result
    }

    result = new_result
  }
  if precision ==0{
    result = result.substring(start=0,end=result.length()-1)
  }
  result
}