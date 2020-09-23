<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use DateTime;

use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Enviar un usuario
        {
            //DB::table('Usuario');
            User::create(array(
                    'NombreUsuario' => 'Daniel',
                    'ApellidoUsuario' => 'Guevara',
                    'idPuesto' => '1',
                    'email' => 'gemisdguevarav@gmail.com',
                    'password' => Hash::make('12345'),
                    'idRol' => '1',
                    'EstadoUsuario' => '1',
                    'remember_token' => 'null',
                    'created_at' => new DateTime,
                    'updated_at' => new DateTime   
            )); 
        }
    }
}
