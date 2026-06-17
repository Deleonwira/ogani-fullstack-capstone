<?php

namespace Tests\Feature;

use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class DashboardFeatureTest extends CIUnitTestCase
{
    use FeatureTestTrait;

    protected function setUp(): void
    {
        parent::setUp();
        session()->set('user_token', 'dummy_token');
        session()->set('user_role', 'ADMIN');
    }

    public function testViewDashboardAllTime()
    {
        $result = $this->get('/admin/dashboard');
        $result->assertStatus(200);
        $result->assertSee('Dashboard Overview');
    }

    public function testExportCSV()
    {
        $result = $this->get('/admin/dashboard/exportCsv');
        $result->assertStatus(200);
        $result->assertHeader('Content-Type', 'text/csv; charset=UTF-8');
    }
}
