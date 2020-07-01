<?php

namespace App\Http\Controllers;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use App\Models\Usuario;

class UsuariosController extends BaseController
{
    public function index(){
        // Primero obtendremos el array de los Datos
        $Datos = Usuario::all();

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
        $Datos = array("NombreUsuario"=>$request->input("NombreUsuario"),
                       "ApellidoUsuario"=>$request->input("ApellidoUsuario"),
                       "idPuesto"=>$request->input("idPuesto"),
                       "CorreoUsuario"=>$request->input("CorreoUsuario"),
                       "ContraseniaUsuario"=>$request->input("ContraseniaUsuario"),
                       "idRol"=>$request->input("idRol"),
                       "EstadoUsuario"=>$request->input("EstadoUsuario"));

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Validamos los Datos antes de insertarlos en la base de Datos
            $validacion = Validator::make($Datos,[
                                          "NombreUsuario" => 'required|string|max:255',
                                          "ApellidoUsuario" => 'required|string|max:255',
                                          "idPuesto" => 'required|integer',
                                          "CorreoUsuario" => 'required|string|email|max:255|unique:Usuario',
                                          "ContraseniaUsuario" => 'required|string|max:255',
                                          "idRol" => 'required|integer',
                                          "EstadoUsuario" => 'required|integer']);

            // Revisamos la validación
            if($validacion->fails()){
                // Devolvemos el mensaje que falló la validación de Datos
                $json = array(
                    "status" => 404,
                    "detalle" => "Los registros tienen errores"
                );
            }else{
                // instanciamos un nuevo objeto para registro
                $Usuario = new Usuario();

                // Se crea el id Cliente
                $idCliente = Hash::make($Datos["NombreUsuario"].$Datos["ApellidoUsuario"].$Datos["CorreoUsuario"].$Datos["ContraseniaUsuario"]);

                // Creamos la llave secreta del usuario
                $LlaveSecreta = Hash::make($Datos["ContraseniaUsuario"].$Datos["NombreUsuario"].$Datos["ApellidoUsuario"].$Datos["CorreoUsuario"], ['rounds' => 12]);

                // Ingresamos los Datos
                $Usuario->NombreUsuario = $Datos["NombreUsuario"];
                $Usuario->ApellidoUsuario = $Datos["ApellidoUsuario"];
                $Usuario->idPuesto = $Datos["idPuesto"];
                $Usuario->CorreoUsuario = $Datos["CorreoUsuario"];
                $Usuario->ContraseniaUsuario = $Datos["ContraseniaUsuario"];
                $Usuario->idClienteUsuario = str_replace("$", "-", $idCliente);
                $Usuario->LlaveSecretaUsuario = str_replace("$", "-", $LlaveSecreta);
                $Usuario->idRol = $Datos["idRol"];
                $Usuario->EstadoUsuario = $Datos["EstadoUsuario"];

                // Ejecutamos la acción de guardar
                $Usuario->save();

                $json = array(
                    "status" => 200,
                    "detalle" => "Registro exitoso",
                    "idCliente" => str_replace("$", "-", $idCliente),
                    "LlaveSecreta" => str_replace("$", "-", $LlaveSecreta)
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
        $Usuario = Usuario::where("idUsuario", $id)->get();
        // Verificamos que el array no esté vacio
        if ($Usuario != "[]" && !empty($Usuario)) {
            $json = array(
                'status' => 200,
                'detalle' => $Usuario
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
        $Datos = array("NombreUsuario"=>$request->input("NombreUsuario"),
                       "ApellidoUsuario"=>$request->input("ApellidoUsuario"),
                       "idPuesto"=>$request->input("idPuesto"),
                       //"CorreoUsuario"=>$request->input("CorreoUsuario"),
                       "ContraseniaUsuario"=>$request->input("ContraseniaUsuario"),
                       "idRol"=>$request->input("idRol"),
                       "EstadoUsuario"=>$request->input("EstadoUsuario"));

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Validamos los Datos antes de insertarlos en la base de Datos
            $validacion = Validator::make($Datos,[
                                          "NombreUsuario" => 'required|string|max:255',
                                          "ApellidoUsuario" => 'required|string|max:255',
                                          "idPuesto" => 'required|integer',
                                          //"CorreoUsuario" => 'required|string|email|max:255|unique:Usuario',
                                          "ContraseniaUsuario" => 'required|string|max:255',
                                          "idRol" => 'required|integer',
                                          "EstadoUsuario" => 'required|integer']);

            // Revisamos la validación
            if($validacion->fails()){
                // Devolvemos el mensaje que falló la validación de Datos
                $json = array(
                    "status" => 404,
                    "detalle" => "Los registros tienen errores"
                );
            }else{
                // instanciamos un nuevo objeto para registro
                // Obtendremos el Usuario de la base de Datos
                $ObtenerUsuario = Usuario::where("idUsuario", $id)->get();

                if(!empty($ObtenerUsuario[0])){
                    // Modificamos la información, pasamos la información contenida
                    // en el array de los Datos
                    $Usuario = Usuario::where("idUsuario", $id)->update($Datos);

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
        // Guardemos los Datos en la base de Datos
        $ObtenerUsuario = Usuario::where("idUsuario", $id)->get();
        // Si el Usuario no está vacío
        if(!empty($ObtenerUsuario)){
            // Eliminamos el registro
            $UsuarioEliminar = Usuario::where("idUsuario", $id)->delete();

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