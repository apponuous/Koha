INSERT INTO permissions (module_bit, code, description) VALUES
   ( 1, 'circulate_remaining_permissions', 'Fonctions de circulation restantes'),
   ( 1, 'override_renewals', 'Outrepasser les limites de renouvellement'),
   ( 6, 'place_holds', 'Réserver pour des adhérents'),
   ( 6, 'modify_holds_priority', 'Modifier la priorité des réservations'),
   ( 9, 'edit_catalogue', 'Ajouter et modifier des notices au catalogue'),
   ( 9, 'fast_cataloging', 'Catalogage rapide'),
   ( 9, 'edit_items', 'Modifier des exemplaires'),
   (13, 'edit_news', 'Ecrire des nouvelles pour l''OPAC et l''interface professionnelle'),
   (13, 'label_creator', 'Créer des étiquettes à partir des données du catalogues et des adhérents'),
   (13, 'edit_calendar', 'Définir les jours de fermeture de la bibliothèque'),
   (13, 'moderate_comments', 'Modérer les commentaires des adhérents'),
   (13, 'edit_notices', 'Définir les notifications'),
   (13, 'edit_notice_status_triggers', 'Définir les déclencheurs de notification de retard'),
   (13, 'edit_quotes', 'Edit quotes for quote-of-the-day feature'),
   (13, 'view_system_logs', 'Parcourir les journaux de l''activité du système'),
   (13, 'inventory', 'Réaliser les tâches de récolement'),
   (13, 'stage_marc_import', 'Importer des notices MARC dans le réservoir'),
   (13, 'manage_staged_marc', 'Gérer les notices du réservoir, les charger ou annuler leur chargement'),
   (13, 'export_catalog', 'Exporter des notices bibliographiques et leurs exemplaires'),
   (13, 'import_patrons', 'Importer des données d''adhérents'),
   (13, 'edit_patrons', 'Modification par lot des lecteurs'),
   (13, 'delete_anonymize_patrons', 'Supprimer les anciens adhérents et anonymiser l''historique des prêts (supprime l''historique des prêts des lecteurs'),
   (13, 'batch_upload_patron_images', 'Charger sur le serveur les images des adhérents par lot ou un par un'),
   (13, 'schedule_tasks', 'Planifier les tâches à exécuter'),
   (11, 'vendors_manage', 'Gérer les fournisseurs'),
   (11, 'contracts_manage', 'Gérer les contrats'),
   (11, 'period_manage', 'Gérer les périodes'),
   (11, 'budget_manage', 'Gérer les budgets'),
   (11, 'budget_modify', 'Modifier les budgets (impossible de créer les lignes, mais possible de modifier celles qui existent'),
   (11, 'planning_manage', 'Gérer de la planification des budgets'),
   (11, 'order_manage', 'Gérer les commandes et les paniers'),
   (11, 'group_manage', 'Gérer les commandes et les bons de commande'),
   (11, 'order_receive', 'Gérer les réceptions'),
   (11, 'budget_add_del', 'Ajouter et supprimer les budgets (mais pas modifier)'),
   (11, 'budget_manage_all', 'Gérer tous les budgets'),
   (13, 'manage_csv_profiles', 'Gérer les profils d''export CSV'),
   (13, 'moderate_tags', 'Modérer les tags des adhérents'),
   (13, 'rotating_collections', 'Gérer les collections tournantes'),
   (13, 'items_batchmod', 'Modifier les exemplaires par lot'),
   (13, 'items_batchdel', 'Supprimer les exemplaires par lot'),
   (13, 'upload_local_cover_images', 'Téléchargement des images de couverture'),
   (15, 'check_expiration', 'Contrôler l''expiration d''un périodique'),
   (15, 'claim_serials', 'Réclamer les périodiques manquants'),
   (15, 'create_subscription', 'Créer de nouveaux abonnements'),
   (15, 'delete_subscription', 'Supprimer un abonnement existant'),
   (15, 'edit_subscription', 'Modifier un abonnement existant'),
   (15, 'receive_serials', 'Bulletiner les périodiques'),
   (15, 'renew_subscription', 'Renouveler les abonnements'),
   (15, 'routing', 'Mettre en circulation'),
   (16, 'execute_reports', 'Lancer les rapports SQL'),
   (16, 'create_reports', 'Créer les rapports SQL Reports')

;
