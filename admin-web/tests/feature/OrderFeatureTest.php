<?php

namespace Tests\Feature;

use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class OrderFeatureTest extends CIUnitTestCase
{
    use FeatureTestTrait;

    protected function setUp(): void
    {
        parent::setUp();
        session()->set('user_token', 'dummy_token');
        session()->set('user_role', 'ADMIN');
    }

    public function testViewOrders()
    {
        $result = $this->get('/admin/orders');
        $result->assertStatus(200);
        $result->assertSee('Order Management');
    }

    public function testUpdateOrderStatus()
    {
        $result = $this->post('/admin/orders/status/1', [
            'orderStatus' => 'processing'
        ]);
        $result->assertRedirectTo('/admin/orders');
    }
}
