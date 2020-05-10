# scenarios

données :
    -   15 minutes par livraison (1 créneau)
    -   180 minutes de révision (12 créneaux) (toutes les 20h (en fin de journée))
    -   60 minutes de charge (4 créneaux) (toutes les 45 minutes (3 créneaux))

## 1

Ajouter un drone au système
Ajouter 10 livraisons au planning (vérifier que les 10 livraisons ne peuvent pas être mis à la même heure)
Vérifier que les plages de chargement sont aux bons endroits
Lancer 3 livraisons (getNextDelivery pour avoir l'ID de la delivery) et attendre son retour (tester s'il revient et qu'il a ou pas un colis)
Mettre le drone en charge, puis en révision

    -   au démarrage
        - système drone delivery clean
        - drone api (aucun drone)
        - carrier api (15 colis disponible)
