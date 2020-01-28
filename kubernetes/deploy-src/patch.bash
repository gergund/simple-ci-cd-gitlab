#!/usr/bin/env bash
sed -e 's/{VERSION}/$CI_COMMIT_SHA/' kubernetes/patch-magento2-nginx.json
sed -e 's/{VERSION}/$CI_COMMIT_SHA/' kubernetes/patch-magento2-php-fpm.json
