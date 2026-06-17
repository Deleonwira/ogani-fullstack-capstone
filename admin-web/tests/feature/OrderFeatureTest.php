<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class OrderFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewOrders() { // CI-21
        $result = $this->withSession($this->sess())->get('/admin/orders');
        $result->assertStatus(200);
    }
    public function testFilterOrdersPending() { // CI-22
        $result = $this->withSession($this->sess())->get('/admin/orders?status=PENDING');
        $result->assertStatus(200);
    }
    public function testUpdateOrderProcessing() { // CI-23
        $result = $this->withSession($this->sess())->post('/admin/orders/status/1', ['status'=>'PROCESSING']);
        $result->assertRedirect();
    }
    public function testUpdateOrderShipped() { // CI-24
        $result = $this->withSession($this->sess())->post('/admin/orders/status/1', ['status'=>'SHIPPED']);
        $result->assertRedirect();
    }
    public function testUpdateOrderCompleted() { // CI-25
        $result = $this->withSession($this->sess())->post('/admin/orders/status/1', ['status'=>'COMPLETED']);
        $result->assertRedirect();
    }
}