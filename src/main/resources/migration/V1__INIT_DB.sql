--
-- Пользователи
--

CREATE TABLE `address` (
  `id_address` bigint(20) NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `house` varchar(255) DEFAULT NULL,
  `apartment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `user` (
  `id_user` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `id_address` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  KEY `fk_user_address` (`id_address`),
  CONSTRAINT `fk_user_address` FOREIGN KEY (`id_address`) REFERENCES `address` (`id_address`) ON DELETE SET NULL ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `role` (
  `id_role` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `user_role` (
  `id_user` bigint(20) NOT NULL,
  `id_role` bigint(20) NOT NULL,
  PRIMARY KEY (`id_user`,`id_role`),
  KEY `fk_rores_role` (`id_role`),
  KEY `fk_roles_user` (`id_user`),
  CONSTRAINT `fk_rores_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`),
  CONSTRAINT `fk_roles_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Модель и комплектующие
--

CREATE TABLE `company` (
  `id_company` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `country` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `cpu` (
  `id_cpu` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `beans` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `bit` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_cpu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `gpu` (
  `id_gpu` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `frequency` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_gpu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `material` (
  `id_material` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id_material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `resolution` (
  `id_resolution` bigint(20) NOT NULL AUTO_INCREMENT,
  `resolution` int(11) DEFAULT NULL,
  `resolutionx` int(11) NOT NULL,
  `resolutiony` int(11) NOT NULL,
  PRIMARY KEY (`id_resolution`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `display_type` (
  `name` varchar(40) NOT NULL,
  `id_display_type` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_display_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `display` (
  `id_display` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `id_display_type` bigint(20) DEFAULT NULL,
  `id_resolution` bigint(20) DEFAULT NULL,
  `diagonal` float DEFAULT NULL,
  `density` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_display`),
  KEY `fk_display_type` (`id_display_type`),
  KEY `fk_display_resolution` (`id_resolution`),
  CONSTRAINT `fk_display_resolution` FOREIGN KEY (`id_resolution`) REFERENCES `resolution` (`id_resolution`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_display_type` FOREIGN KEY (`id_display_type`) REFERENCES `display_type` (`id_display_type`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `camera` (
  `id_camera` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `id_resolution_photo` bigint(20) DEFAULT NULL,
  `id_resolution_video` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_camera`),
  KEY `fk_camera_video` (`id_resolution_video`),
  KEY `fk_camera_photo` (`id_resolution_photo`),
  CONSTRAINT `fk_camera_photo` FOREIGN KEY (`id_resolution_photo`) REFERENCES `resolution` (`id_resolution`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_camera_video` FOREIGN KEY (`id_resolution_video`) REFERENCES `resolution` (`id_resolution`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `model` (
  `id_model` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text,
  `count_sim` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `power` int(11) DEFAULT NULL,
  `id_company` bigint(20) DEFAULT NULL,
  `id_cpu` bigint(20) DEFAULT NULL,
  `id_gpu` bigint(20) DEFAULT NULL,
  `id_material` bigint(20) DEFAULT NULL,
  `id_display` bigint(20) DEFAULT NULL,
  `id_camera_main` bigint(20) DEFAULT NULL,
  `id_camera_add` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_model`),
  UNIQUE KEY `UK_ca0u5wgwbvi61aty72boerxqy` (`name`),
  KEY `fk_model_company` (`id_company`),
  KEY `fk_model_cpu` (`id_cpu`),
  KEY `fk_model_gpu` (`id_gpu`),
  KEY `fk_model_material` (`id_material`),
  KEY `fk_model_display` (`id_display`),
  KEY `fk_model_camera_add` (`id_camera_add`),
  KEY `fk_model_camera_main` (`id_camera_main`),
  CONSTRAINT `fk_model_camera_add` FOREIGN KEY (`id_camera_add`) REFERENCES `camera` (`id_camera`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_model_camera_main` FOREIGN KEY (`id_camera_main`) REFERENCES `camera` (`id_camera`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_model_company` FOREIGN KEY (`id_company`) REFERENCES `company` (`id_company`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_model_cpu` FOREIGN KEY (`id_cpu`) REFERENCES `cpu` (`id_cpu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_model_gpu` FOREIGN KEY (`id_gpu`) REFERENCES `gpu` (`id_gpu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_model_display` FOREIGN KEY (`id_display`) REFERENCES `display` (`id_display`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_model_material` FOREIGN KEY (`id_material`) REFERENCES `material` (`id_material`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Продукт (Телефон)
--

CREATE TABLE `color` (
  `id_color` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id_color`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `model_color` (
  `id_model_color` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_model` bigint(20) NOT NULL,
  `id_color` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_model_color`),
  KEY `fk_model_color` (`id_color`),
  KEY `fk_base_model_color` (`id_model`),
  CONSTRAINT `fk_base_model_color` FOREIGN KEY (`id_model`) REFERENCES `model` (`id_model`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_model_color` FOREIGN KEY (`id_color`) REFERENCES `color` (`id_color`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `model_photo` (
  `id_model_photo` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_model_color` bigint(20) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id_model_photo`),
  KEY `fk_model_photo` (`id_model_color`),
  CONSTRAINT `fk_model_photo` FOREIGN KEY (`id_model_color`) REFERENCES `model_color` (`id_model_color`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `os` (
  `id_os` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id_os`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `product` (
  `id_product` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_model_color` bigint(20) DEFAULT NULL,
  `id_os` bigint(20) DEFAULT NULL,
  `ram` int(11) DEFAULT NULL,
  `storage` int(11) DEFAULT NULL,
  `cost` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_product`),
  KEY `fk_product_model_color` (`id_model_color`),
  KEY `fk_product_os` (`id_os`),
  CONSTRAINT `fk_product_model_color` FOREIGN KEY (`id_model_color`) REFERENCES `model_color` (`id_model_color`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_os` FOREIGN KEY (`id_os`) REFERENCES `os` (`id_os`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Заказы
--

CREATE TABLE `delivery` (
  `id_delivery` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `cost` int(11) NOT NULL,
  PRIMARY KEY (`id_delivery`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `order` (
  `id_order` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) DEFAULT NULL,
  `id_delivery` bigint(20) DEFAULT NULL,
  `id_address` bigint(20) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `id_order_state` int(11) DEFAULT NULL,
  `date_order` bigint(20) DEFAULT NULL,
  `date_delivery` bigint(20) DEFAULT NULL,
  `date_completed` bigint(20) DEFAULT NULL,
  `full_sum` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_order`),
  KEY `fk_order_address` (`id_address`),
  KEY `fk_order_delivery` (`id_delivery`),
  KEY `fk_order_user` (`id_user`),
  CONSTRAINT `fk_order_address` FOREIGN KEY (`id_address`) REFERENCES `address` (`id_address`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_order_delivery` FOREIGN KEY (`id_delivery`) REFERENCES `delivery` (`id_delivery`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `order_product` (
  `id_order` bigint(20) NOT NULL,
  `id_product` bigint(20) NOT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_product`,`id_order`),
  KEY `fk_bucket_order` (`id_order`),
  CONSTRAINT `fk_bucket_order` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_bucket_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Комментарии
--

CREATE TABLE `comment` (
  `id_comment` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_user` bigint(20) DEFAULT NULL,
  `id_model` bigint(20) DEFAULT NULL,
  `message` text,
  `rating` int(11) DEFAULT NULL,
  `date_created` bigint(20) DEFAULT NULL,
  `date_updated` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_comment`),
  KEY `fk_model_comment` (`id_model`),
  KEY `fk_user_comment` (`id_user`),
  CONSTRAINT `fk_model_comment` FOREIGN KEY (`id_model`) REFERENCES `model` (`id_model`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_comment` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `comment_photo` (
  `id_photo` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_comment` bigint(20) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id_photo`),
  KEY `fk_comment_photo` (`id_comment`),
  CONSTRAINT `fk_comment_photo` FOREIGN KEY (`id_comment`) REFERENCES `comment` (`id_comment`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;