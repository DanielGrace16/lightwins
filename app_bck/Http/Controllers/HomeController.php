<?php

namespace App\Http\Controllers;

use App\Helpers\GeneralHelper;
use App\Mail\PasswordReset;
use App\Models\Setting;
use Cartalyst\Sentinel\Checkpoints\NotActivatedException;
use Cartalyst\Sentinel\Checkpoints\ThrottlingException;
use Cartalyst\Sentinel\Laravel\Facades\Reminder;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\View;
use Laracasts\Flash\Flash;
use Sentinel;
use Illuminate\Http\Request;
use Cartalyst\Sentinel\Laravel\Facades\Activation;
use App\Http\Requests;

class HomeController extends Controller
{
    public function __construct()
    {

    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (!Sentinel::check()) {
            return redirect('login');
        } else {
            return redirect('dashboard');
        }
    }

    public function login()
    {
        if (Sentinel::check()) {
            return redirect('dashboard');
        }
        return view('login');
    }


    public function logout()
    {
        //GeneralHelper::audit_trail("Logged out of system");
        session()->flush();
        Sentinel::logout(null, true);
        return redirect('login');
    }

    public function process_login()
    {
        if (Sentinel::check()) {
            return redirect('dashboard');
        }
        $rules = array(
            'email' => 'required',
            'password' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            //process validation here
            $credentials = array(
                "email" => Input::get('email'),
                "password" => Input::get('password'),
            );
            if (Input::get('remember')) {
                $remember = true;
            } else {
                $remember = false;
            }
            try {
                if (Sentinel::authenticate($credentials, $remember)) {
                    //GeneralHelper::audit_trail("Logged in to system");
                    if (Sentinel::getUser()->blocked == 1) {
                        //prevent login
                        Flash::warning(trans('general.user_blocked'));
                        Sentinel::logout(null, true);
                        return redirect('login');
                    }
                    //check allowed roles
                    $role = Sentinel::getUser()->roles->first();
                    if (!empty($role)) {
                        if ($role->time_limit == 1) {
                            $time = date("H:i");
                            $day = date("l");
                            if (!in_array(strtolower($day), json_decode($role->access_days)) || strtotime($time) < strtotime($role->from_time) || strtotime($time) >= strtotime($role->to_time)) {
                                Flash::warning("You are not allowed to login at this time");
                                Sentinel::logout(null, true);
                                return redirect('login');
                            }
                        }

                    }
                    return redirect('dashboard');
                } else {
                    //return back
                    Flash::warning(trans('general.invalid_login_details'));
                    return redirect()->back()->withInput()->withErrors(trans('general.invalid_login_details'));
                }
            } catch (ThrottlingException $ex) {
                Flash::warning(trans('general.too_many_login_attempts'));
                return redirect()->back()->withInput()->withErrors(trans('general.too_many_login_attempts'));
            } catch (NotActivatedException $ex) {
                Flash::warning(trans('general.account_not_activated'));
                return redirect()->back()->withInput()->withErrors(trans('general.account_not_activated'));
            }


        }
    }

    public function register()
    {
        if (Sentinel::check()) {
            return redirect('dashboard');
        }
        $rules = array(
            'email' => 'required|unique:users',
            'password' => 'required',
            'rpassword' => 'required|same:password',
            'first_name' => 'required',
            'last_name' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            Flash::warning(trans('login.failure'));
            return redirect()->back()->withInput()->withErrors($validator);

        } else {
            //process validation here
            $credentials = array(
                "email" => Input::get('email'),
                "password" => Input::get('password'),
                "first_name" => Input::get('first_name'),
                "last_name" => Input::get('last_name'),
            );
            $user = Sentinel::registerAndActivate($credentials);
            $role = Sentinel::findRoleByName('Client');
            $role->users()->attach($user);
            $msg = trans('login.success');
            Flash::success(trans('login.success'));
            return redirect('login')->with('msg', $msg);

        }
    }

    public function password_reset()
    {
        if (Sentinel::check()) {
            return redirect('dashboard');
        }
        return view('password_reset');
    }

    /*
     * Password Resets
     */
    public function process_password_reset()
    {
        if (Sentinel::check()) {
            return redirect('dashboard');
        }
        $rules = array(
            'email' => 'required',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            //process validation here
            $credentials = array(
                "email" => Input::get('email'),
            );
            $user = Sentinel::findByCredentials($credentials);
            if (!$user) {
                return redirect()->back()
                    ->withInput()
                    ->withErrors(trans_choice('general.user_email_not_found', 1));
            } else {
                Mail::to($user->email)->send(new PasswordReset($user));
                Flash::success(trans('general.password_reset_success'));
                return redirect()->back()
                    ->withSuccess(trans('general.password_reset_success'));
            }

        }
    }

    public function confirm_password_reset($id, $code)
    {
        if (Sentinel::check()) {
            return redirect('dashboard');
        }
        return view('confirm_password_reset', compact('id', 'code'));
    }

    public function process_confirm_password_reset(Request $request, $id, $code)
    {
        if (Sentinel::check()) {
            return redirect('dashboard');
        }
        $rules = array(
            'password' => 'required',
            'repeat_password' => 'required|same:password',
        );
        $validator = Validator::make(Input::all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        } else {
            //process validation here
            $credentials = array(
                "email" => Input::get('email'),
                'password' => Input::get('password'),
            );
            $user = Sentinel::findById($id);
            if (!$user) {
                return redirect()->back()
                    ->withInput()
                    ->withErrors(trans_choice('general.user_email_not_found', 1));
            }
            if (!Reminder::complete($user, $code, Input::get('password'))) {
                return redirect()->to('password_reset')
                    ->withErrors(trans('general.invalid_password_reset_code'));
            }
            Sentinel::authenticate($credentials);
            Flash::success(trans('general.password_reset_complete'));
            return redirect('dashboard');

        }
    }


}
