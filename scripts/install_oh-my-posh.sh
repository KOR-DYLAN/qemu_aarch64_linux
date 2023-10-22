#!/bin/bash
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

echo "set .bashrc"
echo "" >> ~/.bashrc
echo "# oh-my-posh" >> ~/.bashrc
echo "eval \"\$(oh-my-posh init bash --config ~/.poshthemes/amro.omp.json)\"" >> ~/.bashrc
echo "" >> ~/.bashrc
source ~/.bashrc