// 基本数据结构定义
///|
pub(all) struct Formatter {
  types : Array[FMT_Type]
}

///|
pub(all) enum FMT_Type {
  Text(String) // 普通文本
  Int(space~ : Int, zero_pad~ : Bool, left_align~ : Bool) // 整数格式化选项
  Double(
    space_front~ : Int,
    space_back~ : Int,
    mode~ : Bool,
    zero_pad~ : Bool,
    left_align~ : Bool
  ) // 浮点数格式化选项
  String(space~ : Int, left_align~ : Bool) // 字符串格式化选项
  HexLower(space~ : Int, zero_pad~ : Bool, left_align~ : Bool) // 小写十六进制
  HexUpper(space~ : Int, zero_pad~ : Bool, left_align~ : Bool) // 大写十六进制
  Octal(space~ : Int, zero_pad~ : Bool, left_align~ : Bool) // 八进制
  Scientific(space_front~ : Int, space_back~ : Int, uppercase~ : Bool) // 科学计数法
  Unsigned(space~ : Int, zero_pad~ : Bool, left_align~ : Bool) // 无符号数
}

///|
pub(all) enum Args_Type {
  String(String)
  Int(Int)
  UInt(Int) // 无符号整数
  Double(Double)
}

///|
pub fn max(a : Int, b : Int) -> Int {
  if a >= b {
    a
  } else {
    b
  }
}

// 进制转换函数
///|
pub fn to_base(val : Int, base : Int, uppercase : Bool) -> String {
  let digits = match base {
    8 => "01234567"
    16 => if uppercase { "0123456789ABCDEF" } else { "0123456789abcdef" }
    _ => return "Unsupported base"
  }
  if val == 0 {
    return "0"
  }
  let mut result = ""
  let mut num = val
  while num > 0 {
    let remainder = num % base
    result = result + digits[remainder].to_string()
    num /= base
  }
  result.rev()
}

// 科学计数法格式化函数
///|
fn format_scientific(num : Double, precision : Int, uppercase : Bool) -> String {
  let mut exponent = 0
  let mut value = num
  if value != 0.0 {
    while value.abs() >= 10.0 {
      value = value / 10.0
      exponent += 1
    }
    while value.abs() < 1.0 {
      value = value * 10.0
      exponent -= 1
    }
  }
  let mantissa = format_decimal(value, precision, true)
  let exp_symbol = if uppercase { "E" } else { "e" }
  let exp_str = if exponent >= 0 { "+" } else { "-" }
  mantissa + exp_symbol + exp_str + exponent.abs().to_string().pad_start(2, '0')
}

// 浮点数格式化函数
///|
pub fn format_decimal(num : Double, precision : Int, mode : Bool) -> String {
  let mut scale = 1
  for i = 0; i < precision; i = i + 1 {
    scale *= 10
  }
  let rounded = if mode {
    (num * scale.to_double() + 0.5).to_int() // 四舍五入
  } else {
    (num * scale.to_double()).to_int() // 直接截断
  }
  let integer_part = (rounded / scale).to_string()
  let decimal_part = (rounded % scale).to_string()
  let mut result = integer_part
  if precision >= 1 {
    result = result + "." + decimal_part
  }
  return result
}

///|
pub fn Formatter::new(fmt : String) -> Formatter {
  let types : Array[FMT_Type] = []
  let mut i = 0
  while i < fmt.length() {
    if fmt[i] == '%' {
      if i + 1 == fmt.length() {
        break
      }
      i += 1
      let mut space_front = 0
      let mut space_back = 2 // 默认精度为2
      let mut zero_pad = false
      let mut left_align = false

      // 解析左对齐标志
      if fmt[i] == '-' {
        left_align = true
        i += 1
      }

      // 解析零填充标志
      if fmt[i] == '0' && left_align == false {
        zero_pad = true
        i += 1
      }

      // 解析宽度
      while i < fmt.length() && fmt[i] >= '0' && fmt[i] <= '9' {
        space_front = space_front * 10 + fmt[i].to_int() - 48
        i += 1
      }

      // 解析精度
      if i < fmt.length() && fmt[i] == '.' {
        i += 1
        space_back = 0
        while i < fmt.length() && fmt[i] >= '0' && fmt[i] <= '9' {
          space_back = space_back * 10 + fmt[i].to_int() - 48
          i += 1
        }
      }

      // 处理格式说明符
      if i < fmt.length() {
        match fmt[i] {
          'd' =>
            types.push(FMT_Type::Int(space=space_front, zero_pad~, left_align~))
          'f' =>
            types.push(
              FMT_Type::Double(
                space_front~,
                space_back~,
                mode=true,
                zero_pad~,
                left_align~,
              ),
            )
          's' => types.push(FMT_Type::String(space=space_front, left_align~))
          'x' =>
            types.push(
              FMT_Type::HexLower(space=space_front, zero_pad~, left_align~),
            )
          'X' =>
            types.push(
              FMT_Type::HexUpper(space=space_front, zero_pad~, left_align~),
            )
          'o' =>
            types.push(
              FMT_Type::Octal(space=space_front, zero_pad~, left_align~),
            )
          'e' =>
            types.push(
              FMT_Type::Scientific(space_front~, space_back~, uppercase=false),
            )
          'E' =>
            types.push(
              FMT_Type::Scientific(space_front~, space_back~, uppercase=true),
            )
          'u' =>
            types.push(
              FMT_Type::Unsigned(space=space_front, zero_pad~, left_align~),
            )
          _ => types.push(FMT_Type::Text("%" + fmt[i].to_string()))
        }
      }
    } else {
      types.push(FMT_Type::Text(fmt[i].to_string()))
    }
    i += 1
  }
  return { types, }
}


