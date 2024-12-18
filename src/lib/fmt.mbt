pub(all) struct Formatter {
  types: Array[FMT_Type]
}

pub(all) enum FMT_Type {
  Text(String)        // Plain text
  Int(space~: Int)    // Integer with optional width
  Double(space_front~: Int, space_back~: Int, mode~: Bool)  // Double with width, precision, and rounding mode
}

pub(all) enum Args_Type {
  String(String)
  Int(Int)
  Double(Double)
}

// Formatter constructor: parses the format string and builds type list
pub fn Formatter::new(fmt: String) -> Formatter {
  let types: Array[FMT_Type] = []
  let mut i = 0
  
  while i < fmt.length() {
    if fmt[i] == '%' {   // Check for format specifier
      i += 1
      let mut space_front = 0
      let space_back = 2  // Default precision for floats
      let mode = true     // Default rounding mode
      let mut precision = 0  // Default precision

      // Parse width (e.g., %10)
      while i < fmt.length() && (fmt[i]>='0' && fmt[i]<='9' ) {
        space_front = space_front * 10 + fmt[i].to_int() - 48
        i += 1
      }

      // Parse precision (e.g., %.3f)
      if i < fmt.length() && fmt[i] == '.' {
        i += 1
        while i < fmt.length() && (fmt[i]>='0' && fmt[i]<='9') {
          precision = precision * 10 + fmt[i].to_int() - 48
          i += 1
        }
      }

      // Handle format specifier (d or f)
      if i < fmt.length() && fmt[i] == 'd' {
        types.push(FMT_Type::Int(space=space_front))  // Int with width
      } else if i < fmt.length() && fmt[i] == 'f' {
        types.push(FMT_Type::Double(space_front=space_front, space_back=precision, mode=mode))  // Float with width, precision, and rounding
      } else {
        types.push(FMT_Type::Text("%" + fmt[i].to_string()))  // Literal text
      }
    } else {
      types.push(FMT_Type::Text(fmt[i].to_string()))  // Literal text
    }
    i += 1
  }

  return { types }
}

// Format method: formats args based on the type list
pub fn Formatter::fmt(self: Formatter, args: Array[Args_Type]) -> String {
  let mut result = ""
  let mut arg_index = 0

  for typ in self.types {
    match typ {
      FMT_Type::Text(t) => {
        result += t  // Append plain text
      }
      FMT_Type::Int(space~) => {
        match args[arg_index] {
          Args_Type::Int(val) => {
            result += val.to_string().pad_start(space, ' ')  // Pad integer with space
            arg_index += 1
          }
        }
      }
      FMT_Type::Double(space_front~, space_back~, mode~) => {
        match args[arg_index] {
          Args_Type::Double(val) => {
            let formatted = format_decimal(val, space_back)  // Format float to specified precision
            result += formatted.pad_start(space_front, ' ')  // Pad float with space
            arg_index += 1
          }
        }
      }
    }
  }

  return result
}

// Helper function to format decimal numbers to the given precision
pub fn format_decimal(num: Double, precision: Int) -> String {
  let mut scale = 1  // Scale factor for rounding
  for i = 0; i < precision; i = i + 1 {
    scale *= 10  // Increase scale for precision
  }

  let rounded = (num * scale.to_double() + 0.5).to_int()  // Round to nearest integer
  let integer_part = (rounded / scale).to_string()  // Integer part of the formatted number
  let decimal_part = (rounded % scale).to_string()  // Decimal part of the formatted number

  let mut result = integer_part
  if precision >= 1 {
    result = result + "." + decimal_part  // Append decimal part if precision > 0
  }

  return result
}
