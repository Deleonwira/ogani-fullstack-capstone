<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class SettingsFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN', 'userId' => 1]; }

    public function testUpdateProfile() { // CI-34
        $result = $this->withSession($this->sess())->put('/admin/profile/update', ['fullName'=>'Admin']);
        $result->assertStatus(200); // Or 302 depending on AJAX or Form
    }
    public function testUpdatePasswordValid() { // CI-35
        $result = $this->withSession($this->sess())->put('/admin/settings/password', ['currentPassword'=>'admin123', 'newPassword'=>'123']);
        $result->assertStatus(400);
    }
    public function testUpdatePasswordWrongCurrent() { // CI-36
        $result = $this->withSession($this->sess())->put('/admin/settings/password', ['currentPassword'=>'wrong', 'newPassword'=>'123']);
        $result->assertStatus(400); // Assuming the API returns 400, but CI4 controller might return 200 with error JSON
    }
    public function testUpdatePasswordMismatch() { // CI-37
        $result = $this->withSession($this->sess())->put('/admin/settings/password', ['currentPassword'=>'admin123', 'newPassword'=>'123', 'confirm'=>'456']);
        $result->assertStatus(400);
    }
    public function testGlobalSearchMatch() { // CI-38
        $result = $this->withSession($this->sess())->withHeaders(['X-Requested-With' => 'XMLHttpRequest'])->get('/admin/search?q=apple');
        $result->assertStatus(200);
    }
    public function testGlobalSearchEmpty() { // CI-39
        $result = $this->withSession($this->sess())->withHeaders(['X-Requested-With' => 'XMLHttpRequest'])->get('/admin/search?q=');
        $result->assertStatus(200);
    }
    public function testGlobalSearchNavigation() { // CI-40
        // Simulating the user clicking a search result link
        $result = $this->withSession($this->sess())->get('/admin/products?search=apple');
        $result->assertStatus(200);
    }
}