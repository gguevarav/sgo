<?php

namespace App\Http\Controllers;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\NombreActividad;

class NombreActividadesController extends BaseController
{
    public function index(){
        // Primero obtendremos el array de los Datos
        $Datos = NombreActividad::all();

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
        // Creamos un json nulo
        $json = null;
        // Recogemos los Datos que almacenaremos, los ingresamos a un array
        $Datos = array("NombreActividad"=>$request->input("NombreActividad"));

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Validamos los Datos antes de insertarlos en la base de Datos
            $validacion = Validator::make($Datos,[
                                          "NombreActividad" => 'required|string|max:255']);

            // Revisamos la validación
            if($validacion->fails()){
                // Devolvemos el mensaje que falló la validación de Datos
                $json = array(
                    "status" => 404,
                    "detalle" => "Los registros tienen errores"
                );
            }else{
                // instanciamos un nuevo objeto para registro
                $NombreActividad = new NombreActividad();

                // Ingresamos los datos
                $NombreActividad->NombreActividad = $Datos["NombreActividad"];

                // Ejecutamos la acción de guardar
                $NombreActividad->save();

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
        $NombreActividad = NombreActividad::where("idNombreActividad", $id)->get();
        // Verificamos que el array no esté vacio
        if ($NombreActividad != "[]" && !empty($NombreActividad)) {
            $json = array(
                'status' => 200,
                'detalle' => $NombreActividad
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
        // Creamos un json nulo
        $json = null;
        // Recogemos los Datos que almacenaremos, los ingresamos a un array
        $Datos = array("NombreActividad"=>$request->input("NombreActividad"));

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Validamos los Datos antes de insertarlos en la base de Datos
            $validacion = Validator::make($Datos,[
                                          "NombreActividad" => 'required|string|max:255']);

            // Revisamos la validación
            if($validacion->fails()){
                // Devolvemos el mensaje que falló la validación de Datos
                $json = array(
                    "status" => 404,
                    "detalle" => "Los registros tienen errores"
                );
            }else{
                // Obtendremos el NombreActividad de la base de datos
                $ObtenerNombreActividad = NombreActividad::where("idNombreActividad", $id)->get();

                if(!empty($ObtenerNombreActividad[0])){
                    // Modificamos la información, pasamos la información contenida
                    // en el array de los datos
                    $NombreActividad = NombreActividad::where("idNombreActividad", $id)->update($Datos);

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
        $ObtenerNombreActividad = NombreActividad::where("idNombreActividad", $id)->get();
        // Si el NombreActividad no está vacío
        if(!empty($ObtenerNombreActividad)){
            // Eliminamos el registro
            $NombreActividadEliminar = NombreActividad::where("idNombreActividad", $id)->delete();

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
