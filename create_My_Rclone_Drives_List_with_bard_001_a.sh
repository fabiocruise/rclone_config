#!/bin/bash

# Limpa a tela para exibir novos comandos!
clear 

# Verifica se o sistema é BigLinux
system=$(cat /etc/os-release | grep "Manjaro")
if [ -z "$system" ]; then
  echo "Este script só funciona em sistemas BigLinux ou sistemas baseados em Arch ou Manjaro cujo gerenciador de pacotes é o ---PACMAN---"
  exit 1
fi

# Verifica qual é o gerenciador de pacotes
package_manager=$(command -v pacman)
if [ -z "$package_manager" ]; then
  package_manager=$(command -v apt-get)
  if [ -z "$package_manager" ]; then
    package_manager=$(command -v dnf)
    if [ -z "$package_manager" ]; then
      echo "Não foi possível identificar o gerenciador de pacotes"
      exit 1
    fi
  fi
fi

# Verifica se os recursos do rclone são válidos
if [ -z "$rclone_features" ]; then
  rclone_features="all"
fi

# Instala o rclone
echo "Iniciando a instalação do Rclone e suas dependencias!"
sleep 2
if [ "$package_manager" == "pacman" ]; then
  sudo pacman -S rclone-${rclone_version} --noconfirm
elif [ "$package_manager" == "apt-get" ]; then
  sudo apt-get install rclone=${rclone_version} --no-install-recommends
elif [ "$package_manager" == "dnf" ]; then
  sudo dnf install rclone-${rclone_version} --nobest
fi

# Instala os plugins do rclone
echo "Instalando os plugins do Rclone!"
sleep 2
for plugin in $rclone_features; do
  if [ "$plugin" != "all" ]; then
    sudo rclone config host add $plugin "https://rclone.org/plugins/$plugin/"
  fi
done


# Exibe uma mensagem ao usuário informando que todos os aplicativos foram instalados
if [ -n "$rclone_installed" ]; then
  echo "O rclone foi instalado com sucesso!"
  sleep 2

else
  echo "Não foi possível instalar o rclone
  ===================>>>> SAINDO DA INSTALAÇÃO..."
  sleep 2

fi
