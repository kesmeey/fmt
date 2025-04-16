# fmt

A string formatting library similar to `printf` in C++ and `fmt` in Go.

## Features

- Supports formatting of various data types.
- Provides width and precision control.
- Supports left/right alignment.
- Supports zero-padding.
- Supports scientific notation.

## Supported Formatting Options

- `%d` - Integer
- `%u` - Unsigned integer
- `%f` - Floating-point number
- `%e/%E` - Scientific notation
- `%g/%G` - Automatically choose between `%f` or `%e`
- `%s` - String
- `%x/%X` - Hexadecimal (lowercase/uppercase)
- `%o` - Octal

### Flags

- `-` : Left alignment
- `+` : Show plus sign for positive numbers
- `0` : Zero-padding
- Number : Specify width
- `.Number` : Specify precision

## Usage Examples

### Examples of `%s`, `%d`, `%f`

```moonbit
fn main { 
    // Define the format string
    let fmt_str = "Hello %s, you have %05d unread messages. Pi is approximately %.2f.";

    // Initialize the Formatter
    let formatter = Formatter::new(fmt_str);

    // Define the arguments
    let args: Array[Args_Type] = [
        Args_Type::String("Alice".to_string()), // Replace %s with "Alice"
        Args_Type::Int(42),                    // Replace %05d with "00042"
        Args_Type::Double(3.14159),            // Replace %.2f with "3.14"
    ];

    // Perform formatting using the Formatter
    let result = formatter.fmt(args);

    // Print the result
    println(result);
}
```

```
Hello Alice, you have 00042 unread messages. Pi is approximately 3.14.
```

### Examples of `%u`, `%X`, `%x`, `%o`

```moonbit
fn main { 
    // Define the format string
    let fmt_str = "Unsigned: %u, Hex Upper: %X, Hex Lower: %x, Octal: %o";

    // Initialize the Formatter
    let formatter = Formatter::new(fmt_str);

    // Define the arguments
    let args: Array[Args_Type] = [
        Args_Type::UInt(4294967295),  // Replace %u with "4294967295"
        Args_Type::Int(255),          // Replace %X with "FF"
        Args_Type::Int(255),          // Replace %x with "ff"
        Args_Type::Int(255)           // Replace %o with "377"
    ];

    // Perform formatting using the Formatter
    let result = formatter.fmt(args);

    // Print the result
    println(result); 
}
```

```
"Unsigned: 4294967295, Hex Upper: FF, Hex Lower: ff, Octal: 377"
```

### Examples of Scientific Notation `%e`, `%E`

```moonbit
fn main { 
    // Example: Formatting in scientific notation
    let fmt_str = "Scientific notation: %10.3e, Uppercase: %12.2E";

    // Initialize the Formatter
    let formatter = Formatter::new(fmt_str);

    // Define the arguments
    let args: Array[Args_Type] = [
        Args_Type::Double(0.00012345), // Format in scientific notation (lowercase)
        Args_Type::Double(-98765.4321), // Format in scientific notation (uppercase)
    ];

    // Perform formatting using the Formatter
    let result = formatter.fmt(args);

    // Print the result
    println(result);
}
```

```
Scientific notation:  1.234e-04, Uppercase:   -9.87E+04
```

### Examples of Flag Usage

```moonbit
fn main { 
    // Flag combination test
    let fmt1 = "Integer flag test:\nShow plus for positive: %+d\nSpace padding: %8d\nZero padding: %08d\n";
    let args1: Array[Args_Type] = [
        Args_Type::Int(42),    // Test showing plus sign
        Args_Type::Int(123),   // Test space padding
        Args_Type::Int(456)    // Test zero padding
    ];
    println(Formatter::new(fmt1).fmt(args1));
}
```

```
Integer flag test:
Show plus for positive: +42
Space padding:      123
Zero padding: 00000456
```

### Examples of String Alignment

```moonbit
fn main { 
    // Define the format string
    let fmt_str = "Left aligned: '%-10s', Right aligned: '%10s'";

    // Initialize the Formatter
    let formatter = Formatter::new(fmt_str);

    // Define the arguments
    let args: Array[Args_Type] = [
        Args_Type::String("left"),   // Replace %-10s with "left      "
        Args_Type::String("right")   // Replace %10s with "     right"
    ];

    // Perform formatting using the Formatter
    let result = formatter.fmt(args);

    // Print the result
    println(result);  
}
```

```
Left aligned: 'left      ', Right aligned: '     right'
```

### Examples of General Format (`%g/%G`)

```moonbit
fn main { 
    // General format (%g/%G) test
    let fmt2 = "General format test:\nDecimal: %g\nScientific: %g\nUppercase: %G\nPrecision control: %.3g\n";
    let args2: Array[Args_Type] = [
        Args_Type::Double(123.456),      // Regular decimal
        Args_Type::Double(0.000123),     // Automatically use scientific notation
        Args_Type::Double(1.23e+6),      // Uppercase test
        Args_Type::Double(1234.5678)     // Precision control test
    ];
    println(Formatter::new(fmt2).fmt(args2));
}
```

```
General format test:
Decimal: 123.456
Scientific: 1.23e-04
Uppercase: 1.23E+06
Precision control: 1.23e+03
```

### Examples of Special Values (Positive Infinity, Negative Infinity)

```moonbit
fn main { 
    // Special value test
    let fmt4 = "Special value test:\n%g\n%G\n";
    let args4: Array[Args_Type] = [
        Args_Type::Double(1.0/0.0),      // Positive infinity
        Args_Type::Double(-1.0/0.0)      // Negative infinity
    ];
    println(Formatter::new(fmt4).fmt(args4));
}
```

```
Special value test:
inf
-INF
```