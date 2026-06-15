<?= $this->extend('layouts/admin') ?>
<?= $this->section('title') ?>Reviews<?= $this->endSection() ?>
<?= $this->section('content') ?>
<div class="mb-8 flex justify-between items-center">
    <div>
        <h2 class="font-headline-lg text-headline-lg text-on-surface">Reviews</h2>
        <p class="font-body-md text-body-md text-on-surface-variant mt-1">Monitor product reviews.</p>
    </div>
</div>
<div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant/50 overflow-hidden">
    <table class="w-full text-left border-collapse">
        <thead>
            <tr class="bg-surface-container-low/50">
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Product</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Customer</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Rating</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50">Comment</th>
                <th class="py-4 px-6 font-label-md text-label-md text-on-surface-variant border-b border-outline-variant/50 text-right">Actions</th>
            </tr>
        </thead>
        <tbody class="divide-y divide-outline-variant/30">
        <?php if (!empty($reviews)): ?>
            <?php foreach ($reviews as $r): ?>
                <tr class="hover:bg-surface-container-lowest transition-colors group">
                    <td class="py-4 px-6 font-title-md"><?= esc($r['product']['productName'] ?? 'Unknown Product') ?></td>
                    <td class="py-4 px-6"><?= esc($r['user']['fullName'] ?? $r['user']['username'] ?? 'Unknown User') ?></td>
                    <td class="py-4 px-6 font-bold text-tertiary">⭐ <?= esc($r['rating'] ?? 0) ?></td>
                    <td class="py-4 px-6 max-w-xs truncate"><?= esc($r['comment'] ?? '') ?></td>
                    <td class="py-4 px-6 text-right">
                        <button class="text-error hover:bg-error-container/10 p-2 rounded-full"><span class="material-symbols-outlined">delete</span></button>
                    </td>
                </tr>
            <?php endforeach; ?>
        <?php else: ?>
            <tr><td colspan="5" class="text-center py-8">No reviews found.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
</div>
<?= $this->endSection() ?>
