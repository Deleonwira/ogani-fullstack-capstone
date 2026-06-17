<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class CategoryFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewCategories() { // CI-17
        $result = $this->withSession($this->sess())->get('/admin/categories');
        $result->assertStatus(200);
    }
    public function testAddCategory() { // CI-18
        $result = $this->withSession($this->sess())->post('/admin/categories/save', ['categoryName'=>'New']);
        $result->assertRedirect();
    }
    public function testEditCategory() { // CI-19
        $result = $this->withSession($this->sess())->post('/admin/categories/save', ['categoryId'=>1, 'categoryName'=>'Edit']);
        $result->assertRedirect();
    }
    public function testDeleteCategory() { // CI-20
        $result = $this->withSession($this->sess())->get('/admin/categories/delete/1');
        $result->assertRedirect();
    }
}