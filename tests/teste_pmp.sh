#!/bin/bash

# Lista dos arquivos txt
arquivos=(
    "PM_I_50_10_S_1-9_1_FortyAgent.txt"
    "PM_I_50_15_S_1-9_1_FortyAgent.txt"
    "PM_I_50_20_S_1-9_1_FortyAgent.txt"
    "PM_I_50_25_S_1-9_1_FortyAgent.txt"
    "PM_I_50_10_S_1-49_1_FortyAgent.txt"
    "PM_I_50_10_S_1-99_1_FortyAgent.txt"
    "PM_I_50_15_S_1-49_1_FortyAgent.txt"
    "PM_I_50_15_S_1-99_1_FortyAgent.txt"
    "PM_I_50_20_S_1-49_1_FortyAgent.txt"
    "PM_I_50_20_S_1-99_1_FortyAgent.txt"
    "PM_I_50_25_S_1-49_1_FortyAgent.txt"
    "PM_I_50_25_S_1-99_1_FortyAgent.txt"
    "PM_I_100_10_S_1-9_1_FortyAgent.txt"
    "PM_I_100_15_S_1-9_1_FortyAgent.txt"
    "PM_I_100_20_S_1-9_1_FortyAgent.txt"
    "PM_I_100_25_S_1-9_1_FortyAgent.txt"
    "PM_I_50_10_S_1-124_1_FortyAgent.txt"
    "PM_I_50_15_S_1-124_1_FortyAgent.txt"
    "PM_I_50_20_S_1-124_1_FortyAgent.txt"
    "PM_I_50_25_S_1-124_1_FortyAgent.txt"
    "PM_I_100_10_S_1-49_1_FortyAgent.txt"
    "PM_I_100_10_S_1-99_1_FortyAgent.txt"
    "PM_I_100_15_S_1-49_1_FortyAgent.txt"
    "PM_I_100_15_S_1-99_1_FortyAgent.txt"
    "PM_I_100_20_S_1-49_1_FortyAgent.txt"
    "PM_I_100_20_S_1-99_1_FortyAgent.txt"
    "PM_I_100_25_S_1-49_1_FortyAgent.txt"
    "PM_I_100_25_S_1-99_1_FortyAgent.txt"
    "PM_I_100_10_S_1-124_1_FortyAgent.txt"
    "PM_I_100_15_S_1-124_1_FortyAgent.txt"
    "PM_I_100_20_S_1-124_1_FortyAgent.txt"
    "PM_I_100_25_S_1-124_1_FortyAgent.txt"
)

# Texto a ser encontrado
texto_encontrar="Number_Of_Methods: 30"

echo $texto_encontrar

# Texto para substituição
texto_substituicao="Number_Of_Methods: 40"

# Loop através dos arquivos
for arquivo in "${arquivos[@]}"
do
    # Verifica se o arquivo existe
    if [ -e "$arquivo" ]; then
        # Encontra e substitui o texto
        sed -i "s/$texto_encontrar/$texto_substituicao/g" "$arquivo"
        echo "Texto substituído em $arquivo"
    else
        echo "Arquivo $arquivo não encontrado"
    fi
done

