<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class UserFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewUsers() { // CI-26
        $result = $this->withSession($this->sess())->get('/admin/users');
        $result->assertStatus(200);
    }
    public function testUpdateUserRole() { // CI-27
        $result = $this->withSession($this->sess())->post('/admin/users/update/2', ['role'=>'ADMIN']);
        $result->assertRedirect();
    }
    public function testDeleteUser() { // CI-28
        $result = $this->withSession($this->sess())->get('/admin/users/delete/2');
        $result->assertRedirect();
    }
}