<?php

namespace Tests\Feature;

use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class UserFeatureTest extends CIUnitTestCase
{
    use FeatureTestTrait;

    protected function setUp(): void
    {
        parent::setUp();
        session()->set('user_token', 'dummy_token');
        session()->set('user_role', 'ADMIN');
    }

    public function testViewUsers()
    {
        $result = $this->get('/admin/users');
        $result->assertStatus(200);
        $result->assertSee('Delivery & Users');
    }

    public function testUpdateUserRole()
    {
        $result = $this->post('/admin/users/role/2', [
            'role' => 'ADMIN'
        ]);
        $result->assertRedirectTo('/admin/users');
    }
}
