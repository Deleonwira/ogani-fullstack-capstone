<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Notifications<?= $this->endSection() ?>
<?= $this->section('content') ?>
<div class="mb-8 flex justify-between items-end">
    <div>
        <h2 class="font-headline-lg text-headline-lg text-on-surface">Semua Notifikasi</h2>
        <p class="font-body-md text-body-md text-on-surface-variant mt-1">Pusat pemberitahuan sistem Ogani.</p>
    </div>
    <button class="px-4 py-2 text-primary bg-primary-container/20 hover:bg-primary-container/40 rounded-lg font-label-md transition-colors">
        Tandai Semua Dibaca
    </button>
</div>

<div class="bg-surface-container-lowest rounded-xl shadow-[0px_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/30 overflow-hidden">
    <?php if (empty($notifications)): ?>
        <!-- Data dummy karena API belum tersedia -->
        <div class="p-6 border-b border-outline-variant/30 hover:bg-surface-container-low transition-colors bg-surface-container-low/50">
            <div class="flex items-start gap-4">
                <div class="w-10 h-10 rounded-full bg-primary-container/30 text-primary flex items-center justify-center flex-shrink-0">
                    <span class="material-symbols-outlined text-[20px]">shopping_cart</span>
                </div>
                <div class="flex-1">
                    <div class="flex justify-between items-start">
                        <h4 class="font-title-md text-on-surface">Pesanan Baru Diterima!</h4>
                        <span class="text-xs text-on-surface-variant font-medium">Baru saja</span>
                    </div>
                    <p class="text-body-md text-on-surface-variant mt-1">Pesanan #1234 dari John Doe sejumlah Rp 250.000 menunggu konfirmasi Anda.</p>
                </div>
            </div>
        </div>
        
        <div class="p-6 border-b border-outline-variant/30 hover:bg-surface-container-low transition-colors bg-surface-container-low/50">
            <div class="flex items-start gap-4">
                <div class="w-10 h-10 rounded-full bg-error-container/30 text-error flex items-center justify-center flex-shrink-0">
                    <span class="material-symbols-outlined text-[20px]">inventory_2</span>
                </div>
                <div class="flex-1">
                    <div class="flex justify-between items-start">
                        <h4 class="font-title-md text-on-surface">Stok Produk Menipis</h4>
                        <span class="text-xs text-on-surface-variant font-medium">2 jam yang lalu</span>
                    </div>
                    <p class="text-body-md text-on-surface-variant mt-1">Produk "Tomat Organik" saat ini hanya tersisa 5 item. Segera lakukan restock.</p>
                </div>
            </div>
        </div>
        
        <div class="p-6 border-b border-outline-variant/30 hover:bg-surface-container-low transition-colors">
            <div class="flex items-start gap-4">
                <div class="w-10 h-10 rounded-full bg-secondary-container/30 text-secondary flex items-center justify-center flex-shrink-0">
                    <span class="material-symbols-outlined text-[20px]">person_add</span>
                </div>
                <div class="flex-1">
                    <div class="flex justify-between items-start">
                        <h4 class="font-title-md text-on-surface">Pengguna Baru Terdaftar</h4>
                        <span class="text-xs text-on-surface-variant font-medium">Kemarin</span>
                    </div>
                    <p class="text-body-md text-on-surface-variant mt-1">Jane Smith telah mendaftar sebagai pelanggan baru.</p>
                </div>
            </div>
        </div>
    <?php else: ?>
        <?php foreach ($notifications as $notif): ?>
            <div class="p-6 border-b border-outline-variant/30 hover:bg-surface-container-low transition-colors">
                <div class="flex items-start gap-4">
                    <div class="w-10 h-10 rounded-full bg-surface-variant text-on-surface flex items-center justify-center flex-shrink-0">
                        <span class="material-symbols-outlined text-[20px]">notifications</span>
                    </div>
                    <div class="flex-1">
                        <div class="flex justify-between items-start">
                            <h4 class="font-title-md text-on-surface"><?= esc($notif['title'] ?? 'Notification') ?></h4>
                            <span class="text-xs text-on-surface-variant font-medium"><?= esc($notif['created_at'] ?? '') ?></span>
                        </div>
                        <p class="text-body-md text-on-surface-variant mt-1"><?= esc($notif['message'] ?? '') ?></p>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    <?php endif; ?>
</div>
<?= $this->endSection() ?>
