#!/bin/bash

# Verifica si el archivo de configuración (menu.txt) existe
if [[ ! -f $1 ]]; then
    echo "Error: No se encontró el archivo de configuración $1."
    echo "Uso: ./menu.sh menu.txt"
    exit 1
fi

# Funciones para las opciones del menú
set_permissions() {
    echo "Estableciendo permisos en los directorios odoo y pgadmin4..."
    chmod -R 755 odoo pgadmin4
    echo "Permisos establecidos."
}

start_containers() {
    echo "Iniciando contenedores..."
    docker-compose up -d
    echo "Contenedores iniciados."
}

stop_containers() {
    echo "Deteniendo contenedores..."
    docker-compose down
    echo "Contenedores detenidos."
}

show_logs() {
    echo "Mostrando logs..."
    docker-compose logs -f
}

save_backup() {
    echo "Creando backup con marca temporal..."
    tar -czvf "backup_$(date +%Y%m%d%H%M%S).tar.gz" odoo pgadmin4
    echo "Backup creado."
}

restore_backup() {
    echo "Restaurando el último backup..."
    latest_backup=$(ls -t backup_*.tar.gz | head -n 1)
    if [[ -z "$latest_backup" ]]; then
        echo "No se encontró ningún backup."
    else
        tar -xzvf "$latest_backup" -C .
        echo "Backup restaurado: $latest_backup"
    fi
}

# Menú interactivo
while true; do
    echo "Selecciona una opción:"
    options=("Establecer permisos" "Iniciar contenedores" "Detener contenedores" \
             "Ver logs" "Guardar backup" "Restaurar backup" "Salir")
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
done
