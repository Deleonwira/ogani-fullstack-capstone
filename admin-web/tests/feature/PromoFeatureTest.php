<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class PromoFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewPromos() { // CI-29
        $result = $this->withSession($this->sess())->get('/admin/promos');
        $result->assertStatus(200);
    }
    public function testAddPromo() { // CI-30
        $result = $this->withSession($this->sess())->post('/admin/promos/save', ['promoCode'=>'NEW']);
        $result->assertRedirect();
    }
    public function testDeletePromo() { // CI-31
        $result = $this->withSession($this->sess())->get('/admin/promos/delete/1');
        $result->assertRedirect();
    }
}