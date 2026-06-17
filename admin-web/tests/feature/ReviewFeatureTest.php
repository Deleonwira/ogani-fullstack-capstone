<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class ReviewFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewReviews() { // CI-32
        $result = $this->withSession($this->sess())->get('/admin/reviews');
        $result->assertStatus(200);
    }
    // CI-33 (Delete Review) is purposely skipped as agreed!
}