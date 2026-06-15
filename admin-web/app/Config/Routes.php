<?php

use CodeIgniter\Router\RouteCollection;

/** @var RouteCollection $routes */
$routes->get('/', 'Admin::index');
$routes->get('/admin/dashboard', 'Admin::index');
$routes->get('/admin/orders', 'Admin::orders');
$routes->get('/admin/products', 'Admin::products');
$routes->get('/admin/users', 'Admin::users');
$routes->get('/admin/categories', 'Admin::categories');
$routes->get('/admin/promos', 'Admin::promos');
$routes->get('/admin/reviews', 'Admin::reviews');
