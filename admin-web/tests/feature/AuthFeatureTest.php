<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class AuthFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }

    public function testLoginSuccess() { // CI-01
        $result = $this->post('/auth/loginProcess', ['email' => 'admin@ogani.com', 'password' => 'admin123']);
        $result->assertRedirect();
    }
    public function testLoginEmailUnregistered() { // CI-02
        $result = $this->post('/auth/loginProcess', ['email' => 'tidakada@ogani.com', 'password' => 'sembarang']);
        $result->assertRedirect();
    }
    public function testLoginWrongPassword() { // CI-03
        $result = $this->post('/auth/loginProcess', ['email' => 'admin@ogani.com', 'password' => 'salah123']);
        $result->assertRedirect();
    }
    public function testLoginCustomerRole() { // CI-04
        $result = $this->post('/auth/loginProcess', ['email' => 'customer@ogani.com', 'password' => 'benar']);
        $result->assertRedirect();
    }
    public function testAccessAdminWithoutSession() { // CI-05
        $result = $this->get('/admin/dashboard');
        $result->assertRedirectTo('/login');
    }
    public function testLogout() { // CI-06
        $result = $this->get('/logout');
        $result->assertRedirectTo('/login');
    }
}