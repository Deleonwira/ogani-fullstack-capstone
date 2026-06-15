<?php

namespace App\Controllers;

class Auth extends BaseController
{
    public function login()
    {
        // If already logged in, redirect to dashboard
        if (session()->get('isLoggedIn')) {
            return redirect()->to('/admin/dashboard');
        }
        return view('auth/login');
    }

    public function loginProcess()
    {
        $email = $this->request->getPost('email');
        $password = $this->request->getPost('password');

        try {
            $client = \Config\Services::curlrequest();
            $response = $client->request('POST', 'http://localhost:8080/api/auth/login', [
                'json' => [
                    'email' => $email,
                    'password' => $password
                ],
                'http_errors' => false
            ]);

            $data = json_decode($response->getBody(), true);

            if ($response->getStatusCode() == 200 && isset($data['success']) && $data['success'] == true) {
                $user = $data['data']['user'];
                
                // Only allow ADMIN to login to web panel
                if ($user['role'] !== 'ADMIN') {
                    return redirect()->back()->with('error', 'Access denied. Only administrators can login.');
                }

                session()->set([
                    'isLoggedIn' => true,
                    'token' => $data['data']['token'],
                    'userId' => $user['userId'],
                    'fullName' => $user['fullName'],
                    'email' => $user['email'],
                    'role' => $user['role']
                ]);

                return redirect()->to('/admin/dashboard');
            } else {
                $errorMsg = $data['message'] ?? 'Invalid email or password.';
                return redirect()->back()->with('error', $errorMsg);
            }
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Cannot connect to authentication server.');
        }
    }

    public function logout()
    {
        session()->destroy();
        return redirect()->to('/login');
    }
}