///|
pub fn Formatter::fmt(self : Formatter, args : Array[Args_Type]) -> String {
  let mut result = ""
  let mut arg_index = 0
  for typ in self.types {
    match typ {
      FMT_Type::Text(t) => result += t
      FMT_Type::Int(space~, zero_pad~, left_align~) => {
        if arg_index >= args.length() {
          println("Not enough arguments")
          break
        }
        match args[arg_index] {
          Args_Type::Int(val) => {
            let str_val = val.to_string()
            let pad_char = if zero_pad && left_align == false {
              "0"
            } else {
              " "
            }
            let padding = pad_char.repeat(max(0, space - str_val.length()))
            result += if left_align {
              str_val + padding
            } else {
              padding + str_val
            }
            arg_index += 1
          }
          _ => println("Type mismatch: expected Int")
        }
      }
      FMT_Type::Double(space_front~, space_back~, mode~, zero_pad~, left_align~) => {
        if arg_index >= args.length() {
          println("Not enough arguments")
          break
        }
        match args[arg_index] {
          Args_Type::Double(val) => {
            let formatted = format_decimal(val, space_back, mode)
            let pad_char = if zero_pad && left_align == false {
              "0"
            } else {
              " "
            }
            let padding = pad_char.repeat(
              max(0, space_front - formatted.length()),
            )
            result += if left_align {
              formatted + padding
            } else {
              padding + formatted
            }
            arg_index += 1
          }
          _ => println("Type mismatch: expected Double")
        }
      }
      FMT_Type::String(space~, left_align~) => {
        if arg_index >= args.length() {
          println("Not enough arguments")
          break
        }
        match args[arg_index] {
          Args_Type::String(val) => {
            let padding = " ".repeat(max(0, space - val.length()))
            result += if left_align { val + padding } else { padding + val }
            arg_index += 1
          }
          _ => println("Type mismatch: expected String")
        }
      }
      FMT_Type::HexLower(space~, zero_pad~, left_align~) => {
        if arg_index >= args.length() {
          println("Not enough arguments")
          break
        }
        match args[arg_index] {
          Args_Type::Int(val) => {
            let str_val = to_base(val, 16, false)
            let pad_char = if zero_pad && left_align == false {
              "0"
            } else {
              " "
            }
            let padding = pad_char.repeat(max(0, space - str_val.length()))
            result += if left_align {
              str_val + padding
            } else {
              padding + str_val
            }
            arg_index += 1
          }
          _ => println("Type mismatch: expected Int")
        }
      }
      FMT_Type::HexUpper(space~, zero_pad~, left_align~) => {
        if arg_index >= args.length() {
          println("Not enough arguments")
          break
        }
        match args[arg_index] {
          Args_Type::Int(val) => {
            let str_val = to_base(val, 16, true)
            let pad_char = if zero_pad && left_align == false {
              "0"
            } else {
              " "
            }
            let padding = pad_char.repeat(max(0, space - str_val.length()))
            result += if left_align {
              str_val + padding
            } else {
              padding + str_val
            }
            arg_index += 1
          }
          _ => println("Type mismatch: expected Int")
        }
      }
      FMT_Type::Octal(space~, zero_pad~, left_align~) => {
        if arg_index >= args.length() {
          println("Not enough arguments")
          break
        }
        match args[arg_index] {
          Args_Type::Int(val) => {
            let str_val = to_base(val, 8, false)
            let pad_char = if zero_pad && left_align == false {
              "0"
            } else {
              " "
            }
            let padding = pad_char.repeat(max(0, space - str_val.length()))
            result += if left_align {
              str_val + padding
            } else {
              padding + str_val
            }
            arg_index += 1
          }
          _ => println("Type mismatch: expected Int")
        }
      }
      FMT_Type::Scientific(space_front~, space_back~, uppercase~) => {
        if arg_index >= args.length() {
          println("Not enough arguments")
          break
        }
        match args[arg_index] {
          Args_Type::Double(val) => {
            let mut exponent = 0
            let mut value = val
            if value != 0.0 {
              while value.abs() >= 10.0 {
                value = value / 10.0
                exponent += 1
              }
              while value.abs() < 1.0 {
                value = value * 10.0
                exponent -= 1
              }
            }
            let mantissa = format_decimal(value, space_back, true)
            let exp_symbol = if uppercase { "E" } else { "e" }
            let exp_str = if exponent >= 0 { "+" } else { "-" }
            let formatted = mantissa +
              exp_symbol +
              exp_str +
              exponent.abs().to_string().pad_start(2, '0')
            let padding = " ".repeat(max(0, space_front - formatted.length()))
            result += padding + formatted
            arg_index += 1
          }
          _ => println("Type mismatch: expected Double")
        }
      }
    }
  }
  return result
}
