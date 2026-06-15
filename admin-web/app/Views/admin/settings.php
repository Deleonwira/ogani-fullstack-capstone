<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Settings<?= $this->endSection() ?>
<?= $this->section('content') ?>
<div class="mb-8">
    <h2 class="font-headline-lg text-headline-lg text-on-surface">Pengaturan Sistem</h2>
    <p class="font-body-md text-body-md text-on-surface-variant mt-1">Kelola konfigurasi platform Ogani.</p>
</div>

<div class="max-w-2xl">
    <!-- Security Settings -->
    <div class="bg-surface-container-lowest rounded-xl p-6 shadow-[0px_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30">
        <h3 class="font-title-lg text-title-lg text-on-surface border-b border-outline-variant/30 pb-4 mb-6">Keamanan & Sandi</h3>
        
        <form id="passwordForm" class="space-y-4">
            <div id="alertMessage" class="hidden p-3 rounded-lg text-sm font-medium mb-4"></div>
            
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Sandi Saat Ini</label>
                <input type="password" name="currentPassword" id="currentPassword" required class="w-full h-10 px-4 bg-surface-container-lowest border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all">
            </div>
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Sandi Baru</label>
                <input type="password" name="newPassword" id="newPassword" required class="w-full h-10 px-4 bg-surface-container-lowest border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all">
            </div>
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Konfirmasi Sandi Baru</label>
                <input type="password" name="confirmPassword" id="confirmPassword" required class="w-full h-10 px-4 bg-surface-container-lowest border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all">
            </div>
            <div class="pt-4">
                <button type="submit" id="submitBtn" class="px-6 py-2 bg-primary text-on-primary rounded-lg font-label-md text-label-md hover:bg-surface-tint transition-colors shadow-sm w-full">
                    Perbarui Kata Sandi
                </button>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById('passwordForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    const currentPassword = document.getElementById('currentPassword').value;
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const alertMsg = document.getElementById('alertMessage');
    const submitBtn = document.getElementById('submitBtn');

    if (newPassword !== confirmPassword) {
        showAlert('Sandi baru dan konfirmasi tidak cocok!', 'error');
        return;
    }

    submitBtn.disabled = true;
    submitBtn.innerHTML = '<span class="material-symbols-outlined animate-spin text-[18px] align-middle">progress_activity</span> Menyimpan...';
    
    try {
        const response = await fetch('/admin/settings/password', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({ currentPassword, newPassword })
        });
        
        const result = await response.json();
        if (response.ok) {
            showAlert('Kata sandi berhasil diperbarui!', 'success');
            this.reset();
        } else {
            showAlert(result.message || 'Gagal memperbarui sandi.', 'error');
        }
    } catch (error) {
        showAlert('Terjadi kesalahan koneksi.', 'error');
    } finally {
        submitBtn.disabled = false;
        submitBtn.innerHTML = 'Perbarui Kata Sandi';
    }
});

function showAlert(message, type) {
    const alertMsg = document.getElementById('alertMessage');
    alertMsg.textContent = message;
    alertMsg.classList.remove('hidden', 'bg-error-container', 'text-error', 'bg-primary-container', 'text-primary');
    
    if (type === 'error') {
        alertMsg.classList.add('bg-error-container', 'text-error');
    } else {
        alertMsg.classList.add('bg-primary-container', 'text-primary');
    }
}
</script>
<?= $this->endSection() ?>
