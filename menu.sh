#!/bin/bash

###############################################################################
# Menú interactivo con gestión avanzada de backups
# Autor: Adaptación combinada
###############################################################################

set -a # Marca variables y funciones para exportar

# VARIABLES GLOBALES
SERVICES="odoo pgadmin4"
RED_TEXT='\033[0;31m'
GREEN_TEXT='\033[0;32m'
RESET_TEXT='\033[0m' # Sin color
VACKUP="./vackup"
source .env 2> /dev/null

if [ -z "${COMPOSE_PROJECT_NAME}" ]; then
    PREFFIX="$( basename "$(pwd)" )"
else
    PREFFIX="${COMPOSE_PROJECT_NAME}"
fi

PREFFIX="$( echo "${PREFFIX}" | tr '[:upper:]' '[:lower:]' | tr -d '.' )"
LATEST_BACKUP="backup_${PREFFIX}_latest_$(hostname).tgz"
BACKUP_PATTERN="backup_${PREFFIX}_*.tgz"

# Descargar y preparar herramienta vackup si no existe
[ -f "$VACKUP" ] || curl -sSL https://raw.githubusercontent.com/BretFisher/docker-vackup/main/vackup -o "$VACKUP"
[ -x "$VACKUP" ] || chmod +x "$VACKUP"

# Funciones para las opciones del menú
set_permissions() {
    echo "Estableciendo permisos..."
    chmod o+rwx .
    for i in $SERVICES; do
        mkdir -p "$i"
        find "$i" -type d -exec chmod 777 {} \;
        find "$i" -type f -exec chmod 666 {} \;
    done
    echo -e "${GREEN_TEXT}Permisos establecidos correctamente.${RESET_TEXT}"
}

start_containers() {
    echo "Iniciando contenedores..."
    docker-compose up -d
    echo -e "${GREEN_TEXT}Contenedores iniciados.${RESET_TEXT}"
}

stop_containers() {
    echo "Deteniendo contenedores..."
    docker-compose down
    echo -e "${GREEN_TEXT}Contenedores detenidos.${RESET_TEXT}"
}

show_logs() {
    echo "Mostrando logs..."
    docker-compose logs -f
}

save_backup() {
    echo "Creando backup..."
    local backup_file="backup_${PREFFIX}_$(date +%Y%m%d_%H%M%S)_$(hostname).tgz"
    tar --exclude="$BACKUP_PATTERN" -czf "$backup_file" * .env
    ln -sf "$backup_file" "$LATEST_BACKUP"
    echo -e "${GREEN_TEXT}Backup creado: $backup_file${RESET_TEXT}"
}

restore_backup() {
    echo "Restaurando backup..."
    local latest_backup=$(ls -t $BACKUP_PATTERN 2>/dev/null | head -n 1)
    if [ -z "$latest_backup" ]; then
        echo -e "${RED_TEXT}No se encontró ningún backup para restaurar.${RESET_TEXT}"
    else
        tar -xvzf "$latest_backup"
        echo -e "${GREEN_TEXT}Backup restaurado: $latest_backup${RESET_TEXT}"
    fi
}

# Menú interactivo
while true; do
    echo "Selecciona una opción:"
    options=(
        "Establecer permisos"
        "Iniciar contenedores"
        "Detener contenedores"
        "Ver logs"
        "Guardar backup"
        "Restaurar backup"
        "Salir"
    )
    select opt in "${options[@]}"; do
        case $REPLY in
            1) set_permissions; break ;;
            2) start_containers; break ;;
            3) stop_containers; break ;;
            4) show_logs; break ;;
            5) save_backup; break ;;
            6) restore_backup; break ;;
            7) echo "Saliendo..."; exit 0 ;;
            *) echo "Opción inválida. Inténtalo de nuevo."; break ;;
        esac
    done
    echo ""
done
