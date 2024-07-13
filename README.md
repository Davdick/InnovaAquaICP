# InnovaAquaICP

Proyecto para la Hackathon Hidrotechs 2024, auspiciada por ICO.HUB México

## Integrantes

Estudiantes de la Universidad Tecnológica de Aguascalientes:

-   Bernal Gutiérrez, Juan Felipe
-   Figueroa Jasso, David
-   Pérez Cervantes, Ricardo Emmanuel

## Concepto

**InnovaAquaICP** es un proyecto que propone la homologación de los [Árboles Inteligentes de Singapur](https://rosstours.com/singapore-super-trees/) en la ciudad de Aguascalientes para la optimización en la recolección y monitoreo del agua de origen pluvial.

## Objetivo

-   **_Conservación del agua_**: Reducción de la demanda de agua potable mediante la reutilización y aprovechamiento del agua pluvial
-   **_Gestión Sostenible de Recursos Hídricos_**: Promoción de prácticas de gestión de sostenible del agua para disminuir la presión sobre las fuentes subterráneas y superficiales
-   **_Reducción del Desperdicio_**: Minimización de la cantidad de agua lluvia perdida en el alcantarillado, evitando inundaciones y desbordamientos.

## Beneficios

-   **_Sostenibilidad Ambiental_**: Reducción de la demanda sobre las fuentes de agua potable y disminución de carga sobre el sistema de alcantarillado.
-   **_Ahorro Económico_**: Disminución en costos de agua para usuarios en áreas de altas tarifas de agua potable.
-   **_Resiliencia Hídrica_**: Creación de una fuente adicional de agua, valiosa en tiempos de sequía.

## Descripción Técnica

### Componentes Principales del Sistema

1. Sistema de Captación de Agua de Lluvia

-   **Superficies de captación**: Techos y otras superficies impermeables diseñadas para recolectar agua de lluvia.
-   **Canaletas y bajantes**: Tuberías que dirigen el agua de las superficies de captación hacia el sistema de almacenamiento.

2. Sistema de Almacenamiento

-   **Tanques de almacenamiento**: Contenedores de gran capacidad (subterráneos o superficiales) hechos de materiales resistentes a la corrosión, como polietileno o fibra de vidrio.
-   **Filtros Primarios**: Filtros gruesos que eliminan hojas, escombros y otros contaminantes grandes antes de que el agua sea almacenada.

3. Sistema de Filtración y Tratamiento

-   **Filtros de Sedimentos**: Elminan partículas finas del agua.
-   **Filtros de Carbón Activado**: Eliminan olores y contaminantes químicos del agua.
-   **Tratamiento UV**: Desinfecta el agua eliminando microorganismos y patógenos.

4. Sistema de Distribución

-   **Bombas**: Equipos para presurizar el agua almacenada y distribuirla a diferentes puntos de uso.
-   **Red de Tuberías**: Conexiones que llevan el agua tratada a inodors, sistemas de riego, lavadoras y otras aplicaciones no potables.

### Componentes Tecnológicos del Sistema ICP

1. Canister ICP (Dashboard y API)

-   **Desarrollo**: Programado en Motoko, el canister actúa como el backend del sistema.
-   **Funciones**: Almacena datos, procesa solicitudes y gestiona la lógica del sistema. Proporciona una API para la comunicación con dispositivos externos.
-   **Despliegue**: Se despliega en la red de Internet Computer, asegurando alta disponibilidad y escalabilidad.

2. Interfaz de Usuario (Dashboard)

-   **Frontend**: Desarrollado con HTML5, CSS3 y JavaScript Vanilla.
-   **Funciones**: Permite a los usuarios visualizar los datos en tiempo real sobre los niveles de agua, calidad del agua y estadísticas de uso.
-   **Conexión a la API**: Interactúa con el canister a través de llamadas a la API para obtener y actualizar datos.

3. ESP32 (Módulo IoT):

-   **Programación**: Utiliza Arduino para la programación y configuración.
-   **Sensores Conectados**: Recolecta datos de sensores de nivel de agua, calidad del agua y otros parámetros relevantes.
-   **Comunicación**: Envía datos a lcanister a través de peticiones HTTP.
