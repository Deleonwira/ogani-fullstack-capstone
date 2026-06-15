<?php

use CodeIgniter\Router\RouteCollection;

/** @var RouteCollection $routes */
$routes->get('/', 'Admin::index');
$routes->get('/login', 'Auth::login');
$routes->post('/auth/loginProcess', 'Auth::loginProcess');
$routes->get('/logout', 'Auth::logout');

$routes->get('/admin/dashboard', 'Admin::index');
$routes->get('/admin/orders', 'Admin::orders');
$routes->get('/admin/products', 'Admin::products');
$routes->get('/admin/users', 'Admin::users');
$routes->get('/admin/categories', 'Admin::categories');
$routes->get('/admin/promos', 'Admin::promos');
$routes->get('/admin/reviews', 'Admin::reviews');
$routes->get('/admin/profile', 'Admin::profile');
$routes->get('/admin/settings', 'Admin::settings');
$routes->get('/admin/notifications', 'Admin::notifications');

// Action Routes
$routes->post('/admin/products/save', 'Admin::saveProduct');
$routes->get('/admin/products/delete/(:num)', 'Admin::deleteProduct/$1');

$routes->post('/admin/categories/save', 'Admin::saveCategory');
$routes->get('/admin/categories/delete/(:num)', 'Admin::deleteCategory/$1');

$routes->post('/admin/promos/save', 'Admin::savePromo');
$routes->get('/admin/promos/delete/(:num)', 'Admin::deletePromo/$1');

$routes->get('/admin/reviews/delete/(:num)', 'Admin::deleteReview/$1');

$routes->get('/admin/users/delete/(:num)', 'Admin::deleteUser/$1');
$routes->post('/admin/users/role/(:num)', 'Admin::updateUserRole/$1');

$routes->post('/admin/orders/status/(:num)', 'Admin::updateOrderStatus/$1');
$routes->put('/admin/settings/password', 'Admin::updatePassword');
$routes->put('/admin/profile/update', 'Admin::updateProfile');
