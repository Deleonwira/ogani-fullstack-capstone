<?php
$dir = 'd:\FATHUR\Documents\Perkuliahan\Kelas CCIT\Semester 4\Phase 2\Capstone Project\ogani-fullstack-capstone\admin-web\tests\feature';
$files = glob($dir . '/*FeatureTest.php');
foreach ($files as $file) {
    if (basename($file) == 'AuthFeatureTest.php' || basename($file) == 'CategoryFeatureTest.php') continue;
    $content = file_get_contents($file);
    $content = preg_replace('/session\(\)->set\([^\)]+\);\s*/', '', $content);
    $content = str_replace('$result = $this->get(', '$result = $this->withSession([\'isLoggedIn\' => true, \'token\' => \'dummy_token\', \'role\' => \'ADMIN\'])->get(', $content);
    $content = str_replace('$result = $this->post(', '$result = $this->withSession([\'isLoggedIn\' => true, \'token\' => \'dummy_token\', \'role\' => \'ADMIN\'])->post(', $content);
    file_put_contents($file, $content);
}
echo "Done.";
