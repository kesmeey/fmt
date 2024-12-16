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
