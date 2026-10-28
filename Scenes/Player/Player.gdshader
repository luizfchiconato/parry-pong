shader_type canvas_item;
//
//// Define the colors you want to find in your sprite
//uniform vec4 original_color_1 : source_color;
//uniform vec4 original_color_2 : source_color;
//
//// Define the colors you want to replace them with
//uniform vec4 replace_color_1 : source_color;
//uniform vec4 replace_color_2 : source_color;
//
//// Precision threshold to accommodate slight compression artifacts
//uniform float precision : hint_range(0.0, 1.0) = 0.5;
//
//void fragment() {
    //// Get the current pixel color from the sprite texture
    //vec4 current_color = texture(TEXTURE, UV);
    //
    //// Check if the current pixel matches the first target color
    //if (distance(current_color.rgb, original_color_1.rgb) < precision) {
        //current_color.rgb = replace_color_1.rgb;
    //}
    //// Check if the current pixel matches the second target color
    //else if (distance(current_color.rgb, original_color_2.rgb) < precision) {
        //current_color.rgb = replace_color_2.rgb;
    //}
    //
    //// Output the final pixel color (maintaining original transparency)
    //COLOR = current_color;
//}