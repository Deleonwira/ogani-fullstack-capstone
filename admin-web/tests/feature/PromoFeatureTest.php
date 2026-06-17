<?php

namespace Tests\Feature;

use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class PromoFeatureTest extends CIUnitTestCase
{
    use FeatureTestTrait;

    protected function setUp(): void
    {
        parent::setUp();
        session()->set('user_token', 'dummy_token');
        session()->set('user_role', 'ADMIN');
    }

    public function testViewPromos()
    {
        $result = $this->get('/admin/promos');
        $result->assertStatus(200);
        $result->assertSee('Promotions');
    }
}
