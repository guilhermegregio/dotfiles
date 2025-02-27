{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellApplication {
  name = "verify-app";

  # Lista de dependências necessárias para o script
  runtimeInputs = with pkgs; [
    bash
    # Se seu script precisar do gradle, você deve incluí-lo aqui
    # gradle
  ];

  text = ''
    #!/usr/bin/env bash

    # Script para executar comandos gradle com parâmetros personalizados
    # Uso: gradle-runner <tribe> <product> [print]

    # Verificar se foram fornecidos pelo menos 2 parâmetros
    if [ $# -lt 2 ]; then
        echo "Uso: $0 <tribe> <product> [print]"
        echo "  tribe: nome da tribe (ex: engagement)"
        echo "  product: nome do produto (ex: credit-transparency)"
        echo "  print: (opcional) true para apenas imprimir o comando, false para executá-lo"
        echo "         se não for fornecido, o comando será executado"
        exit 1
    fi

    # Capturar os parâmetros
    TRIBE=$1
    PRODUCT=$2
    PRINT=''${3:-false}  # Valor padrão é false se não for fornecido

    # Verificar se o parâmetro print é válido
    if [ "$PRINT" != "true" ] && [ "$PRINT" != "false" ]; then
        echo "Erro: O parâmetro 'print' deve ser 'true' ou 'false'"
        exit 1
    fi

    # Construir o comando
    COMMAND="./gradlew \\
    :products:$TRIBE:$PRODUCT:android-ui:detekt \\
    :products:$TRIBE:$PRODUCT:android-ui:lintKotlinAndroidTest \\
    :products:$TRIBE:$PRODUCT:android-ui:lintKotlinDebug \\
    :products:$TRIBE:$PRODUCT:android-ui:lintKotlinTest \\
    :products:$TRIBE:$PRODUCT:android-ui:lintKotlinTestFixtures \\
    :products:$TRIBE:$PRODUCT:android-ui:lintKotlin \\
    :products:$TRIBE:$PRODUCT:common:lintKotlinCommonMain \\
    :products:$TRIBE:$PRODUCT:common:lintKotlinCommonTest \\
    :products:$TRIBE:$PRODUCT:common:lintKotlinIosMain \\
    :products:$TRIBE:$PRODUCT:common:kspReleaseKotlinAndroid \\
    :products:$TRIBE:$PRODUCT:common:compileReleaseKotlinAndroid \\
    :products:$TRIBE:$PRODUCT:common:test \\
    :products:$TRIBE:$PRODUCT:android-ui:detekt \\
    :products:$TRIBE:$PRODUCT:common:detekt \\
    :products:$TRIBE:$PRODUCT:android-ui:compileDebugUnitTestKotlin \\
    :products:$TRIBE:$PRODUCT:common:compileDebugUnitTestKotlin \\
    :products:$TRIBE:$PRODUCT:android-ui:verifyPaparazziDebug \\
    :products:$TRIBE:$PRODUCT:common:compileCommonMainKotlinMetadata"

    # Executar ou imprimir o comando conforme o parâmetro print
    if [ "$PRINT" = "true" ]; then
        echo "$COMMAND"
    else
        eval "$COMMAND"
    fi
  '';
}
