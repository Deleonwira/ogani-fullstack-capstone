<?php

namespace Tests\Feature;

use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class ProductFeatureTest extends CIUnitTestCase
{
    use FeatureTestTrait;

    protected function setUp(): void
    {
        parent::setUp();
        session()->set('user_token', 'dummy_token');
        session()->set('user_role', 'ADMIN');
    }

    public function testViewProducts()
    {
        $result = $this->get('/admin/products');
        $result->assertStatus(200);
        $result->assertSee('Product Inventory');
    }

    public function testAddProduct()
    {
        $result = $this->post('/admin/products/save', [
            'product_name' => 'New Product Test',
            'price' => '10000',
            'stock' => '50',
            'unit' => 'kg',
            'weight_per_unit' => '1',
            'product_status' => 'In Stock',
            'category_id' => '1'
        ]);
        
        // Asumsi redirect back ke halaman products
        $result->assertRedirectTo('/admin/products');
    }
}
