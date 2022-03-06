#!/bin/bash
if [ $# -eq 0 ]; then
    install_check=$(sudo systemctl status vsftpd)
    if [ $? -eq 0 ]; then
        printf  "           El servicio ftp está instalado. Elija una opción\n
        ------------
        1. Status.\n
        ------------
        --------------------------------
        2. Configuración del servicio.\n
        --------------------------------
        ---------------------------
        3. Reiniciar el servicio.\n
        ---------------------------
        -----------------------------
        4. Desinstalar el servicio.\n
        -----------------------------
        ------------
        5. Salir.\n"
        read opcion

        while (( "$opcion" != 5 ))
        do
            if [ "$opcion" -eq 1 ]; then
                sudo systemctl status vsftpd
                
            
            elif [ "$opcion" -eq 2 ]; then
                echo "                  CONFIGURACION FTP "

                echo ""

                printf  "               ¿Elija que configuraciones desea añadir al FTP?\n
                ---------------------------- 
                1.  Habilitar escritura.\n 
                ---------------------------- 
                ---------------------------- 
                2.  Deshabilitar escritura.\n 
                ----------------------------
                --------------------------------------------
                3.  Habilitar loggin de usuarios locales.\n |
                --------------------------------------------
                -----------------------------------------------
                4.  Deshabilitar loggin de usuarios locales.\n 
                -----------------------------------------------
                -----------------------------
                5.  Habilitar usuario anónimo.\n
                -----------------------------
                ---------------------------- 
                6.  Deshabilitar usuario anónimo.\n
                ---------------------------- 
                ---------------------------- 
                7.  Permitir subida de archivos de anónimo.\n
                ---------------------------- 
                ---------------------------- 
                8.  Denegar subida de archivos de anónimo.\n
                ---------------------------- 
                ---------------------------- 
                9.  Crear carpeta anónimo.\n
                ---------------------------- 
                ---------------------------- 
                10. Borrar carpeta anónimo.\n
                ---------------------------- 
                ---------------------------- 
                11. Salir.\n"
             
                read opcion1

                while (( "$opcion1" != 11 ))
                do
                    if [ "$opcion1" -eq 1 ]; then 
                        sudo sed -i '/write_enable/c\write_enable=YES' /etc/vsftpd.conf
                        echo "              Escritura habilitada                "

                    
                    elif [ "$opcion1" -eq 2 ]; then
                        sudo sed -i '/write_enable/c\write_enable=NO' /etc/vsftpd.conf
                        echo "             Escritura deshabilitada              "

                    
                    elif [ "$opcion1" -eq 3 ]; then
                        sudo sed -i '/local_enable/c\local_enable=YES' /etc/vsftpd.conf
                        echo "              Loggins de usuarios locales habilitados     "
                    
                    
                    elif [ "$opcion1" -eq 4 ]; then
                        sudo sed -i '/local_enable/c\local_enable=NO' /etc/vsftpd.conf
                        echo "              Loggins de usuarios locales deshabilitados"
                    
                    
                    elif [ "$opcion1" -eq 5 ]; then
                        sudo sed -i '/anonymous_enable/c\anonymous_enable=YES' /etc/vsftpd.conf
                        echo "              Usuario anónimo habilitado"

                    
                    elif [ "$opcion1" -eq 6 ]; then
                        sudo sed -i '/anonymous_enable/c\anonymous_enable=NO' /etc/vsftpd.conf
                        echo "              Usuario anónimo deshabilitado"
                    
                    elif [ "$opcion1" -eq 7 ]; then
                        sudo sed -i '/anon_upload_enable/c\anonymous_enable=YES' /etc/vsftpd.conf
                        echo "              Subida de archivos para anónimo aceptada"
                    
                    elif [ "$opcion1" -eq 8 ]; then
                        sudo sed -i '/anon_upload_enable/c\anonymous_enable=NO' /etc/vsftpd.conf
                        echo "              Subida de archivos para anónimo denegada"
                    
                    
                    elif [ "$opcion1" -eq 9 ]; then
                        sudo sed -i '/anonymous_enable/a\anon_root=/home/FTPanon' /etc/vsftpd.conf
                        sudo mkdir /home/FTPanon
                        echo "              Carpeta creada para anónimo"

                    elif [ "$opcion1" -eq 10 ]; then
                        sudo sed -i '/anon_root/d' /etc/vsftpd.conf
                        sudo rm -R /home/FTPanon
                        echo "              Carpeta eliminada para anónimo"
                    
                    elif [ "$opcion1" -eq 11 ]; then
                        printf "Volviendo a menú principal\n."
                    
                    else
                        echo "Introduce una opción correcta."

                    fi

                    printf  "           ¿Elija que configuraciones desea añadir al FTP?\n
                    -----------------------
                    1. Habilitar escritura.\n
                    -----------------------------
                    2. Deshabilitar escritura.\n
                    ------------------------------------------
                    3. Habilitar loggin de usuarios locales.\n
                    ------------------------------------------
                    4. Deshabilitar loggin de usuarios locales.\n
                    -------------------------------
                    5. Habilitar usuario anónimo.\n
                    -------------------------------
                    6. Deshabilitar usuario anónimo.\n
                    --------------------------------------------
                    7. Permitir subida de archivos de anónimo.\n
                    --------------------------------------------
                    8. Denegar subida de archivos de anónimo.\n
                    ----------------------------
                    9. Crear carpeta anónimo.\n
                    ----------------------------
                    10.Borrar carpeta anónimo.\n
                    -----------------------------------------------------
                    11.Salir de configuración y reiniciar el servicio.\n"
                    read opcion1
                done
            elif [ "$opcion" -eq 3 ]; then
                echo "          Servicio reiniciado"
                sudo systemctl restart vsftpd


            elif [ "$opcion" -eq 4 ]; then 
                "               ADVERTENCIA VA A DESINSTALAR EL SERVICIO"
                sudo apt-get autoremove --purge vsftpd
                break
            
            elif [ "$opcion" -eq 5 ]; then
                echo "Adios."
            
            else
                echo "          Introduce una opción correcta."
            fi

            printf  "           El servicio ftp está instalado. ¿Qué desea hacer?\n
            ------------------------------------
            1. Status.\n
            --------------------------
            2. Configurar el servicio.\n
            ---------------------------
            3. Reiniciar el servicio.\n
            -----------------------------
            4. Desinstalar el servicio.\n
            ------------
            5. Salir.\n"
            read opcion
        done
    else
        printf "            El servicio ftp no está instalado. ¿Qué desea hacer?\n
        1.- Instalar ftp.\n
        2.- Salir\n"
        read opcion

        if [ "$opcion" -eq 1 ]; then
            sudo apt-get update
            sudo apt-get upgrade
            sudo apt-get install vsftpd
            if [ $? -eq 0 ]; then
                echo "El servicio de ftp se ha instalado correctamente."

            else 
                echo "No se ha podido instalar el servicio."
            fi
        else
            echo "Adios."
            exit
        fi
    fi

else
    echo "Este script no necesita parámetros"
fi
