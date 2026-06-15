<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Promotions<?= $this->endSection() ?>
<?= $this->section('content') ?>
<div class="mb-8 flex justify-between items-center">
    <div>
        <h2 class="font-headline-lg text-headline-lg text-on-surface">Promotions</h2>
        <p class="font-body-md text-body-md text-on-surface-variant mt-1">Manage discount codes and promos.</p>
    </div>
    <button class="bg-[#4CAF50] hover:bg-primary text-on-primary px-6 py-2.5 rounded-lg flex items-center gap-2">
        <span class="material-symbols-outlined" style="font-size: 20px;">add</span> Add Promo
    </button>
</div>
<div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant/50 overflow-hidden">
    <table class="w-full text-left border-collapse">
        <thead>
            <tr class="bg-surface-container-low/50">
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Promo Code</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Discount Type</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Value</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Valid Until</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Status</th>
            </tr>
        </thead>
        <tbody class="divide-y divide-outline-variant/30">
        <?php if (!empty($promos)): ?>
            <?php foreach ($promos as $p): ?>
                <tr class="hover:bg-surface-container-lowest transition-colors group">
                    <td class="py-4 px-6 font-title-md text-primary"><?= esc($p['promoCode'] ?? 'N/A') ?></td>
                    <td class="py-4 px-6"><?= esc($p['discountType'] ?? 'N/A') ?></td>
                    <td class="py-4 px-6"><?= esc($p['discountValue'] ?? 0) ?></td>
                    <td class="py-4 px-6"><?= esc($p['endDate'] ?? 'N/A') ?></td>
                    <td class="py-4 px-6">
                        <span class="px-2.5 py-0.5 rounded-full font-label-sm bg-primary-container/10 text-primary">Active</span>
                    </td>
                </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr><td colspan="5" class="text-center py-8">No promos found.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
</div>
<?= $this->endSection() ?>
