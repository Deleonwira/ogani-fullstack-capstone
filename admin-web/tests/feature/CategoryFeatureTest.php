<?php

namespace Tests\Feature;

use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class CategoryFeatureTest extends CIUnitTestCase
{
    use FeatureTestTrait;

    protected function setUp(): void
    {
        parent::setUp();
        session()->set('user_token', 'dummy_token');
        session()->set('user_role', 'ADMIN');
    }

    public function testViewCategories()
    {
        $result = $this->get('/admin/categories');
        $result->assertStatus(200);
        $result->assertSee('Categories');
    }
}
