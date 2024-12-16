# MoonBit `fmt` Library Implementation

This project provides a simple implementation of common formatting functions in MoonBit, inspired by the `fmt` library found in other languages like Go. The library includes functions to format integers, strings, and other data types with padding and other formatting features.

## Features

- **`format_int(width: Int, num: Int) -> String`**: Formats an integer with a specified width, padding with spaces on the left if necessary.
  
## Installation

To use the library, you simply need to include the necessary functions in your MoonBit project. No additional installation steps are required.

## Functions

### `format_int(width: Int, num: Int) -> String`

This function formats an integer (`num`) to fit within the specified width (`width`). If the number is smaller than the width, it will be padded with spaces on the left side. If the number is larger than the width, no padding is applied, and the number is returned as-is.

#### Parameters:
- `width`: The desired width of the formatted string (integer).
- `num`: The integer that will be formatted.

#### Returns:
- A string containing the formatted number, with leading spaces if necessary to meet the specified width.

#### Example Usage:

```moonbit
fn main {
    let formatted_number = @lib.format_int(5, 42);
    println([formatted_number]);  // Output: "   42" (3 spaces before the number)
    
    let formatted_large_number = @lib.format_int(3, 12345);
    println([formatted_large_number]);  // Output: "12345" (no padding as the number is too large)
}
```

### Output Example:
- `format_int(5, 42)` will output: `"   42"` (with 3 spaces before the number).
- `format_int(3, 12345)` will output: `"12345"` (no padding, as the number exceeds the specified width).


## Contribution

Feel free to contribute by submitting pull requests for additional formatting functions or improvements. Suggestions for other useful `fmt`-style formatting functions are welcome.



