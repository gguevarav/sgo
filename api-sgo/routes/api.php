<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group([
    'prefix' => 'auth'
], function () {
    Route::post('login', 'AuthController@login');
    Route::post('signup', 'AuthController@signUp');

    Route::group([
        'middleware' => 'auth:api'
    ], function() {
        Route::post('logout', 'AuthController@logout');
        Route::get('user', 'AuthController@user');
        // Página principal
        Route::get('/', 'PrincipalController@index');
    });
});

Route::group([
    'middleware' => 'auth:api'
], function() {
    // Página principal
    Route::get('/', 'PrincipalController@index');

    // CRUD Unidades de Medida
    Route::get('/unidadesmedida', 'UnidadesMedidaController@index');
    Route::post('/unidadesmedida', 'UnidadesMedidaController@store');
    Route::delete('/unidadesmedida/{id}', 'UnidadesMedidaController@destroy');
    Route::put('/unidadesmedida/{id}', 'UnidadesMedidaController@update');
    Route::get('/unidadesmedida/{id}', 'UnidadesMedidaController@show');

    // CRUD Productos
    Route::get('/productos', 'ProductosController@index');
    Route::post('/productos', 'ProductosController@store');
    Route::delete('/productos/{id}', 'ProductosController@destroy');
    Route::put('/productos/{id}', 'ProductosController@update');
    Route::get('/productos/{id}', 'ProductosController@show');

    // CRUD Inventarios
    Route::get('/inventario', 'InventarioController@index');
    Route::post('/inventario', 'InventarioController@store');
    Route::delete('/inventario/{id}', 'InventarioController@destroy');
    Route::put('/inventario/{id}', 'InventarioController@update');
    Route::get('/inventario/{id}', 'InventarioController@show');

    // CRUD Puestos
    Route::get('/puestos', 'PuestosController@index');
    Route::post('/puestos', 'PuestosController@store');
    Route::delete('/puestos/{id}', 'PuestosController@destroy');
    Route::put('/puestos/{id}', 'PuestosController@update');
    Route::get('/puestos/{id}', 'PuestosController@show');

    // CRUD Roles
    Route::get('/roles', 'RolesController@index');
    Route::post('/roles', 'RolesController@store');
    Route::delete('/roles/{id}', 'RolesController@destroy');
    Route::put('/roles/{id}', 'RolesController@update');
    Route::get('/roles/{id}', 'RolesController@show');

    // CRUD Usuarios
    Route::get('/usuarios', 'UsuariosController@index');
    //Route::post('/usuarios', 'UsuariosController@store');
    Route::post('/usuarios', 'AuthController@signup');
    Route::delete('/usuarios/{id}', 'UsuariosController@destroy');
    Route::put('/usuarios/{id}', 'UsuariosController@update');
    Route::get('/usuarios/{id}', 'UsuariosController@show');

    // CRUD Areas
    Route::get('/areas', 'AreasController@index');
    Route::post('/areas', 'AreasController@store');
    Route::delete('/areas/{id}', 'AreasController@destroy');
    Route::put('/areas/{id}', 'AreasController@update');
    Route::get('/areas/{id}', 'AreasController@show');

    // CRUD NombreActividad
    Route::get('/nombreactividades', 'NombreActividadesController@index');
    Route::post('/nombreactividades', 'NombreActividadesController@store');
    Route::delete('/nombreactividades/{id}', 'NombreActividadesController@destroy');
    Route::put('/nombreactividades/{id}', 'NombreActividadesController@update');
    Route::get('/nombreactividades/{id}', 'NombreActividadesController@show');

    // CRUD ListadoActividad
    Route::get('/listadoactividades', 'ListadoActividadesController@index');
    Route::post('/listadoactividades', 'ListadoActividadesController@store');
    Route::delete('/listadoactividades/{id}', 'ListadoActividadesController@destroy');
    Route::put('/listadoactividades/{id}', 'ListadoActividadesController@update');
    Route::get('/listadoactividades/{id}', 'ListadoActividadesController@show');

    // CRUD ListadoMaterial
    Route::get('/listadomateriales', 'ListadoMaterialesController@index');
    Route::post('/listadomateriales', 'ListadoMaterialesController@store');
    Route::delete('/listadomateriales/{id}', 'ListadoMaterialesController@destroy');
    Route::put('/listadomateriales/{id}', 'ListadoMaterialesController@update');
    Route::get('/listadomateriales/{id}', 'ListadoMaterialesController@show');

});
