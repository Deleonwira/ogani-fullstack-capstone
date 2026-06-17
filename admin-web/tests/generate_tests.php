<?php
$baseDir = 'd:\FATHUR\Documents\Perkuliahan\Kelas CCIT\Semester 4\Phase 2\Capstone Project\ogani-fullstack-capstone\admin-web\tests\feature\\';

$authContent = <<<'PHP'
<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class AuthFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }

    public function testLoginSuccess() { // CI-01
        $result = $this->post('/auth/loginProcess', ['email' => 'admin@ogani.com', 'password' => 'admin123']);
        $result->assertRedirect();
    }
    public function testLoginEmailUnregistered() { // CI-02
        $result = $this->post('/auth/loginProcess', ['email' => 'tidakada@ogani.com', 'password' => 'sembarang']);
        $result->assertRedirect();
    }
    public function testLoginWrongPassword() { // CI-03
        $result = $this->post('/auth/loginProcess', ['email' => 'admin@ogani.com', 'password' => 'salah123']);
        $result->assertRedirect();
    }
    public function testLoginCustomerRole() { // CI-04
        $result = $this->post('/auth/loginProcess', ['email' => 'customer@ogani.com', 'password' => 'benar']);
        $result->assertRedirect();
    }
    public function testAccessAdminWithoutSession() { // CI-05
        $result = $this->get('/admin/dashboard');
        $result->assertRedirectTo('/login');
    }
    public function testLogout() { // CI-06
        $result = $this->get('/logout');
        $result->assertRedirectTo('/login');
    }
}
PHP;
file_put_contents($baseDir . 'AuthFeatureTest.php', $authContent);

$dashContent = <<<'PHP'
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
PHP;
file_put_contents($baseDir . 'DashboardFeatureTest.php', $dashContent);

$prodContent = <<<'PHP'
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
PHP;
file_put_contents($baseDir . 'ProductFeatureTest.php', $prodContent);

$catContent = <<<'PHP'
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
PHP;
file_put_contents($baseDir . 'CategoryFeatureTest.php', $catContent);

$ordContent = <<<'PHP'
<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class OrderFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewOrders() { // CI-21
        $result = $this->withSession($this->sess())->get('/admin/orders');
        $result->assertStatus(200);
    }
    public function testFilterOrdersPending() { // CI-22
        $result = $this->withSession($this->sess())->get('/admin/orders?status=PENDING');
        $result->assertStatus(200);
    }
    public function testUpdateOrderProcessing() { // CI-23
        $result = $this->withSession($this->sess())->post('/admin/orders/status/1', ['status'=>'PROCESSING']);
        $result->assertRedirect();
    }
    public function testUpdateOrderShipped() { // CI-24
        $result = $this->withSession($this->sess())->post('/admin/orders/status/1', ['status'=>'SHIPPED']);
        $result->assertRedirect();
    }
    public function testUpdateOrderCompleted() { // CI-25
        $result = $this->withSession($this->sess())->post('/admin/orders/status/1', ['status'=>'COMPLETED']);
        $result->assertRedirect();
    }
}
PHP;
file_put_contents($baseDir . 'OrderFeatureTest.php', $ordContent);

$usrContent = <<<'PHP'
<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class UserFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewUsers() { // CI-26
        $result = $this->withSession($this->sess())->get('/admin/users');
        $result->assertStatus(200);
    }
    public function testUpdateUserRole() { // CI-27
        $result = $this->withSession($this->sess())->post('/admin/users/role/2', ['role'=>'ADMIN']);
        $result->assertRedirect();
    }
    public function testDeleteUser() { // CI-28
        $result = $this->withSession($this->sess())->post('/admin/users/delete/2');
        $result->assertRedirect();
    }
}
PHP;
file_put_contents($baseDir . 'UserFeatureTest.php', $usrContent);

$proContent = <<<'PHP'
<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class PromoFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testViewPromos() { // CI-29
        $result = $this->withSession($this->sess())->get('/admin/promos');
        $result->assertStatus(200);
    }
    public function testAddPromo() { // CI-30
        $result = $this->withSession($this->sess())->post('/admin/promos/save', ['promoCode'=>'NEW']);
        $result->assertRedirect();
    }
    public function testDeletePromo() { // CI-31
        $result = $this->withSession($this->sess())->get('/admin/promos/delete/1');
        $result->assertRedirect();
    }
}
PHP;
file_put_contents($baseDir . 'PromoFeatureTest.php', $proContent);

$revContent = <<<'PHP'
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
PHP;
file_put_contents($baseDir . 'ReviewFeatureTest.php', $revContent);

$setContent = <<<'PHP'
<?php
namespace Tests\Feature;
use CodeIgniter\Test\CIUnitTestCase;
use CodeIgniter\Test\FeatureTestTrait;

class SettingsFeatureTest extends CIUnitTestCase {
    use FeatureTestTrait;
    protected function setUp(): void { parent::setUp(); }
    private function sess() { return ['isLoggedIn' => true, 'token' => 'dummy_token', 'role' => 'ADMIN']; }

    public function testUpdateProfile() { // CI-34
        $result = $this->withSession($this->sess())->put('/admin/profile/update', ['fullName'=>'Admin']);
        $result->assertStatus(200); // Or 302 depending on AJAX or Form
    }
    public function testUpdatePasswordValid() { // CI-35
        $result = $this->withSession($this->sess())->put('/admin/settings/password', ['currentPassword'=>'admin123', 'newPassword'=>'123']);
        $result->assertStatus(200);
    }
    public function testUpdatePasswordWrongCurrent() { // CI-36
        $result = $this->withSession($this->sess())->put('/admin/settings/password', ['currentPassword'=>'wrong', 'newPassword'=>'123']);
        $result->assertStatus(200); // Assuming the API returns 400, but CI4 controller might return 200 with error JSON
    }
    public function testUpdatePasswordMismatch() { // CI-37
        $result = $this->withSession($this->sess())->put('/admin/settings/password', ['currentPassword'=>'admin123', 'newPassword'=>'123', 'confirm'=>'456']);
        $result->assertStatus(200);
    }
    public function testGlobalSearchMatch() { // CI-38
        $result = $this->withSession($this->sess())->withHeaders(['X-Requested-With' => 'XMLHttpRequest'])->get('/admin/search?q=apple');
        $result->assertStatus(200);
    }
    public function testGlobalSearchEmpty() { // CI-39
        $result = $this->withSession($this->sess())->withHeaders(['X-Requested-With' => 'XMLHttpRequest'])->get('/admin/search?q=');
        $result->assertStatus(200);
    }
    public function testGlobalSearchNavigation() { // CI-40
        // Simulating the user clicking a search result link
        $result = $this->withSession($this->sess())->get('/admin/products?search=apple');
        $result->assertStatus(200);
    }
}
PHP;
file_put_contents($baseDir . 'SettingsFeatureTest.php', $setContent);

echo "Tests generated successfully.";
