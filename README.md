# {Proyecto: Nombre del Proyecto Simulado}  
![MIT License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)  
![Maintained](https://img.shields.io/badge/status-maintained-brightgreen?style=for-the-badge)  
[![RoboDK](https://img.shields.io/badge/Uses-RoboDK-blue?style=for-the-badge&logo=robodk)](https://robodk.com/)  
[![Webots](https://img.shields.io/badge/Uses-Webots-cc3333?style=for-the-badge&logo=cyberbotics&logoColor=white)](https://cyberbotics.com/)  
![Gazebo](https://img.shields.io/badge/Gazebo-black?style=for-the-badge&logo=ros&logoColor=white)  
![ROS](https://img.shields.io/badge/ROS-22314E?style=for-the-badge&logo=ros&logoColor=white)  
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)  
![C++](https://img.shields.io/badge/C++-00599C?style=for-the-badge&logo=c%2B%2B&logoColor=white)  
![MATLAB](https://img.shields.io/badge/MATLAB-0076A8?style=for-the-badge&logo=mathworks&logoColor=white)  

Breve descripción del proyecto

---

## 📋 Requisitos Previos

- Conocimiento sólido de **diseño digital**, incluyendo lógica combinacional, circuitos secuenciales y máquinas de estados.  
- Experiencia en **programación y simulación en VHDL**, así como en el manejo de arquitecturas secuenciales.  
- Conocimientos básicos de **implementación en FPGA**, síntesis, asignación de pines y depuración en hardware real.  
- Un entorno de trabajo con **Windows o Linux**, acceso a internet, un **cable Micro-USB** y una **FPGA** (Basys 3 o cualquier FPGA compatible con Vivado).
  
- **Xilinx Vivado**  
  - Para síntesis del diseño  
  - Implementación 
  - Programación del FPGA  
  - Análisis y depuración en hardware  

- **Active-HDL (Aldec)**  
  - Para simulación funcional del diseño  
  - Ejecución de testbench  
  - Depuración previa a la síntesis  
  - Visualización de señales y verificación del comportamiento temporal

---

## 📖 Introducción

Este proyecto implementa una máquina expendedora digital capaz de seleccionar entre varios productos, aceptar monedas de diferentes denominaciones, mostrar el saldo en displays de siete segmentos y dispensar el producto con opción de cambio. El propósito principal es diseñar y validar un sistema secuencial completo utilizando VHDL, abordando problemas reales como el control de estados, conteo de monedas, gestión de precios y visualización en hardware. La simulación en **Active-HDL** permitió verificar el funcionamiento del sistema, probar la máquina de estados y depurar el diseño sin necesidad inicial de hardware físico, facilitando la experimentación segura y rápida. Posteriormente, el diseño fue sintetizado e implementado en una **FPGA Basys 3 mediante Xilinx Vivado**, lo que permitió validar el comportamiento en un entorno real mediante switches, botones y displays integrados. Este tipo de proyectos tiene aplicaciones educativas en cursos de diseño digital y arquitectura de sistemas, así como aplicaciones industriales en sistemas embebidos de control, automatización y prototipado rápido de dispositivos interactivos.

---

## 🔧 Entorno de Simulación

Para el desarrollo y validación del sistema se utilizó un entorno de simulación que permite analizar el comportamiento del diseño en tiempo real antes de llevarlo a la implementación física. El simulador principal empleado fue **Active-HDL**, una herramienta ampliamente utilizada en la industria académica y profesional por su capacidad para depurar, visualizar señales y ejecutar testbenches de manera eficiente. Aunque es compatible con múltiples plataformas, se recomienda trabajar sobre **Windows 10 o superior**, debido a su estabilidad y soporte completo para las herramientas de Aldec. Para asegurar una experiencia fluida, el equipo de desarrollo debe contar al menos con **8 GB de RAM**, un **procesador de cuatro núcleos** y, opcionalmente, una **GPU integrada** capaz de manejar interfaces gráficas demandantes. Una vez verificado el correcto funcionamiento mediante simulación, el diseño fue implementado en hardware real utilizando **Vivado Design Suite**, que permitió sintetizar, implementar y programar la **FPGA Basys 3** para probar el prototipo final en condiciones operativas.```

---

## 💾 Instalación de Software

Pasos necesarios para instalar y configurar correctamente el entorno de simulación y de implementación en hardware.

### 1. Instalación del simulador Active-HDL
1. Descargar **Active-HDL Student / Educational Edition** desde el portal oficial de Aldec.  
2. Ejecutar el instalador y seguir el asistente paso a paso.  
3. Seleccionar la instalación típica, que incluye:
   - Librerías estándar IEEE para VHDL y Verilog  
   - Herramientas de simulación y análisis de ondas  
4. Activar la licencia académica (archivo o registro en línea según la versión).  
5. Verificar que el simulador se ejecute correctamente.

### 2. Instalación de Xilinx Vivado
1. Crear una cuenta en la página oficial de Xilinx/AMD si aún no se tiene.  
2. Descargar **AMD Unified Installer for FPGAs & Adaptive SoCs 2025.2** (gratuito).  
3. Ejecutar el instalador y seleccionar:
   - Soporte para dispositivos **Artix-7**  
   - Controladores Digilent para comunicación y programación  
4. Completar la instalación y reiniciar el equipo si es necesario.  
5. Abrir Vivado y confirmar que reconoce la FPGA **Basys 3** al conectar el cable USB y abrir el Hardware Manager*.

### 3. Dependencias y librerías necesarias
- Librerías IEEE de VHDL utilizadas en el proyecto:
  - `library IEEE`
  - `IEEE.STD_LOGIC_1164.ALL`
  - `IEEE.NUMERIC_STD.ALL`
- Controladores **Digilent Adept** para la comunicación JTAG/USB-UART con la Basys 3.  
- Paquetes del sistema operativo requeridos (Windows/Linux), tales como:
  - Herramientas USB  
  - Dependencias de 32 y 64 bits para Vivado (solo en Linux)  
- Espacio libre en disco recomendado:
  - Active-HDL: ~2 GB  
  - Vivado WebPACK: ~35–45 GB  

Con estas instalaciones y configuraciones, el entorno queda completamente preparado para simular el diseño, verificar su funcionamiento y finalmente implementarlo en hardware real con la tarjeta Basys 3.


---

## 🛠️ Configuración del Proyecto

FALTAAAA AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Instrucciones para clonar el repositorio, compilar, lanzar el mundo simulado y ejecutar los nodos o scripts:

```bash
git clone https://github.com/usuario/proyecto-simulacion.git
cd proyecto-simulacion
catkin_make
source devel/setup.bash
roslaunch proyecto_simulacion main.launch
```

## 💻 Programación

    ------------------------------------------------------------------------
    --  PROCESO PRINCIPAL: MÁQUINA DE ESTADOS (FSM)
    --  Controla el flujo completo de la vending machine:
    --  1. Selección de producto
    --  2. Mostrar precio
    --  3. Contar/ingresar monedas
    --  4. Entregar producto y mostrar cambio
    ------------------------------------------------------------------------
    process(current_state, s_confirm_pulse, s_producto_id, 
            s_saldo_actual, SW_confirm, s_precio_total, s_RESETFIN)
    begin
        
        --------------------------------------------------------------------
        -- Valores por defecto: Cada ciclo se limpian estas señales.
        -- Luego cada estado decide si las activa o no.
        --------------------------------------------------------------------
        next_state       <= current_state;   -- Mantener el estado por default
        s_count_enable   <= '0';             -- No contar monedas por defecto
        s_counter_reset  <= '0';             -- No resetear el contador
        s_RESETFIN       <= '0';             -- Reset interno del coin counter
        LED_OUT          <= '0';             -- LED apagado por defecto

        s_display_data   <= (others => '0'); -- Display apagado por defecto
        
        --------------------------------------------------------------------
        -- Selección del estado según la FSM
        --------------------------------------------------------------------
        case current_state is
        
        --------------------------------------------------------------------
        --  ESTADO 1 : SELECCIÓN DE PRODUCTO
        --  El usuario navega entre productos. Se muestran los IDs.
        --  Espera a que el usuario confirme la selección.
        --------------------------------------------------------------------
            when S_SELECT_PROD =>
                prender_snake <= '0';  -- Animación apagada (solo en entrega)

                -- Mostrar el ID del producto en el display (000 + ID)
                s_display_data <= ("00" & s_producto_id);

                -- Permite reset interno al módulo de monedas
                s_RESETFIN <= '1';

                -- Avanza al estado de mostrar precio si se presiona confirmar
                if s_confirm_pulse = '1' then
                    next_state <= S_SHOW_PRICE;
                end if;
        
        --------------------------------------------------------------------
        --  ESTADO 2 : MOSTRAR PRECIO
        --  Se muestra el precio del producto escogido.
        --  El usuario confirma para empezar a insertar monedas.
        --------------------------------------------------------------------
            when S_SHOW_PRICE =>
                s_display_data <= s_precio_total; -- Mostrar precio

                -- Cuando el usuario confirma, se limpia el contador de monedas
                if s_confirm_pulse = '1' then
                    s_counter_reset <= '1';        -- Reset monedas
                    next_state <= S_CONTAR_SALDO; -- Pasar a insertar dinero
                end if;

        --------------------------------------------------------------------
        --  ESTADO 3 : CONTAR SALDO
        --  Aquí se activan los contadores de monedas.
        --  Se muestra el saldo acumulado.
        --  El usuario indica que desea comprar presionando SW_confirm.
        --------------------------------------------------------------------
            when S_CONTAR_SALDO =>
                s_count_enable <= '1';         -- Habilitar contador de monedas
                s_RESETFIN     <= '0';         -- No resetear más
                s_display_data <= s_saldo_actual; -- Mostrar saldo

                -- Si el usuario confirma compra → pasar a entrega
                if SW_confirm = '1' then
                    next_state <= S_ENTREGA;
                end if;

        --------------------------------------------------------------------
        --  ESTADO 4 : ENTREGA DE PRODUCTO
        --  Se revisa si el saldo es suficiente.
        --     - Si sí: activar LED, animación snake, mostrar cambio.
        --     - Si no: regresar a seguir contando dinero.
        --  Espera el temporizador entrega_done para volver al inicio.
        --------------------------------------------------------------------
            when S_ENTREGA =>
                s_count_enable <= '0'; -- Deshabilitar conteo de monedas

                ------------------------------------------------------------
                -- Si el saldo alcanza para pagar el producto
                ------------------------------------------------------------
                if (unsigned(s_saldo_actual) >= unsigned(s_precio_total)) then

                    prender_snake <= '1'; -- Activar animación snake

                    -- Calcular el cambio (saldo - precio)
                    resta_xd <= std_logic_vector(
                                    unsigned(s_saldo_actual) - 
                                    unsigned(s_precio_total)
                               );

                    -- Mostrar cambio en el display
                    s_display_data <= resta_xd;

                    LED_OUT <= '1'; -- Encender LED de entrega

                    -- Cuando se cumple el tiempo de entrega:
                    if entrega_done = '1' then
                        next_state <= S_SELECT_PROD; -- Volver al inicio
                    end if;

                ------------------------------------------------------------
                -- Si NO hay suficiente saldo
                -- Regresar al estado para seguir insertando monedas
                ------------------------------------------------------------
                else
                    s_display_data <= s_saldo_actual; -- Mostrar saldo real
                    LED_OUT <= '0';                   -- Sin entrega
                    next_state <= S_CONTAR_SALDO;     -- Regresar por más saldo
                    prender_snake <= '0';             -- Sin animación
                end if;

        end case;
    end process;

---

## ✅ Conclusión

Resumen de lo que se logró construir, aprendizajes obtenidos y posibles mejoras o versiones futuras del proyecto.

---

## 🔜 Mejoras futuras

- Enlistar las mejoras a realizar

## ⚠️ Advertencia

Como se indica en la licencia MIT, este software/hardware se proporciona **sin ningún tipo de garantía**. Por lo tanto, ningún colaborador es responsable de **cualquier daño a tus componentes, materiales, PC, etc..**.

---

## 📚 Recursos Adicionales

---

## 👥 Autores del proyecto

Autores originales del proyecto

---

## 📬 Contacto

¿Tienes dudas o sugerencias?

- 📧 Correo electrónico: ejemplo@udlap.mx

---
