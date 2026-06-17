<?php

namespace Tests\Feature;

use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class SettingsFeatureTest extends CIUnitTestCase
{
    use FeatureTestTrait;

    protected function setUp(): void
    {
        parent::setUp();
        session()->set('user_token', 'dummy_token');
        session()->set('user_role', 'ADMIN');
    }

    public function testViewSettings()
    {
        $result = $this->get('/admin/settings');
        $result->assertStatus(200);
        $result->assertSee('Pengaturan Sistem');
    }

    public function testGlobalSearch()
    {
        // AJAX test
        $result = $this->withHeaders([
            'X-Requested-With' => 'XMLHttpRequest'
        ])->get('/admin/search?q=apple');
        
        $result->assertStatus(200);
    }
}
