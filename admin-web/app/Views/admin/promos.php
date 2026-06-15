<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Promotions<?= $this->endSection() ?>
<?= $this->section('content') ?>
<div class="mb-8 flex justify-between items-center">
    <div>
        <h2 class="font-headline-lg text-headline-lg text-on-surface">Promotions</h2>
        <p class="font-body-md text-body-md text-on-surface-variant mt-1">Manage discount codes and promos.</p>
    </div>
    <button onclick="openModal()" class="bg-[#4CAF50] hover:bg-primary text-on-primary px-6 py-2.5 rounded-lg flex items-center gap-2">
        <span class="material-symbols-outlined" style="font-size: 20px;">add</span> Add Promo
    </button>
</div>
<div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant/50 overflow-hidden">
    <table class="w-full text-left border-collapse">
        <thead>
            <tr class="bg-surface-container-low/50">
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Promo Code</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Title</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Minimum Spend</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Valid Until</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Status</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50 text-right">Actions</th>
            </tr>
        </thead>
        <tbody class="divide-y divide-outline-variant/30">
        <?php if (!empty($promos)): ?>
            <?php foreach ($promos as $p): ?>
                <tr class="hover:bg-surface-container-lowest transition-colors group">
                    <td class="py-4 px-6 font-title-md text-primary"><?= esc($p['promoCode'] ?? 'N/A') ?></td>
                    <td class="py-4 px-6"><?= esc($p['title'] ?? 'N/A') ?> <span class="font-medium text-primary">Rp <?= number_format($p['discountAmount'] ?? 0, 0, ',', '.') ?> Off</span></td>
                    <td class="px-6 py-4 whitespace-nowrap text-on-surface-variant font-body-md text-body-md">Min. Rp <?= number_format($p['minimumSpend'] ?? 0, 0, ',', '.') ?></td>
                    <td class="py-4 px-6"><?= date('M d, Y', strtotime($p['expirationDate'] ?? 'now')) ?></td>
                    <td class="py-4 px-6">
                        <span class="px-2.5 py-0.5 rounded-full font-label-sm bg-primary-container/10 text-primary">Active</span>
                    </td>
                    <td class="py-4 px-6 text-right">
                        <button onclick="openModal('<?= esc($p['promoId'] ?? '') ?>', '<?= esc($p['promoCode'] ?? '') ?>', '<?= esc($p['title'] ?? '') ?>', '<?= esc($p['discountValue'] ?? '') ?>', '<?= esc($p['minimumSpend'] ?? '') ?>', '<?= esc($p['expirationDate'] ?? '') ?>')" aria-label="Edit" class="text-on-surface-variant hover:text-primary p-1 rounded transition-colors">
                            <span class="material-symbols-outlined" style="font-size: 20px;">edit</span>
                        </button>
                        <a href="<?= base_url('admin/promos/delete/' . esc($p['promoId'])) ?>" onclick="return confirm('Delete this promo?')" aria-label="Delete" class="text-on-surface-variant hover:text-error p-1 rounded transition-colors">
                            <span class="material-symbols-outlined" style="font-size: 20px;">delete</span>
                        </a>
                    </td>
                </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr><td colspan="5" class="text-center py-8">No promos found.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div id="promoModal" class="hidden fixed inset-0 bg-black/50 z-50 flex items-center justify-center overflow-y-auto">
    <div class="bg-surface rounded-xl shadow-lg w-full max-w-2xl p-6 m-4 mt-20">
        <h3 id="modalTitle" class="text-title-lg font-title-lg mb-4 text-on-surface">Add Promo</h3>
        <form action="<?= base_url('admin/promos/save') ?>" method="POST">
            <input type="hidden" name="id" id="promoId">
            <div class="grid grid-cols-2 gap-4">
                <div class="mb-4">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Promo Code</label>
                    <input type="text" name="promoCode" id="promoCode" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                </div>
                <div class="mb-4">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Title</label>
                    <input type="text" name="title" id="title" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                </div>
                <div class="mb-4">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Discount Value (Rp)</label>
                    <input type="number" name="discountValue" id="discountValue" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                </div>
                <div class="mb-4">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Minimum Spend (Rp)</label>
                    <input type="number" name="minimumSpend" id="minimumSpend" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                </div>
                <div class="mb-4 col-span-2">
                    <label class="block text-label-md mb-1 text-on-surface-variant">Expiration Date</label>
                    <input type="datetime-local" name="expirationDate" id="expirationDate" class="w-full bg-surface-container-lowest border border-outline-variant rounded-lg p-2 text-on-surface focus:border-primary outline-none" required>
                </div>
            </div>
            <div class="flex justify-end gap-3 mt-6">
                <button type="button" onclick="closeModal()" class="px-4 py-2 border border-outline-variant rounded-lg text-on-surface-variant hover:bg-surface-container-low transition-colors font-label-md">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-primary text-on-primary rounded-lg shadow-sm hover:shadow transition-shadow font-label-md">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
function openModal(id = '', code = '', title = '', discount = '', minSpend = '', expDate = '') {
    document.getElementById('promoId').value = id;
    document.getElementById('promoCode').value = code;
    document.getElementById('title').value = title;
    document.getElementById('discountValue').value = discount;
    document.getElementById('minimumSpend').value = minSpend;
    if(expDate) {
        document.getElementById('expirationDate').value = new Date(expDate).toISOString().slice(0, 16);
    } else {
        document.getElementById('expirationDate').value = '';
    }
    document.getElementById('modalTitle').innerText = id ? 'Edit Promo' : 'Add Promo';
    document.getElementById('promoModal').classList.remove('hidden');
}
function closeModal() {
    document.getElementById('promoModal').classList.add('hidden');
}
</script>
<?= $this->endSection() ?>
