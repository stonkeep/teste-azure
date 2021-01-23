<?php

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Redis;


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

Route::get('/', function () {
    try{
        Cache::put('key', 'value');
        dump(Cache::get('key'));
//        $redis=Redis::connect('127.0.0.1',3306);
        return response('redis working');
    }catch(\Predis\Connection\ConnectionException $e){
        return response('error connection redis');
    }
//    dump(env('APP_ENV'));
//    Log::info('testes');
//    return view('welcome');
});
