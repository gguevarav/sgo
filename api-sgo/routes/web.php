<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Route::get('/', function () {
//    return view('welcome');
//});

//Route::get('/principal', function(){
//	dd(\App\Models\Producto::all());
//});



// Página principal
$router->get('/', 'PrincipalController@index')->middleware('auth.basic');

// Inicio de sesión
$router->get('/iniciosesion', 'InicioSesionController@iniciosesion');

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

// CRUD Inventarios
$router->get('/inventario', 'InventarioController@index');
$router->post('/inventario', 'InventarioController@store');
$router->delete('/inventario/{id}', 'InventarioController@destroy');
$router->put('/inventario/{id}', 'InventarioController@update');
$router->get('/inventario/{id}', 'InventarioController@show');

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

// CRUD Areas
$router->get('/areas', 'AreasController@index');
$router->post('/areas', 'AreasController@store');
$router->delete('/areas/{id}', 'AreasController@destroy');
$router->put('/areas/{id}', 'AreasController@update');
$router->get('/areas/{id}', 'AreasController@show');

// CRUD NombreActividad
$router->get('/nombreactividades', 'NombreActividadesController@index');
$router->post('/nombreactividades', 'NombreActividadesController@store');
$router->delete('/nombreactividades/{id}', 'NombreActividadesController@destroy');
$router->put('/nombreactividades/{id}', 'NombreActividadesController@update');
$router->get('/nombreactividades/{id}', 'NombreActividadesController@show');

// CRUD ListadoActividad
$router->get('/listadoactividades', 'ListadoActividadesController@index');
$router->post('/listadoactividades', 'ListadoActividadesController@store');
$router->delete('/listadoactividades/{id}', 'ListadoActividadesController@destroy');
$router->put('/listadoactividades/{id}', 'ListadoActividadesController@update');
$router->get('/listadoactividades/{id}', 'ListadoActividadesController@show');

// CRUD ListadoMaterial
$router->get('/listadomateriales', 'ListadoMaterialesController@index');
$router->post('/listadomateriales', 'ListadoMaterialesController@store');
$router->delete('/listadomateriales/{id}', 'ListadoMaterialesController@destroy');
$router->put('/listadomateriales/{id}', 'ListadoMaterialesController@update');
$router->get('/listadomateriales/{id}', 'ListadoMaterialesController@show');