<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>My Profile<?= $this->endSection() ?>
<?= $this->section('content') ?>
<!-- Page Header -->
<div class="mb-8">
    <h2 class="font-headline-lg text-headline-lg text-on-surface">Profil Saya</h2>
    <p class="font-body-md text-body-md text-on-surface-variant mt-1">Kelola informasi profil Anda.</p>
</div>

<!-- Profile Content -->
<div class="bg-surface-container-lowest rounded-xl p-8 shadow-[0px_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 max-w-4xl">
    <div class="flex items-center gap-6 mb-8 pb-8 border-b border-outline-variant/30">
        <img alt="Admin Avatar" class="w-24 h-24 rounded-full border-2 border-primary/20 shadow-sm object-cover" src="<?= !empty($user['avatarUrl']) ? esc($user['avatarUrl']) : 'https://lh3.googleusercontent.com/aida-public/AB6AXuC-IjZFOb4GkfGOOqthIQzAi82--oIukR6oKBe5XX5D8H4E3DF2J63j5akRvVcX5WxA6kLzyiwypP5Fa3ajLiW6MMbepzK2vzo9h-xylwqCg2lfYrUclHlR8lB73TCELeA7i6GzcDfi8ZfxpE8kry1PmdTBG6ofPEpTv0NdSfOLMPaZBb3TGrItnBf13YwJo-JHj_P1XnK_dU6y5STP3XvwHC85a7mGFfzBXXZh7-E95SmsWZ2p_CFMQD6i5r5JGVHI8GP46EDjKNFo' ?>"/>
        <div>
            <h3 class="font-headline-sm text-headline-sm text-on-surface"><?= esc($user['fullName'] ?? 'Admin') ?></h3>
            <p class="font-body-md text-body-md text-on-surface-variant mt-1">Peran: <?= esc($user['role'] ?? 'Administrator') ?></p>
        </div>
    </div>
    
    <form id="profileForm" class="space-y-6">
        <div id="alertMessage" class="hidden p-3 rounded-lg text-sm font-medium mb-4"></div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Nama Lengkap</label>
                <input type="text" name="fullName" value="<?= esc($user['fullName'] ?? '') ?>" class="w-full h-12 px-4 bg-surface-container-low border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all">
            </div>
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Nama Pengguna (Username)</label>
                <input type="text" name="username" value="<?= esc($user['username'] ?? '') ?>" class="w-full h-12 px-4 bg-surface-container-low border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all">
            </div>
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Alamat Email</label>
                <input type="email" name="email" value="<?= esc($user['email'] ?? '') ?>" class="w-full h-12 px-4 bg-surface-container-low border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all">
            </div>
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Nomor Telepon</label>
                <input type="text" name="phoneNumber" value="<?= esc($user['phoneNumber'] ?? '') ?>" class="w-full h-12 px-4 bg-surface-container-low border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all">
            </div>
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Tanggal Lahir</label>
                <input type="date" name="birthDate" value="<?= esc($user['birthDate'] ?? '') ?>" class="w-full h-12 px-4 bg-surface-container-low border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all">
            </div>
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Umur</label>
                <input type="text" readonly value="<?= esc($user['age'] ?? '-') ?> Tahun" class="w-full h-12 px-4 bg-surface-container-highest border border-outline-variant/30 rounded-lg font-body-md text-body-md text-on-surface-variant cursor-not-allowed">
                <p class="text-xs text-on-surface-variant mt-1">Dihitung otomatis dari tanggal lahir.</p>
            </div>
        </div>

        <div>
            <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Alamat</label>
            <textarea name="address" rows="3" class="w-full p-4 bg-surface-container-low border border-outline-variant/50 rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary/50 transition-all"><?= esc($user['address'] ?? '') ?></textarea>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 pt-4 border-t border-outline-variant/30">
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Total Pesanan</label>
                <input type="text" readonly value="<?= esc($user['totalOrders'] ?? '0') ?>" class="w-full h-12 px-4 bg-surface-container-highest border border-outline-variant/30 rounded-lg font-body-md text-body-md text-on-surface-variant cursor-not-allowed font-bold">
            </div>
            <div>
                <label class="block font-label-md text-label-md text-on-surface-variant mb-2">Total Poin</label>
                <input type="text" readonly value="<?= esc($user['totalPoints'] ?? '0') ?>" class="w-full h-12 px-4 bg-surface-container-highest border border-outline-variant/30 rounded-lg font-body-md text-body-md text-on-surface-variant cursor-not-allowed font-bold text-primary">
            </div>
        </div>
        
        <div class="mt-8 pt-4">
            <button type="submit" id="submitBtn" class="px-8 py-3 bg-primary text-on-primary rounded-lg font-label-lg text-label-lg hover:bg-surface-tint transition-colors shadow-sm">
                Simpan Perubahan
            </button>
        </div>
    </form>
</div>

<script>
document.getElementById('profileForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    const alertMsg = document.getElementById('alertMessage');
    const submitBtn = document.getElementById('submitBtn');
    
    const formData = new FormData(this);
    const data = Object.fromEntries(formData.entries());

    submitBtn.disabled = true;
    submitBtn.innerHTML = '<span class="material-symbols-outlined animate-spin text-[18px] align-middle">progress_activity</span> Menyimpan...';
    
    try {
        const response = await fetch('/admin/profile/update', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify(data)
        });
        
        const result = await response.json();
        if (response.ok) {
            showAlert('Profil berhasil diperbarui!', 'success');
            // Update the display name in the page without refresh if possible, or wait for next load
            if (result.data && result.data.fullName) {
                document.querySelector('h3.font-headline-sm').textContent = result.data.fullName;
                // Update age if returned
                if (result.data.age) {
                    document.querySelector('input[value*="Tahun"]').value = result.data.age + ' Tahun';
                }
            }
        } else {
            showAlert(result.message || 'Gagal memperbarui profil.', 'error');
        }
    } catch (error) {
        showAlert('Terjadi kesalahan koneksi.', 'error');
    } finally {
        submitBtn.disabled = false;
        submitBtn.innerHTML = 'Simpan Perubahan';
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
