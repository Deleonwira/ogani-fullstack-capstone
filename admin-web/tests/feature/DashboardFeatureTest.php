<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class DashboardFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewDashboardAllTime() { // CI-07
        $result = $this->withSession($this->sess())->get('/admin/dashboard');
        $result->assertStatus(200);
    }
    public function testFilterDashboardLast7Days() { // CI-08
        $result = $this->withSession($this->sess())->get('/admin/dashboard?days=7');
        $result->assertStatus(200);
    }
    public function testExportCSV() { // CI-09
        $result = $this->withSession($this->sess())->get('/admin/dashboard/exportCsv');
        $result->assertStatus(200);
    }
    public function testPrintPDF() { // CI-10
        $result = $this->withSession($this->sess())->get('/admin/dashboard/printReport');
        $result->assertStatus(200);
    }
}