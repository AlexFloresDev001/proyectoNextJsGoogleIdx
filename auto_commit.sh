#!/bin/bash

# Verifica si hay cambios para commitear
if [[ -z $(git status --porcelain) ]]; then
  echo "No hay cambios para commitear."
  exit 0
fi

# Solicita el tipo de commit
read -p "Ingrese el tipo de commit (fix, feat, chore, docs, etc.): " type
if [[ -z "$type" ]]; then
  echo "El tipo de commit es obligatorio."
  exit 1
fi

# Solicita el mensaje del commit
read -p "Ingrese el mensaje del commit: " message
if [[ -z "$message" ]]; then
  echo "El mensaje del commit es obligatorio."
  exit 1
fi

# Agrega los archivos al stage
git add .

# Realiza el commit con el formato estándar
git commit -m "$type: $message"

echo "Commit realizado con éxito: $type: $message"
