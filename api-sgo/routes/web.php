<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

// CRUD Unidades de Medida
$router->get('/unidadesmedida', 'UnidadesMedidaController@index');
$router->post('/unidadesmedida', 'UnidadesMedidaController@store');
$router->delete('/unidadesmedida/{id}', 'UnidadesMedidaController@destroy');
$router->put('/unidadesmedida/{id}', 'UnidadesMedidaController@update');
$router->get('/unidadesmedida/{id}', 'UnidadesMedidaController@show');


// CRUD Productos
$router->get('/productos', 'ProductosController@index');
$router->post('/productos', 'ProductosController@store');
$router->delete('/productos/{id}', 'ProductosController@destroy');
$router->put('/productos/{id}', 'ProductosController@update');
$router->get('/productos/{id}', 'ProductosController@show');

// CRUD Puestos
$router->get('/puestos', 'PuestosController@index');
$router->post('/puestos', 'PuestosController@store');
$router->delete('/puestos/{id}', 'PuestosController@destroy');
$router->put('/puestos/{id}', 'PuestosController@update');
$router->get('/puestos/{id}', 'PuestosController@show');

// CRUD Roles
$router->get('/roles', 'RolesController@index');
$router->post('/roles', 'RolesController@store');
$router->delete('/roles/{id}', 'RolesController@destroy');
$router->put('/roles/{id}', 'RolesController@update');
$router->get('/roles/{id}', 'RolesController@show');

// CRUD Usuarios
$router->get('/usuarios', 'UsuariosController@index');
$router->post('/usuarios', 'UsuariosController@store');
$router->delete('/usuarios/{id}', 'UsuariosController@destroy');
$router->put('/usuarios/{id}', 'UsuariosController@update');
$router->get('/usuarios/{id}', 'UsuariosController@show');