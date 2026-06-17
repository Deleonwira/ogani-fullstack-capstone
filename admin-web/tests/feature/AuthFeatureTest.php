<?php

namespace Tests\Feature;

use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class AuthFeatureTest extends CIUnitTestCase
{
    use FeatureTestTrait;

    protected function setUp(): void
    {
        parent::setUp();
    }

    public function testLoginAdminValid()
    {
        $result = $this->post('/auth/loginProcess', [
            'email'    => 'admin@ogani.com',
            'password' => 'admin'
        ]);

        $result->assertRedirectTo('/admin/dashboard');
        $this->assertTrue(session()->has('user_token'));
    }

    public function testLoginEmailUnregistered()
    {
        $result = $this->post('/auth/loginProcess', [
            'email'    => 'tidakada@ogani.com',
            'password' => 'sembarang'
        ]);

        $result->assertRedirectTo('/login');
        $result->assertSessionHas('error');
    }

    public function testLoginWrongPassword()
    {
        $result = $this->post('/auth/loginProcess', [
            'email'    => 'admin@ogani.com',
            'password' => 'salah123'
        ]);

        $result->assertRedirectTo('/login');
        $result->assertSessionHas('error');
    }

    public function testAccessAdminWithoutSession()
    {
        $result = $this->get('/admin/dashboard');
        $result->assertRedirectTo('/login');
    }

    public function testLogout()
    {
        session()->set('user_token', 'dummy_token');
        $result = $this->get('/logout');
        
        $result->assertRedirectTo('/login');
        $this->assertFalse(session()->has('user_token'));
    }
}
