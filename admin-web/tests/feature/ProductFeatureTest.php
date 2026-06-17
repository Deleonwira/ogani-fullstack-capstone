<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class ProductFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewProducts() { // CI-11
        $result = $this->withSession($this->sess())->get('/admin/products');
        $result->assertStatus(200);
    }
    public function testSearchProduct() { // CI-12
        $result = $this->withSession($this->sess())->get('/admin/products?search=Apple');
        $result->assertStatus(200);
    }
    public function testFilterProductByCategory() { // CI-13
        $result = $this->withSession($this->sess())->get('/admin/products?categoryId=1');
        $result->assertStatus(200);
    }
    public function testAddProduct() { // CI-14
        $result = $this->withSession($this->sess())->post('/admin/products/save', ['productName'=>'New', 'price'=>10]);
        $result->assertRedirect();
    }
    public function testEditProduct() { // CI-15
        $result = $this->withSession($this->sess())->post('/admin/products/save', ['productId'=>1, 'productName'=>'Edit', 'price'=>20]);
        $result->assertRedirect();
    }
    public function testDeleteProduct() { // CI-16
        $result = $this->withSession($this->sess())->get('/admin/products/delete/1');
        $result->assertRedirect();
    }
}