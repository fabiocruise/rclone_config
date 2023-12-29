#!/bin/bash

# Limpa a tela do prompt
clear

# Verifica se o sistema é BigLinux
system=$(cat /etc/os-release | grep "biglinux")
if [ -z "$system" ]; then
  echo "Este script só funciona em sistemas BigLinux"
  exit 1
fi

# Verifica se o rclone está instalado
rclone_installed=$(pacman -Q rclone)
if [ -z "$rclone_installed" ]; then
  echo "Instalando o rclone..."
  sleep 3
  sudo pacman -S rclone --noconfirm
fi

# Verifica se o expect está instalado
expect_installed=$(pacman -Q expect)
if [ -z "$expect_installed" ]; then
  echo "Instalando o expect..."
  sleep 3
  sudo pacman -S expect --noconfirm
fi

# Exibe uma mensagem ao usuário informando que todos os aplicativos foram instalados
if [ -n "$rclone_installed" ] && [ -n "$expect_installed" ]; then
  echo "Todos os Aplicativos, rclone e expect, foram instalados corretamente!"
else
  echo "Não foi possível instalar todos os aplicativos"
fi
