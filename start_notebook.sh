#!/bin/bash

# Démarre Jupyter Notebook et redirige la sortie vers un fichier de log
jupyter notebook --ip=0.0.0.0 --port=80 --no-browser --allow-root > jupyter_log.txt 2>&1 &

# Attendez que le serveur Jupyter démarre
sleep 10

# Extraire le token du fichier de log
token=$(grep -oP '(?<=token=)[a-f0-9]+' jupyter_log.txt)

# Exporter le token dans une variable d'environnement
export JUPYTER_TOKEN=$token

# Affiche le token pour vérification
echo "Jupyter Notebook token: $JUPYTER_TOKEN"

# Garder le conteneur en cours d'exécution
# tail -f /dev/null
