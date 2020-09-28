<?php

namespace App\Http\Controllers;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Inventario;
use Illuminate\Support\Facades\DB;

class InventarioController extends BaseController
{  
    public function index(){
        // Creamos el join para obtener el array de los datos
        $Datos = DB::table('Inventario')
                        ->join('Producto', 'Inventario.idProducto', '=', 'Producto.idProducto')
                        ->select('Inventario.*', 'Producto.idProducto')
                        ->get();

        // Verificamos que el array no esté vacio
        if (!empty($Datos[0])) {
            $json = array(
                'status' => 200,
                'total' => count($Datos),
                'detalle' => $Datos
            );
        }else{
            $json = array(
                'status' => 200,
                'total' => 0,
                'detalle' => "No hay registros"
            );
        }
        // Mostramos la información como un json
        return response()->json($json);
    }

    public function store(Request $request){
        // Inicializamos una variable para almacenar un json nulo
        $json = null;
        // Recogemos los Datos que almacenaremos, los ingresamos a un array
        $Datos = array("idProducto"=>$request->input("idProducto"),
                       "CantidadExistencia"=>$request->input("CantidadExistencia"),
                       "CantidadMinima"=>$request->input("CantidadMinima"),
                       "CantidadMaxima"=>$request->input("CantidadMaxima"));

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Separamos la validación
            // Reglas
            $Reglas = [
                "idProducto" => 'required|integer',
                "CantidadExistencia" => 'required|decimal',
                "CantidadMinima" => 'required|decimal',
                "CantidadMaxima" => 'required|decimal'];

            $Mensajes = [
                "idProducto.required" => 'Es necesario agregar un código de producto',
                "CantidadExistencia.required" => 'Es necesario agregar una cantidad en existencia',
                "CantidadMinima.required" => 'Es necesario agregar una cantidad minima',
                "CantidadMaxima.required" => 'Es necesario agregar una cantidad maxima'];
            // Validamos los Datos antes de insertarlos en la base de Datos
            $validacion = Validator::make($Datos,$Reglas,$Mensajes);

            //return echo "Hola";

            // Revisamos la validación
            if($validacion->fails()){
                // Devolvemos el mensaje que falló la validación de Datos
                $json = array(
                    "status" => 404,
                    "detalle" => "Los registros tienen errores",
                    "errores" => $validacion->errors()->all()
                );
            }else{
                // instanciamos un nuevo objeto para registro
                $Inventario = new Inventario();

                // Ingresamos los datos
                $Inventario->idProducto = $Datos["idProducto"];
                $Inventario->CantidadExistencia = $Datos["CantidadExistencia"];
                $Inventario->CantidadMinima = $Datos["CantidadMinima"];
                $Inventario->CantidadMaxima = $Datos["CantidadMaxima"];

                // Ejecutamos la acción de guardar el usuario
                $Inventario->save();

                $json = array(
                    "status" => 200,
                    "detalle" => "Registro exitoso"
                );
            }
        }else{
            $json = array(
                "status" => 404,
                "detalle" => "Registro con errores"
            );
        }
        // Devolvemos la respuesta en un Json
        return response()->json($json);
    }

    public function show($id, Request $request){
        // Inicializamos una variable para almacenar un json nulo
        $json = null;
        // Primero obtenemos todos los registros y los almacenamos en un array
        $Inventario = Inventario::where("idInventario", $id)->get();
        // Verificamos que el array no esté vacio
        if ($Inventario != "[]" && !empty($Inventario)) {
            $json = array(
                'status' => 200,
                'detalle' => $Inventario
            );
        }else{
            $json = array(
                'status' => 200,
                'detalle' => "Registro no encontrado."
            );
        }
        // Devolvemos la respuesta en un Json
        return response()->json($json);
    }

    public function update($id, Request $request){
        // Inicializamos una variable para almacenar un json nulo
        $json = null;
        // Recogemos los Datos que almacenaremos, los ingresamos a un array
        $Datos = array("CodigoInventario"=>$request->input("CodigoInventario"),
                       "NombreInventario"=>$request->input("NombreInventario"),
                       "idUnidadMedida"=>$request->input("idUnidadMedida"),
                       "EstadoInventario"=>$request->input("EstadoInventario"));

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Separamos la validación
            // Reglas
            $Reglas = [
                "CodigoInventario" => 'required|string|max:255|unique:Inventario',
                "NombreInventario" => 'required|string|max:255',
                "idUnidadMedida" => 'required|integer',
                "EstadoInventario" => 'required|integer'];

            $Mensajes = [
                "CodigoInventario.required" => 'Es necesario agregar un código de producto',
                "CodigoInventario.unique" => 'El código ya existe',
                "NombreInventario.required" => 'Es necesario agregar un nombre al producto',
                "idUnidadMedida.required" => 'Es necesario agregar una unidad de medida',
                "EstadoInventario.required" => 'Es necesario agregar un estado de producto'];
            // Validamos los Datos antes de insertarlos en la base de Datos
            $validacion = Validator::make($Datos,$Reglas,$Mensajes);

            // Revisamos la validación
            if($validacion->fails()){
                // Devolvemos el mensaje que falló la validación de Datos
                $json = array(
                    "status" => 404,
                    "detalle" => "Los registros tienen errores",
                    "errores" => $validacion->errors()->all()
                );
            }else{
                // Obtendremos el producto de la base de datos
                $ObtenerInventario = Inventario::where("idInventario", $id)->get();

                if(!empty($ObtenerInventario[0])){
                    // Modificamos la información, pasamos la información contenida
                    // en el array de los datos
                    $Inventario = Inventario::where("idInventario", $id)->update($Datos);

                    $json = array(
                        "status" => 200,
                        "detalle" => "Registro editado exitosamente"
                    );
                }else{
                    $json = array(
                    "status" => "404", 
                    "detalle" => "El registro no existe."
                );
                }
            }   
        }else{
            $json = array(
                    "status" => "404", 
                    "detalle" => "Registros incompletos"
                );
        }
        // Devolvemos la respuesta en un Json
        return response()->json($json);
    }

    public function destroy($id, Request $request){
        // Inicializamos una variable para almacenar un json nulo
        $json = null;
        // Guardemos los datos en la base de datos
        $ObtenerInventario = Inventario::where("idInventario", $id)->get();
        // Si el producto no está vacío
        if(!empty($ObtenerInventario)){
            // Eliminamos el registro
            $InventarioEliminar = Inventario::where("idInventario", $id)->delete();

            $json = array(
                "status" => 200,
                "detalle" => "Registro eliminado exitosamente"
            );
        }else{
            $json = array(
                    "status" => "404", 
                    "detalle" => "El registro no existe."
                );
        }
        // Devolvemos la respuesta en un Json
        return response()->json($json);
    }
}