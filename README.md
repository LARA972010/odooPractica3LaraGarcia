# Configuración de Odoo - Práctica 3 (SGE 2024-2025)

Este repositorio contiene los archivos y configuraciones necesarias para completar la *Práctica 3* del curso de SGE (Sistemas de Gestión Empresarial). En esta práctica, configuré un entorno Odoo para gestionar la venta de productos, el registro de clientes y la configuración de diferentes módulos y servicios dentro de la plataforma Odoo.

## Estructura del Proyecto

Este repositorio incluye los siguientes elementos:

- **Archivo `.env`**: Contiene las variables de entorno necesarias para la configuración de los servicios en el entorno Odoo.
- **Archivo `docker-compose.yml`**: Usado para levantar los contenedores Docker con los servicios necesarios para el entorno Odoo.
- **Configuración de Odoo**: Archivos de configuración de Odoo para asegurar que se ajuste a los requisitos del proyecto.
- **Archivos de configuración de correo**: Configuración de las pasarelas de correo electrónico saliente y entrante para Odoo.
- **Archivos de módulos**: Instalación de varios módulos que mejoran la funcionalidad de Odoo, como **Contactos**, **Adaptación para España (l10n-spain)** y **Web Responsive**.

## Pasos Realizados

### 1. Configuración del Entorno

- **Preparación inicial**:
  - Descargué el archivo `.zip` desde el aula virtual y lo descomprimí en una carpeta con el nombre `SGE-pr3-nombre.apellidos`.
  - Ejecuté el script `menu.sh` para configurar los permisos necesarios y el entorno.
  - Modifiqué el archivo `.env` de acuerdo con el número de puesto asignado y configuré las variables de entorno para el acceso a los servicios de Odoo.

### 2. Instalación y Configuración de Módulos en Odoo

- **Configuración de idioma y base de datos**:
  - Configuré Odoo en **Español/España** y aseguré que no se usaran datos de prueba.
  - Instalé el módulo **Contactos** y configuré la base de datos con el nombre `cañaveral-XX` y el correo de administrador `admin@canaveral-XX.sge`.

- **Módulos adicionales**:
  - Instalé el módulo **Adaptación de los clientes, proveedores y bancos para España** desde el repositorio **OCA/l10n-spain**.
  - Instalé el módulo **Web Responsive** desde Odoo Apps, mejorando la interfaz de usuario para dispositivos móviles.

### 3. Configuración de Servicios de Correo

- **Correo saliente**: 
  - Configuré la pasarela de correo saliente con el correo del administrador y la contraseña `pass`.
  
- **Correo entrante**: 
  - Configuré una pasarela segura de correo electrónico entrante para el administrador, con la opción de mantener los mensajes en el servidor y que Odoo cree nuevos contactos a partir de los correos entrantes.

### 4. Creación de Producto y Cliente

- **Producto**:
  - Creé un producto denominado **RASPBERRY PI_XX** con las características solicitadas: 
    - Precio de venta: 48 €
    - Coste de abastecimiento: 24 €
    - Tipo de producto: Consumible
    - Añadí una imagen representativa de una Raspberry Pi.

- **Cliente**:
  - Creé un cliente denominado `GXX_cliente`, asigné la zona horaria correcta y configuré el acceso al portal de la empresa.
  
### 5. Proceso de Venta

- **Creación de presupuesto**:
  - El empleado envió un presupuesto por correo electrónico al cliente para 3 unidades de **RASPBERRY PI_XX**.
  
- **Confirmación de venta y factura**:
  - Tras la aceptación del presupuesto, el empleado confirmo la venta, generó la factura y la validó.
  
- **Registro de pago**:
  - El empleado registró el pago de la factura a través de la cuenta bancaria configurada.

### 6. Canal de Comunicación

- **Canal de comunicación**: 
  - Creé un canal en Odoo denominado **BARBACOA DE LOS SÁBADOS** en el que el empleado, el administrador y el cliente pudieron interactuar.

### 7. Copia de Seguridad

- **Copia de seguridad de la base de datos**:
  - Realicé una copia de seguridad de la base de datos utilizando `pg_dump` para asegurar la integridad de los datos.


## Requisitos

- **Docker** y **Docker Compose** instalados para levantar el entorno Odoo.
- **pgAdmin4** para la gestión de la base de datos y la verificación de tablas.
- **Acceso a GreenMail** para obtener las direcciones de correo electrónico necesarias para la práctica.


---

¡Gracias por revisar este proyecto!