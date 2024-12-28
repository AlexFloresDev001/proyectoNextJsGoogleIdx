#!/bin/bash

# Verifica si hay cambios para commitear
if [[ -z $(git status --porcelain) ]]; then
  echo "No hay cambios para commitear."
  exit 0
fi

# Solicita el tipo de commit
echo "Seleccione el tipo de commit:"
options=("fix" "feat" "chore" "docs" "style" "refactor" "test" "perf" "ci")
select type in "${options[@]}"; do
  if [[ -n "$type" ]]; then
    break
  else
    echo "Por favor seleccione una opción válida."
  fi
done

# Sugerencias de mensaje base según el tipo de commit
case $type in
  fix)
    base_message="Soluciona un error relacionado con..."
    ;;
  feat)
    base_message="Añade una nueva funcionalidad..."
    ;;
  chore)
    base_message="Realiza cambios en tareas rutinarias..."
    ;;
  docs)
    base_message="Actualiza o mejora la documentación..."
    ;;
  style)
    base_message="Ajusta estilos o formato del código (sin cambios funcionales)..."
    ;;
  refactor)
    base_message="Reestructura el código sin cambiar su comportamiento..."
    ;;
  test)
    base_message="Añade o modifica pruebas..."
    ;;
  perf)
    base_message="Mejora el rendimiento del código..."
    ;;
  ci)
    base_message="Actualiza configuraciones de CI/CD..."
    ;;
  *)
    base_message="Describe los cambios realizados..."
    ;;
esac

# Solicita el mensaje del commit con el mensaje base prellenado
read -p "Ingrese el mensaje del commit (sugerido: '$base_message'): " message
if [[ -z "$message" ]]; then
  message=$base_message
fi

# Agrega los archivos al stage
git add .

# Realiza el commit con el formato estándar
git commit -m "$type: $message"

echo "Commit realizado con éxito: $type: $message"
