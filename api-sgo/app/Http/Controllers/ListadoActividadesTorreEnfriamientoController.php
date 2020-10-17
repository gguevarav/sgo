<?php

namespace App\Http\Controllers;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use App\Models\ListadoActividadTorreEnfriamiento;

class ListadoActividadesTorreEnfriamientoController extends BaseController
{
    public function index(){
        // Primero obtendremos el array de los datos
        $Datos = DB::Select('SELECT LATE.idListadoActividadTorreEnfriamiento,
                                          A.NombreArea,
                                          NA.NombreActividad,
                                          CONCAT(US.NombreUsuario, " ", US.ApellidoUsuario) AS RealizadoPor,
                                          CONCAT(US2.NombreUsuario, " ", US2.ApellidoUsuario) AS CreadoPor,
                                          E.NombreEstado,
                                          LATE.FechaCreacionActividad,
                                          LATE.FechaConclusionActividad ' .'
                                   FROM ListadoActividadTorreEnfriamiento As LATE
                                            INNER JOIN Area A
                                                       ON LATE.idArea = A.idArea
                                            INNER JOIN NombreActividad NA
                                                       ON LATE.idNombreActividad = NA.idNombreActividad
                                            INNER JOIN users US
                                                       ON LATE.CreadoPor = US.idUsuario
                                            INNER JOIN users US2
                                                       ON LATE.RealizadoPor = US2.idUsuario
                                            INNER JOIN Estado E
                                                       ON LATE.EstadoActividad = E.idEstado;');

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
        $Datos = array("idArea"=>$request->idArea,
                       "idNombreActividad"=>$request->idNombreActividad,
                       "FechaCreacionActividad"=>$request->FechaCreacionActividad,
                       "FechaConclusionActividad"=>$request->FechaConclusionActividad,
                       "EstadoActividad"=>$request->EstadoActividad,
                       "CreadoPor"=>$request->CreadoPor,
                       "RealizadoPor"=>$request->RealizadoPor);

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Separamos la validación
            // Reglas
            $Reglas = ["idArea" => 'required|integer',
                       "idNombreActividad" => 'required|integer',
                       "FechaCreacionActividad" => 'required|date',
                       "FechaConclusionActividad" => 'required|date',
                       "EstadoActividad" => 'required|integer',
                       "CreadoPor" => 'required|integer',
                       "RealizadoPor" => 'required|integer'];

            $Mensajes = [
                         "idArea.required" => 'Es necesario agregar un área donde se realizará.',
                         "idNombreActividad.required" => 'Es necesario agregar un nombre de la actividad.',
                         "FechaCreacionActividad.required" => 'Es necesario agregar la fecha en que se crea la actividad.',
                         "FechaConclusionActividad.required" => 'Es necesario agregar un la fecha en que se concluye la actividad.',
                         "EstadoActividad.required" => 'Es necesario agregar un de la actividad.',
                         "CreadoPor.required" => 'Es necesario agregar un solicitante.',
                         "RealizadoPor.required" => 'Es necesario agregar un encargado de realización de la actividad.'];
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
                // instanciamos un nuevo objeto para registro
                $ListadoActividadTorreEnfriamiento = new ListadoActividadTorreEnfriamiento();

                // Ingresamos los datos
                $ListadoActividadTorreEnfriamiento->idArea = $Datos["idArea"];
                $ListadoActividadTorreEnfriamiento->idNombreActividad = $Datos["idNombreActividad"];
                $ListadoActividadTorreEnfriamiento->FechaCreacionActividad = $Datos["FechaCreacionActividad"];
                $ListadoActividadTorreEnfriamiento->FechaConclusionActividad = $Datos["FechaConclusionActividad"];
                $ListadoActividadTorreEnfriamiento->EstadoActividad = $Datos["EstadoActividad"];
                $ListadoActividadTorreEnfriamiento->CreadoPor = $Datos["CreadoPor"];
                $ListadoActividadTorreEnfriamiento->RealizadoPor = $Datos["RealizadoPor"];

                // Ejecutamos la acción de guardar el usuario
                $ListadoActividadTorreEnfriamiento->save();

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

    public function update($id, Request $request){
        // Inicializamos una variable para almacenar un json nulo
        $json = null;
        // Recogemos los Datos que almacenaremos, los ingresamos a un array
        $Datos = array("idArea"=>$request->idArea,
                       "idNombreActividad"=>$request->idNombreActividad,
                       "FechaCreacionActividad"=>$request->FechaCreacionActividad,
                       "FechaConclusionActividad"=>$request->FechaConclusionActividad,
                       "EstadoActividad"=>$request->EstadoActividad,
                       "CreadoPor"=>$request->CreadoPor,
                       "RealizadoPor"=>$request->RealizadoPor);

        // Validamos que los Datos no estén vacios
        if(!empty($Datos)){
            // Separamos la validación
            // Reglas
            $Reglas = ["idArea" => 'required|integer',
                       "idNombreActividad" => 'required|integer',
                       "FechaCreacionActividad" => 'required|date',
                       "FechaConclusionActividad" => 'required|date',
                       "EstadoActividad" => 'required|integer',
                       "CreadoPor" => 'required|integer',
                       "RealizadoPor" => 'required|integer'];

            $Mensajes = [
                         "idArea.required" => 'Es necesario agregar un área donde se realizará.',
                         "idNombreActividad.required" => 'Es necesario agregar un nombre de la actividad.',
                         "FechaCreacionActividad.required" => 'Es necesario agregar la fecha en que se crea la actividad.',
                         "FechaConclusionActividad.required" => 'Es necesario agregar un la fecha en que se concluye la actividad.',
                         "EstadoActividad.required" => 'Es necesario agregar un de la actividad.',
                         "CreadoPor.required" => 'Es necesario agregar un solicitante.',
                         "RealizadoPor.required" => 'Es necesario agregar un encargado de realización de la actividad.'];
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
                // Obtendremos el ListadoActividad de la base de datos
                $ObtenerListadoActividadTorreEnfriamiento = ListadoActividadTorreEnfriamiento::where("idListadoActividadTorreEnfriamiento", $id)->get();

                if(!empty($ObtenerListadoActividadTorreEnfriamiento[0])){
                    // Modificamos la información, pasamos la información contenida
                    // en el array de los datos
                    $ListadoActividadTorreEnfriamiento = ListadoActividadTorreEnfriamiento::where("idListadoActividadTorreEnfriamiento", $id)->update($Datos);

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

    public function show($id, Request $request){
        // Inicializamos una variable para almacenar un json nulo
        $json = null;
        // Primero obtenemos todos los registros y los almacenamos en un array
        $ListadoActividadTorreEnfriamiento = DB::SELECT('SELECT LATE.idListadoActividadTorreEnfriamiento,
                                                                      A.NombreArea,
                                                                      NA.NombreActividad,
                                                                      CONCAT(US.NombreUsuario, " ", US.ApellidoUsuario) AS RealizadoPor,
                                                                      CONCAT(US2.NombreUsuario, " ", US2.ApellidoUsuario) AS CreadoPor,
                                                                      E.NombreEstado,
                                                                      LATE.FechaCreacionActividad,
                                                                      LATE.FechaConclusionActividad ' . '
                                                               FROM ListadoActividadTorreEnfriamiento As LATE
                                                                        INNER JOIN Area A
                                                                                   ON LATE.idArea = A.idArea
                                                                        INNER JOIN NombreActividad NA
                                                                                   ON LATE.idNombreActividad = NA.idNombreActividad
                                                                        INNER JOIN users US
                                                                                   ON LATE.CreadoPor = US.idUsuario
                                                                        INNER JOIN users US2
                                                                                   ON LATE.RealizadoPor = US2.idUsuario
                                                                        INNER JOIN Estado E
                                                                                   ON LATE.EstadoActividad = E.idEstado
                                                               WHERE LATE.idListadoActividadTorreEnfriamiento = ' . $id . ';');
        // Verificamos que el array no esté vacio
        if ($ListadoActividadTorreEnfriamiento != "[]" && !empty($ListadoActividadTorreEnfriamiento)) {
            $json = array(
                'status' => 200,
                'detalle' => $ListadoActividadTorreEnfriamiento
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

    public function listadoActividadesGeneralTorreEnfriamiento(){
        // Primero obtendremos el array de los datos
        $Datos = DB::Select('SELECT LATE.idListadoActividadTorreEnfriamiento,
                                          A.NombreArea,
                                          NA.NombreActividad,
                                          CONCAT(US.NombreUsuario, " ", US.ApellidoUsuario) AS RealizadoPor,
                                          CONCAT(US2.NombreUsuario, " ", US2.ApellidoUsuario) AS CreadoPor,
                                          E.NombreEstado,
                                          E.idEstado,
                                          LATE.FechaCreacionActividad,
                                          LATE.FechaConclusionActividad ' .'
                                   FROM ListadoActividadTorreEnfriamiento As LATE
                                            INNER JOIN Area A
                                                       ON LATE.idArea = A.idArea
                                            INNER JOIN NombreActividad NA
                                                       ON LATE.idNombreActividad = NA.idNombreActividad
                                            INNER JOIN users US
                                                       ON LATE.CreadoPor = US.idUsuario
                                            INNER JOIN users US2
                                                       ON LATE.RealizadoPor = US2.idUsuario
                                            INNER JOIN Estado E
                                                       ON LATE.EstadoActividad = E.idEstado;');

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
}
